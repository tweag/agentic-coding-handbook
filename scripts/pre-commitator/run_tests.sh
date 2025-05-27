#!/bin/bash
#
# Pre-Commitator Test Suite
#
# This script runs a comprehensive test of all pre-commitator functionality
#
# Usage: ./run_tests.sh
#

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display header
header() {
    echo ""
    echo -e "${BLUE}${BOLD}$1${NC}"
    echo -e "${BLUE}${BOLD}$(printf '=%.0s' $(seq 1 ${#1}))${NC}"
}

# Function to display success
success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

# Function to display failure
failure() {
    echo -e "${RED}✗ ${NC}$1"
}

# Function to display info
info() {
    echo -e "${YELLOW}• ${NC}$1"
}

# Ensure we're in the right directory
if [ ! -f "requirements.txt" ] || [ ! -f "package.json" ]; then
    echo -e "${RED}Error: Cannot find requirements.txt or package.json${NC}"
    echo "Make sure you run this script from the root directory of the project."
    exit 1
fi

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Print banner
echo -e "${BLUE}${BOLD}"
echo "╔════════════════════════════════════════════════════════╗"
echo "║           Pre-Commitator Test Suite                    ║"
echo "║           Testing all functionality                    ║"
echo "╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check environment
header "Checking Environment"
if python3 test_dependencies.py; then
    success "Environment test completed"
else
    failure "Environment test failed"
    exit 1
fi

# Test help command
header "Testing Help Commands"
if ./run_quality_check.sh --help | grep -q "Options:"; then
    success "Help command works correctly"
else
    failure "Help command failed"
    exit 1
fi

# Test clean file
header "Testing Clean File Validation"
info "Running check on clean Python file"
if ./run_quality_check.sh tests/test_clean.py | grep -q "Quality gate passed"; then
    success "Clean file check passed correctly"
else
    failure "Clean file check failed"
    exit 1
fi

# Test file with issues
header "Testing Problem File Detection"
info "Running check on Python file with issues"
if ! ./run_quality_check.sh tests/test_python_issues.py | grep -q "Quality gate passed"; then
    success "Problem detection works correctly"
else
    failure "Failed to detect problems in file with issues"
    exit 1
fi

# Test JavaScript validation
header "Testing JavaScript Validation"
info "Running check on JavaScript file with issues"
if ! ./run_quality_check.sh tests/test_js_issues.js | grep -q "Quality gate passed"; then
    success "JavaScript validation works correctly"
else
    failure "Failed to detect problems in JavaScript file"
    exit 1
fi

# Test quiet mode
header "Testing Quiet Mode"
info "Running check with --quiet flag"
OUTPUT_LINES=$(./run_quality_check.sh --quiet tests/test_clean.py | wc -l | tr -d ' ')
if [ "$OUTPUT_LINES" -lt 10 ]; then
    success "Quiet mode works correctly (got $OUTPUT_LINES lines)"
else
    failure "Quiet mode test failed (got $OUTPUT_LINES lines)"
    exit 1
fi

# Show summary
header "Test Summary"
echo -e "${GREEN}${BOLD}All tests passed successfully!${NC}"
echo ""
echo -e "Pre-Commitator is working correctly and ready to use."
echo -e "You can now use it to validate code quality before committing."
echo ""
