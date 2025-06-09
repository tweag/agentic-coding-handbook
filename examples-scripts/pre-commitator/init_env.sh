#!/bin/bash
#
# Pre-Commitator Environment Initialization Script
#
# This script sets up the development environment for Pre-Commitator by:
# - Creating a virtual environment if it doesn't exist
# - Installing Python dependencies
# - Installing Node.js dependencies
# - Setting up pre-commit hooks
#
# Usage: ./init_env.sh
#

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}${BOLD}"
echo "╔════════════════════════════════════════════════════════╗"
echo "║         Pre-Commitator Environment Setup               ║"
echo "║            Setting up development environment          ║"
echo "╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if we're in the right directory
if [ ! -f "requirements.txt" ] || [ ! -f "package.json" ]; then
    echo -e "${RED}Error: Cannot find requirements.txt or package.json${NC}"
    echo "Make sure you run this script from the root directory of the project."
    exit 1
fi

# Function to display progress
progress() {
    echo -e "${BLUE}➤ ${NC}$1"
}

# Function to display success
success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

# Setup virtual environment
progress "Setting up Python virtual environment..."

if [ -d "venv" ]; then
    echo -e "${YELLOW}Virtual environment already exists. Using existing environment.${NC}"
else
    python3 -m venv venv
    success "Virtual environment created"
fi

# Activate virtual environment
progress "Activating virtual environment..."
source venv/bin/activate
success "Virtual environment activated"

# Install Python dependencies
progress "Installing Python dependencies..."
pip install -r requirements.txt
success "Python dependencies installed"

# Install Node.js dependencies
progress "Installing Node.js dependencies..."
npm install
success "Node.js dependencies installed"

# Install pre-commit hooks
progress "Setting up pre-commit hooks..."
pre-commit install
success "Pre-commit hooks installed"

# Run dependency check
progress "Verifying installation..."
python test_dependencies.py

echo ""
echo -e "${GREEN}${BOLD}Setup complete!${NC}"
echo ""
echo -e "To activate the environment, run: ${YELLOW}source venv/bin/activate${NC}"
echo -e "To check code quality, run: ${YELLOW}./run_quality_check.sh <files>${NC}"
echo ""
