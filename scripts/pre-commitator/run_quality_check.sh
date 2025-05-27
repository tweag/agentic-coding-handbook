#!/bin/bash
#
# Pre-Commitator Quality Check Script
#
# This script runs code quality checks on files with multiple options for
# validating staged files, all files, or specific files.
#
# Usage:
#   ./run_quality_check.sh [options] [files...]
#
# Author: Pre-Commitator Team
# Version: 1.0.0
#

set -o pipefail  # Ensure script fails if any command in a pipeline fails

# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source .env file if it exists (for mode-specific settings)
if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
    # Export to make it available to Python subprocess
    export DISABLE_ESLINT
    export DISABLE_LIZARD
    export DISABLE_BANDIT
    export DISABLE_SEMGREP
fi

#----------------------------------------------------------------------
# Configuration
#----------------------------------------------------------------------

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
QUALITY_GATE="${SCRIPT_DIR}/src/quality_gate.py"

#----------------------------------------------------------------------
# Helper Functions
#----------------------------------------------------------------------

# Display usage information
usage() {
    echo -e "${BOLD}Pre-Commitator${NC} - Code Quality & Security Validator"
    echo ""
    echo -e "${BOLD}Usage:${NC}"
    echo "  ./run_quality_check.sh [options] [files...]"
    echo ""
    echo -e "${BOLD}Options:${NC}"
    echo "  -h, --help     Show this help message"
    echo "  -s, --staged   Check only staged files (default if no files provided)"
    echo "  -a, --all      Check all files in the repository"
    echo "  -v, --verbose  Show more detailed output"
    echo "  -q, --quiet    Show minimal output"
    echo ""
    echo -e "${BOLD}Examples:${NC}"
    echo "  ./run_quality_check.sh                   # Check staged files"
    echo "  ./run_quality_check.sh -s                # Check staged files (explicit)"
    echo "  ./run_quality_check.sh -a                # Check all files"
    echo "  ./run_quality_check.sh src/file1.py src/file2.js  # Check specific files"
}

# Check if current directory is a git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

# Display progress message
show_progress() {
    if [ "$QUIET" = false ]; then
        echo -e "${YELLOW}$1${NC}"
    fi
}

# Check if a command is available
command_exists() {
    command -v "$1" &> /dev/null
}

# Show error message and exit
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    echo -e "$2" >&2
    exit "${3:-1}" # Default exit code: 1
}

# Check system requirements
check_requirements() {
    # Check for Python
    if ! command_exists python3; then
        error_exit "Python 3 is required but not installed." \
                  "Please install Python 3.7 or newer from https://www.python.org/downloads/"
    fi

    # Check for git if needed
    if [ "$CHECK_STAGED" = true ] || [ "$CHECK_ALL" = true ]; then
        if ! command_exists git; then
            error_exit "Git is required for checking staged or all files." \
                      "Please install Git from https://git-scm.com/downloads"
        fi

        # Check if in a git repository
        if ! is_git_repo; then
            error_exit "Not a git repository." \
                      "You can only check staged/all files in a git repository.\nTry specifying files directly: ./run_quality_check.sh path/to/file"
        fi
    fi
}

# Show common fixes for issues
show_common_fixes() {
    echo -e "\n${BOLD}Common fixes:${NC}"
    echo "• For complexity issues: Refactor complex functions into smaller units"
    echo "• For security issues: Follow the specific security recommendations"
    echo "• For formatting issues: Run appropriate formatters (e.g., black for Python)"
    echo -e "\nSee SETUP.md for more details on resolving specific issues."
}

# Check staged files
check_staged_files() {
    show_progress "Checking staged files..."

    # Check if there are any staged files
    STAGED_FILES=$(git diff --name-only --cached)
    if [ -z "$STAGED_FILES" ]; then
        echo -e "${YELLOW}No files staged for commit.${NC}"
        echo "Stage files with: git add <file>"
        exit 0
    fi

    # Run our quality gate script on staged files
    python3 "$QUALITY_GATE"
    return $?
}

# Check all files in repository
check_all_files() {
    show_progress "Checking all files (this may take a while)..."

    # Get all tracked files
    ALL_FILES=$(git ls-files)
    if [ -z "$ALL_FILES" ]; then
        echo -e "${YELLOW}No tracked files found.${NC}"
        exit 0
    fi

    # Run pre-commit on all files
    if [ "$VERBOSE" = true ]; then
        pre-commit run --all-files
    else
        pre-commit run --all-files > /dev/null 2>&1
    fi

    # Run additional quality checks
    python3 "$QUALITY_GATE" $ALL_FILES
    return $?
}

# Check specific files
check_specific_files() {
    show_progress "Checking specified files: ${FILES[*]}"

    # Verify all files exist
    for FILE in "${FILES[@]}"; do
        if [ ! -f "$FILE" ]; then
            error_exit "File not found: $FILE" \
                      "Please verify the file path and try again."
        fi
    done

    # Run our quality gate script on specified files
    python3 "$QUALITY_GATE" "${FILES[@]}"
    return $?
}

# Report results
report_results() {
    local exit_code=$1

    if [ $exit_code -ne 0 ]; then
        echo -e "\n${RED}Quality validation failed. Please fix the issues above.${NC}"
        show_common_fixes
    else
        echo -e "\n${GREEN}All quality validations passed!${NC}"
    fi

    return $exit_code
}

#----------------------------------------------------------------------
# Main Execution
#----------------------------------------------------------------------

# Default options
CHECK_STAGED=false
CHECK_ALL=false
VERBOSE=false
QUIET=false
FILES=()

# If no arguments provided, default to checking staged files
if [ $# -eq 0 ]; then
    CHECK_STAGED=true
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -s|--staged)
            CHECK_STAGED=true
            shift
            ;;
        -a|--all)
            CHECK_ALL=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

# If both staged and all are specified, prioritize specific files
if [ ${#FILES[@]} -gt 0 ]; then
    CHECK_STAGED=false
    CHECK_ALL=false
fi

# If no files specified and no flags, default to staged files
if [ ${#FILES[@]} -eq 0 ] && [ "$CHECK_STAGED" = false ] && [ "$CHECK_ALL" = false ]; then
    CHECK_STAGED=true
fi

# Check system requirements
check_requirements

# Run appropriate check type
if [ "$CHECK_STAGED" = true ]; then
    check_staged_files
    EXIT_CODE=$?
elif [ "$CHECK_ALL" = true ]; then
    check_all_files
    EXIT_CODE=$?
else
    check_specific_files
    EXIT_CODE=$?
fi

# Report results and exit with appropriate code
report_results $EXIT_CODE
exit $EXIT_CODE
