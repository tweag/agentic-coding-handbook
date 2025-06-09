#!/bin/bash
#
# Fix Python SSL certificate verification on macOS
#

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Fixing Python SSL certificate verification...${NC}"

# Check if running on macOS
if [ "$(uname)" != "Darwin" ]; then
    echo -e "${RED}This script is intended for macOS only.${NC}"
    exit 1
fi

# Get Python version used in the virtual environment
PYTHON_PATH=$(which python3)
if [ -z "$PYTHON_PATH" ]; then
    echo -e "${RED}Python 3 not found.${NC}"
    exit 1
fi

# Get Python version
PYTHON_VERSION=$($PYTHON_PATH --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1-2)
echo -e "Using Python ${PYTHON_VERSION}"

# Install certificates for this Python version
echo -e "Installing certificates..."
/Applications/Python\ ${PYTHON_VERSION}/Install\ Certificates.command || {
    echo -e "${YELLOW}Manual certificate installation required.${NC}"
    echo -e "Try running the following commands:"
    echo -e "${GREEN}cd /tmp${NC}"
    echo -e "${GREEN}open /Applications/Python\ ${PYTHON_VERSION}/Install\ Certificates.command${NC}"

    # Create a temporary certificate fix
    echo -e "${YELLOW}Creating a temporary SSL context fix...${NC}"

    cat > "$PWD/ssl_context_fix.py" << 'EOF'
# Fix SSL certificate verification in Python
import os
import ssl

def create_ssl_unverified_context():
    """Create an SSL context that doesn't verify certificates (use with caution)"""
    context = ssl._create_unverified_context()
    return context

# Apply the fix globally
ssl._create_default_https_context = create_ssl_unverified_context
print("SSL certificate verification disabled (temporary fix)")
EOF

    echo -e "${YELLOW}To use the temporary fix, set this environment variable:${NC}"
    echo -e "${GREEN}export PYTHONPATH=$PWD${NC}"
    echo -e "${YELLOW}Note: This is a temporary workaround and disables SSL verification.${NC}"
    echo -e "${YELLOW}For a proper fix, install macOS certificates for Python.${NC}"
}

echo -e "${GREEN}SSL certificate fix complete!${NC}"
echo -e "Try running your command again."
