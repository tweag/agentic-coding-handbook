#!/bin/bash
#
# Pre-Commitator Pre-commit Hook
#
# This script runs the quality gate validation as a git pre-commit hook.
# It automatically validates staged files before they are committed.
#
# Author: Pre-Commitator Team
# Version: 1.0.0
#

set -o pipefail  # Ensure script fails if any command in a pipeline fails

# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source .env file if it exists
if [ -f "$SCRIPT_DIR/../.env" ]; then
    echo "Loading environment from $SCRIPT_DIR/../.env"
    source "$SCRIPT_DIR/../.env"
    # Export to make it available to Python subprocess
    export DISABLE_ESLINT
fi

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# Main execution
#

echo -e "${BLUE}${BOLD}Pre-Commitator${NC} ${YELLOW}running quality validation...${NC}"

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 is required but not installed.${NC}"
    echo "Please install Python 3.7 or newer to use Pre-Commitator."
    exit 1
fi

# Run the quality gate script
python3 "${SCRIPT_DIR}/quality_gate.py"
EXIT_CODE=$?

# Display appropriate message based on validation result
if [ $EXIT_CODE -ne 0 ]; then
    echo -e "${RED}${BOLD}Quality validation failed.${NC} Please fix the issues above."
    echo -e "${YELLOW}Tip:${NC} Run './run_quality_check.sh' to check your code before committing."
    echo -e "${YELLOW}Tip:${NC} Use 'git commit --no-verify' to bypass this check (not recommended)."
    exit $EXIT_CODE
else
    echo -e "${GREEN}${BOLD}Quality validation passed!${NC} Your code meets quality standards."
    exit 0
fi
