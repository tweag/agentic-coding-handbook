# Operation Modes

Pre-Commitator supports two operation modes to accommodate different development environments: VS Code mode and Terminal mode. This document explains how these modes work and how to switch between them.

## Mode Overview

### VS Code Mode

VS Code mode is designed for developers who use Visual Studio Code's integrated source control features. It disables certain validators that may cause issues when using VS Code, particularly those related to SSL certificates and command not found errors.

In VS Code mode:
- **ESLint** is disabled to prevent SSL certificate errors when pre-commit installs the Node.js environment
- **Bandit** is disabled to prevent both SSL certificate errors and command not found errors
- **Lizard** is disabled to prevent command not found errors
- **Semgrep** is disabled to prevent command not found errors
- Basic checks like trailing whitespace, end-of-file newlines, etc. are still enabled
- Horusec is still configured but will be skipped if not installed

### Terminal Mode

Terminal mode is designed for developers who use terminal commands for Git operations. It enables all validators for comprehensive code quality and security checking.

In Terminal mode:
- **ESLint** is enabled for JavaScript/TypeScript validation
- **Lizard** is enabled for code complexity analysis
- **Bandit** is enabled for Python security checking
- **Semgrep** is enabled for security scanning
- **Horusec** is enabled for additional security scanning (if installed)
- All basic checks are also enabled

## Switching Modes

You can switch between modes using the `switch_mode.sh` script:

```bash
# Switch to VS Code mode
./switch_mode.sh vscode

# Switch to Terminal mode
./switch_mode.sh terminal

# Check current mode
./switch_mode.sh
```

## How It Works

### Configuration Files

The mode switching is implemented using two configuration templates:
- `config/pre-commit-vscode.yaml` - Configuration for VS Code mode
- `config/pre-commit-terminal.yaml` - Configuration for Terminal mode

When you switch modes, the appropriate configuration file is copied to `.pre-commit-config.yaml`.

### Environment Variables

In addition to the configuration file, VS Code mode uses environment variables to selectively disable validators in the quality gate:

- `DISABLE_ESLINT=1` - Disables ESLint JavaScript validation
- `DISABLE_LIZARD=1` - Disables Lizard complexity analysis
- `DISABLE_BANDIT=1` - Disables Bandit Python security checks
- `DISABLE_SEMGREP=1` - Disables Semgrep security scanning

These environment variables are set in a `.env` file that is created by the `switch_mode.sh` script. The pre-commit hook loads these environment variables at runtime.

This is especially helpful for preventing SSL certificate errors that commonly occur on macOS when tools like ESLint and Bandit need to make HTTPS requests. The VS Code mode effectively bypasses these error-prone operations.

### .env File

In VS Code mode, a `.env` file is created with contents similar to:

```
# Created by switch_mode.sh
# This file disables certain tools in the quality gate for VS Code compatibility
# Prevents SSL certificate errors and "command not found" errors
DISABLE_ESLINT=1  # Prevents SSL certificate errors during pre-commit install
DISABLE_LIZARD=1  # Prevents "command not found" errors
DISABLE_BANDIT=1  # Prevents both SSL certificate errors and "command not found" errors
DISABLE_SEMGREP=1 # Prevents "command not found" errors
```

This file is read by the pre-commit hook and the environment variables are passed to the Python quality gate script.

In Terminal mode, the `.env` file is removed, allowing all validators to run.

## Implementation Details

### Quality Gate Script

The quality gate script (`src/quality_gate.py`) checks for these environment variables and skips the corresponding validators if they are set:

```python
# Example for ESLint
if os.environ.get("DISABLE_ESLINT") == "1":
    self.warnings.append("ESLint skipped: Disabled by DISABLE_ESLINT=1 environment variable")
    return
```

### Pre-Commit Hook

The pre-commit hook script (`src/pre_commit_hook.sh`) loads the environment variables from the `.env` file:

```bash
# Get the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source .env file if it exists
if [ -f "$SCRIPT_DIR/../.env" ]; then
    echo "Loading environment from $SCRIPT_DIR/../.env"
    source "$SCRIPT_DIR/../.env"
    # Export to make it available to Python subprocess
    export DISABLE_ESLINT
    export DISABLE_LIZARD
    export DISABLE_BANDIT
    export DISABLE_SEMGREP
fi
```

## Customizing Modes

You can customize which validators are enabled in each mode by editing the mode-specific configuration files:

1. Edit `config/pre-commit-vscode.yaml` to customize VS Code mode
2. Edit `config/pre-commit-terminal.yaml` to customize Terminal mode

You can also create additional modes by creating new configuration templates and updating the `switch_mode.sh` script to support them.

## Best Practices

- Use **VS Code mode** if you primarily use VS Code for Git operations
- Use **Terminal mode** if you want the full range of validations and use terminal commands for Git
- Run the quality check manually (`./run_quality_check.sh`) before committing if you want to check for issues that might be disabled in VS Code mode
