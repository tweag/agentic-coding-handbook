#!/bin/bash
#
# Pre-Commitator Mode Switcher
#
# This script switches between VS Code-compatible mode and terminal-optimized mode
# VS Code mode: Disables ESLint hook to avoid SSL certificate issues
# Terminal mode: Enables all hooks including ESLint
#
# Author: Pre-Commitator Team
# Version: 1.0.0
#

set -e  # Exit on error

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VSCODE_CONFIG="$SCRIPT_DIR/config/pre-commit-vscode.yaml"
TERMINAL_CONFIG="$SCRIPT_DIR/config/pre-commit-terminal.yaml"
PRE_COMMIT_CONFIG="$SCRIPT_DIR/.pre-commit-config.yaml"

install_horusec() {
  if ! command -v horusec &> /dev/null; then
    echo -e "${YELLOW}Horusec not found. Installing...${NC}"
    if "$SCRIPT_DIR/src/install_horusec.sh"; then
      echo -e "${GREEN}Horusec installed successfully.${NC}"
    else
      echo -e "${YELLOW}Horusec installation could not be completed.${NC}"
      echo -e "${YELLOW}The Horusec hook will be configured but may be skipped during pre-commit.${NC}"
      echo -e "${YELLOW}This is normal and won't affect other validations.${NC}"
    fi
  else
    echo -e "${GREEN}Horusec is already installed.${NC}"
  fi
}

switch_to_vscode_mode() {
  echo -e "${BLUE}${BOLD}Switching to VS Code-compatible mode...${NC}"
  cp "$VSCODE_CONFIG" "$PRE_COMMIT_CONFIG"
  echo -e "${GREEN}VS Code mode activated!${NC}"
  echo -e "${YELLOW}ESLint, Lizard, Bandit and Semgrep validation disabled to prevent issues in VS Code.${NC}"

  # Create .env file for disabling problematic tools in VS Code mode
  cat > "$SCRIPT_DIR/.env" << 'EOF'
# Created by switch_mode.sh
# This file disables certain tools in the quality gate for VS Code compatibility
# These tools are disabled because they may cause issues with SSL certificates
# or may not be installed in all VS Code environments
DISABLE_ESLINT=1
DISABLE_LIZARD=1
DISABLE_BANDIT=1
DISABLE_SEMGREP=1
EOF

  # Install pre-commit hooks
  pre-commit uninstall &>/dev/null || true
  pre-commit install -f

  # Reinstall auto-stage hook if it exists
  if [ -f "$SCRIPT_DIR/src/auto_stage_hook.sh" ]; then
    "$SCRIPT_DIR/src/auto_stage_hook.sh" --quiet
  fi

  echo -e "${GREEN}Configuration complete. You can now use VS Code source control without SSL errors.${NC}"
}

switch_to_terminal_mode() {
  echo -e "${BLUE}${BOLD}Switching to terminal-optimized mode...${NC}"
  cp "$TERMINAL_CONFIG" "$PRE_COMMIT_CONFIG"
  echo -e "${GREEN}Terminal mode activated!${NC}"
  echo -e "${YELLOW}All validators including ESLint are enabled.${NC}"

  # Remove .env file if it exists
  if [ -f "$SCRIPT_DIR/.env" ]; then
    rm "$SCRIPT_DIR/.env"
  fi

  # Install pre-commit hooks
  pre-commit uninstall &>/dev/null || true
  pre-commit install -f

  echo -e "${GREEN}Configuration complete. You now have full validation capabilities in the terminal.${NC}"
}

# Install Horusec
install_horusec

# Show usage if no arguments
if [ $# -eq 0 ]; then
  echo -e "${BOLD}Usage:${NC} $0 [vscode|terminal]"
  echo -e ""
  echo -e "${BOLD}Options:${NC}"
  echo -e "  ${YELLOW}vscode${NC}   : Switch to VS Code-compatible mode (ESLint disabled)"
  echo -e "  ${YELLOW}terminal${NC} : Switch to terminal-optimized mode (all hooks enabled)"
  echo -e ""
  echo -e "${BOLD}Current mode:${NC}"

  # Detect current mode
  if grep -q "# ESLint disabled for VS Code compatibility" "$PRE_COMMIT_CONFIG"; then
    echo -e "  ${GREEN}VS Code mode${NC} (ESLint disabled)"
  elif grep -q "JavaScript linting with ESLint" "$PRE_COMMIT_CONFIG"; then
    echo -e "  ${GREEN}Terminal mode${NC} (Full validation enabled)"
  else
    echo -e "  ${RED}Unknown mode${NC}"
  fi

  exit 0
fi

# Process arguments
case "$1" in
  vscode)
    switch_to_vscode_mode
    ;;
  terminal)
    switch_to_terminal_mode
    ;;
  *)
    echo -e "${RED}Unknown mode: $1${NC}"
    echo -e "Use '${YELLOW}vscode${NC}' or '${YELLOW}terminal${NC}'"
    exit 1
    ;;
esac
