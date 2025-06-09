#!/bin/bash
#
# Pre-Commitator Installation Script
# This script installs and configures the Pre-Commitator tool.
#
# Author: Pre-Commitator Team
# Version: 1.0.0
#

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'


NC='\033[0m' # No Color

# Function to print usage
usage() {
    echo -e "${BOLD}Pre-Commitator Installer${NC}"
    echo ""
    echo -e "${BOLD}Usage:${NC}"
    echo "  ./install.sh [options]"
    echo ""
    echo -e "${BOLD}Options:${NC}"
    echo "  -h, --help     Show this help message"
    echo "  -y, --yes      Answer yes to all prompts (non-interactive mode)"
    echo "  -v, --verbose  Show more detailed output"
    echo "  -q, --quiet    Show minimal output"
    echo ""
    echo -e "${BOLD}Examples:${NC}"
    echo "  ./install.sh                   # Interactive installation"
    echo "  ./install.sh -y                # Non-interactive installation"
}

# Default options
YES_TO_ALL=false
VERBOSE=false
QUIET=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -y|--yes)
            YES_TO_ALL=true
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
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
done

# Banner
echo -e "${BLUE}${BOLD}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║              Pre-Commitator Installer                 ║"
echo "║     Code Quality & Security Validator (v1.0.0)        ║"
echo "║           Using Verified Trusted Sources              ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to display progress
progress() {
    echo -e "${BLUE}➤ ${NC}$1"
}

# Function to display success
success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

# Function to display warning
warning() {
    echo -e "${YELLOW}⚠ ${NC}$1"
}

# Function to display error
error() {
    echo -e "${RED}✗ ${NC}$1"
}

# Check system requirements
progress "Checking system requirements..."

# Check if Python is installed
if ! command_exists python3; then
    error "Python 3 is required but not installed."
    echo "   Please install Python 3.7 or newer from https://www.python.org/downloads/"
    exit 1
else
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    success "Python $PYTHON_VERSION is installed."
fi

# Check if pip is installed
if ! command_exists pip3; then
    error "pip3 is required but not installed."
    echo "   Usually installed with Python. Try: python -m ensurepip --upgrade"
    exit 1
else
    success "pip3 is installed."
fi

# Check if git is installed
if ! command_exists git; then
    error "Git is required but not installed."
    echo "   Please install Git from https://git-scm.com/downloads"
    exit 1
else
    GIT_VERSION=$(git --version | awk '{print $3}')
    success "Git $GIT_VERSION is installed."
fi

# Optional: Check if Node.js is installed for JavaScript validation
if ! command_exists node; then
    warning "Node.js is not installed. JavaScript validation will be limited."
    echo "   Consider installing Node.js from https://nodejs.org/"
else
    NODE_VERSION=$(node --version)
    success "Node.js $NODE_VERSION is installed."
fi

echo ""
progress "Setting up environment..."

# Create a virtual environment if the user wants to
CREATE_VENV="n"
if [ "$YES_TO_ALL" = true ]; then
    CREATE_VENV="y"
else
    read -p "Create a Python virtual environment? (y/N): " CREATE_VENV
fi

if [[ $CREATE_VENV =~ ^[Yy]$ ]]; then
    if ! command_exists python3 -m venv; then
        progress "Installing venv module..."
        pip3 install --user virtualenv
    fi

    if [ -d "venv" ]; then
        warning "Virtual environment already exists."
    else
        progress "Creating virtual environment..."
        python3 -m venv venv
    fi

    progress "Activating virtual environment..."
    source venv/bin/activate
    success "Virtual environment activated."
fi

echo ""
progress "Installing Python dependencies..."
pip3 install -r requirements.txt

# Install pre-commit
progress "Installing pre-commit..."
pip3 install pre-commit

# Set execute permissions for scripts
progress "Setting execution permissions..."
chmod +x run_quality_check.sh
chmod +x src/pre_commit_hook.sh
chmod +x src/quality_gate.py

# Fix line endings if necessary
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    progress "Fixing line endings for Windows..."
    sed -i 's/\r$//' run_quality_check.sh
    sed -i 's/\r$//' src/pre_commit_hook.sh
    sed -i 's/\r$//' src/quality_gate.py
fi

# Install pre-commit hooks
progress "Installing pre-commit hooks..."
pre-commit install

# Install optional JavaScript dependencies if Node.js is installed
if command_exists node; then
    progress "Installing JavaScript dependencies..."
    npm install
fi

# Install Horusec
progress "Installing Horusec security scanner..."
chmod +x src/install_horusec.sh
if [ "$VERBOSE" = true ]; then
    ./src/install_horusec.sh
else
    ./src/install_horusec.sh >/dev/null 2>&1 || warning "Horusec installation skipped. Run './src/install_horusec.sh' manually."
fi

# Setup mode switcher
progress "Setting up mode switcher..."
chmod +x switch_mode.sh

# Ask which mode to use
USE_VSCODE="n"
if [ "$YES_TO_ALL" = true ]; then
    # Default to VS Code mode in non-interactive installation
    USE_VSCODE="y"
else
    read -p "Do you want to use VS Code source control integration? (y/N): " USE_VSCODE
fi

if [[ $USE_VSCODE =~ ^[Yy]$ ]]; then
    ./switch_mode.sh vscode
else
    ./switch_mode.sh terminal
fi

echo ""
success "Installation complete!"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Run a test: ./run_quality_check.sh src/demo.py"
echo "  2. Read the documentation: README.md"
echo "  3. Configure for your project: .pre-commit-config.yaml"
echo "  4. Switch between modes if needed: ./switch_mode.sh [vscode|terminal]"
echo ""
echo -e "${BOLD}For more information:${NC}"
echo "  • Setup guide: SETUP.md"
echo "  • Implementation details: OVERVIEW.md"
echo ""

# Check if we're in a git repo
if git rev-parse --is-inside-work-tree &>/dev/null; then
    echo -e "${BOLD}Pre-Commitator${NC} will automatically run when you commit code."
    echo "You can also manually check files with: ./run_quality_check.sh [files...]"
else
    warning "Not inside a git repository. Pre-commit hooks will only work in git repos."
fi

exit 0
