#!/bin/bash
#
# Horusec Security Scanner Installation
#
# This script downloads and installs the Horusec security scanner.
#
# Author: Pre-Commitator Team
# Version: 1.0.0
#

set -e  # Exit on error

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to detect OS
detect_os() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     OS=linux;;
      Darwin*)    OS=darwin;;  # macOS
      CYGWIN*)    OS=windows;;
      MINGW*)     OS=windows;;
      *)          OS="UNKNOWN:${unameOut}"
  esac
  echo $OS
}

# Function to detect architecture
detect_arch() {
  unameOut="$(uname -m)"
  case "${unameOut}" in
      x86_64*)    ARCH=amd64;;
      arm64*)     ARCH=arm64;;
      aarch64*)   ARCH=arm64;;
      *)          ARCH="UNKNOWN:${unameOut}"
  esac
  echo $ARCH
}

echo -e "${YELLOW}Installing Horusec Security Scanner...${NC}"

OS=$(detect_os)
ARCH=$(detect_arch)

if [ "$OS" = "UNKNOWN" ] || [ "$ARCH" = "UNKNOWN" ]; then
  echo -e "${RED}Unsupported OS or architecture: $OS $ARCH${NC}"
  echo -e "${YELLOW}Please visit https://horusec.io/docs/quick-start/installation/ for manual installation instructions.${NC}"
  exit 1
fi

# Create temp directory for installation
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

echo -e "${YELLOW}Downloading Horusec for $OS $ARCH...${NC}"

# Download based on OS
if [ "$OS" = "darwin" ]; then
  echo -e "${YELLOW}Installing with curl...${NC}"
  # Direct download approach for macOS
  # Create a local directory for the binary
  mkdir -p ~/.local/bin

  # Download the latest release
  curl -fsSL -o horusec "https://github.com/ZupIT/horusec/releases/latest/download/horusec_${OS}_${ARCH}"
  chmod +x horusec

  # Move to local bin
  mv horusec ~/.local/bin/

  # Add to PATH if not already there
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Adding ~/.local/bin to PATH${NC}"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

    # Update current session PATH
    export PATH="$HOME/.local/bin:$PATH"
  fi
elif [ "$OS" = "linux" ]; then
  echo -e "${YELLOW}Installing with curl...${NC}"
  # Create a temporary directory
  TMP_INSTALL_DIR=$(mktemp -d)
  INSTALL_SCRIPT="${TMP_INSTALL_DIR}/horusec_install.sh"

  # Download the script first
  curl -fsSL -o "${INSTALL_SCRIPT}" https://raw.githubusercontent.com/ZupIT/horusec/main/deployments/scripts/install.sh

  # Check if download was successful
  if [ -s "${INSTALL_SCRIPT}" ]; then
    # Make it executable
    chmod +x "${INSTALL_SCRIPT}"
    # Execute the script
    "${INSTALL_SCRIPT}" -s latest
  else
    echo -e "${RED}Failed to download Horusec installation script.${NC}"
  fi

  # Clean up
  rm -rf "${TMP_INSTALL_DIR}"
else
  echo -e "${RED}Unsupported OS: $OS${NC}"
  exit 1
fi

# Clean up
rm -rf $TMP_DIR

# Verify installation
if command -v horusec &> /dev/null; then
  echo -e "${GREEN}Horusec installed successfully!${NC}"
  echo -e "${YELLOW}Version:${NC} $(horusec version)"
else
  echo -e "${RED}Horusec installation failed.${NC}"
  echo -e "${YELLOW}Please try installing manually:${NC}"
  echo -e "${YELLOW}https://horusec.io/docs/quick-start/installation/${NC}"
  exit 1
fi

# Print usage instructions
echo -e ""
echo -e "${GREEN}How to use Horusec:${NC}"
echo -e "  ${YELLOW}Run a security scan:${NC} horusec start -p ."
echo -e "  ${YELLOW}Get help:${NC} horusec --help"
echo -e ""
echo -e "${GREEN}Horusec is now configured to run as a pre-commit hook.${NC}"
echo -e ""
