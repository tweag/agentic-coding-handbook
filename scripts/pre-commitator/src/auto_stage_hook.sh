#!/bin/bash
#
# Hook to auto-stage files modified by pre-commit hooks
#

# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"
GIT_DIR="$REPO_ROOT/.git"
HOOKS_DIR="$GIT_DIR/hooks"
PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"
PRE_COMMIT_ORIGINAL="$HOOKS_DIR/pre-commit.original"

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if [ ! -d "$GIT_DIR" ]; then
    echo -e "${RED}${BOLD}Error:${NC} Not in a git repository."
    exit 1
fi

# Check if pre-commit hook exists
if [ ! -f "$PRE_COMMIT_HOOK" ]; then
    echo -e "${RED}${BOLD}Error:${NC} Pre-commit hook not found. Run 'pre-commit install' first."
    exit 1
fi

# Create the wrapper script for auto-staging
install_autostage_hook() {
    # Backup the original pre-commit hook if not already done
    if [ ! -f "$PRE_COMMIT_ORIGINAL" ]; then
        cp "$PRE_COMMIT_HOOK" "$PRE_COMMIT_ORIGINAL"
        echo -e "${GREEN}Original pre-commit hook backed up.${NC}"
    fi

    # Create our modified pre-commit hook that includes auto-staging
    cat > "$PRE_COMMIT_HOOK" << 'EOF'
#!/bin/bash
#
# Pre-commit hook with auto-staging support
# This hook automatically stages files modified by pre-commit hooks
#

# Store the original exit code to ensure we respect it
ORIGINAL_PRE_COMMIT="$(dirname "$0")/pre-commit.original"

# Run the original pre-commit hooks
if [ -f "$ORIGINAL_PRE_COMMIT" ]; then
    # Run the pre-commit hooks
    "$ORIGINAL_PRE_COMMIT"
    RESULT=$?

    # If pre-commit hooks modified any files, stage them automatically
    if [ $RESULT -ne 0 ]; then
        # Get files that were modified but not staged
        MODIFIED_FILES=$(git diff --name-only)

        # Check if any files were modified
        if [ -n "$MODIFIED_FILES" ]; then
            echo ">>> Auto-staging files modified by pre-commit hooks"
            git add $MODIFIED_FILES
            echo ">>> Files have been staged, now run 'git commit' again"
        fi
    fi

    exit $RESULT
else
    echo "Error: Original pre-commit hook not found!"
    exit 1
fi
EOF

    chmod +x "$PRE_COMMIT_HOOK"
    echo -e "${GREEN}Auto-staging pre-commit hook installed.${NC}"
}

# Handle command line arguments
QUIET=false
if [ "$1" = "--quiet" ]; then
    QUIET=true
fi

# Main installation
if $QUIET; then
    install_autostage_hook > /dev/null
    # Silently exit
    exit 0
else
    echo -e "${BOLD}Installing Auto-Stage Hook${NC}"
    echo -e "${YELLOW}This hook automatically stages files modified by pre-commit hooks${NC}"

    # Install the auto-stage hook
    install_autostage_hook

    echo -e "\n${GREEN}${BOLD}Auto-stage hook installed successfully!${NC}"
    echo -e "${YELLOW}Now when pre-commit hooks modify files, they will be automatically staged.${NC}"
    echo -e "${YELLOW}Just run 'git commit' again to complete your commit.${NC}"
fi
