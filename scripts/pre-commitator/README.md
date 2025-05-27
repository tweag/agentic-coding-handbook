# Pre-Commitator

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Verified Sources](https://img.shields.io/badge/dependencies-verified-brightgreen)

A powerful pre-commit quality validation tool that ensures your code meets quality and security standards before it's committed.

## Overview

Pre-Commitator is designed to detect code quality and security issues at the earliest possible point in development - before code is committed to your repository. It's particularly useful for validating AI-generated code and ensuring all code contributions meet your project's quality standards.

> **Security Note**: Pre-Commitator uses only verified, trusted sources for all dependencies. All tools are from official repositories (PyPI, npm) and well-established organizations like PSF (Black), PyCQA (Bandit, Flake8), and r2c (Semgrep).

## Features

- **✅ Multiple Language Support**: Fully supports Python, JavaScript, and TypeScript, with architecture ready for other languages
- **⚡ Fast Execution**: Only scans files staged for commit or specific files you select
- **🧠 AI-Friendly**: Provides clear error messages that both humans and AI can understand
- **🔍 Comprehensive Validation**:
  - Code complexity analysis
  - Security vulnerability detection
  - Code style and formatting
  - Best practices enforcement

## Requirements

- Python 3.7+
- Git
- Node.js 14+ (optional, for JavaScript validation)

## Quick Start

### For New Developers (90-Second Setup)

```bash
# One command setup (copy & paste this)
git clone https://github.com/yourusername/pre-commitator.git && cd pre-commitator && ./install.sh -y
```

![Getting Started Diagram](docs/images/getting-started.png)

### Installation Options

```bash
# Interactive installation (recommended for first-time users)
./install.sh

# Non-interactive installation
./install.sh -y

# Installation with detailed output
./install.sh -v
```

The installer will:

- Install required Python dependencies
- Set up pre-commit hooks
- Configure the tool for immediate use
- Ask if you want to use VS Code mode or terminal mode

### Basic Usage

```bash
# Check staged files (files about to be committed)
./run_quality_check.sh

# Check specific files
./run_quality_check.sh path/to/file1.py path/to/file2.js

# Check all files in the repository
./run_quality_check.sh --all

# Get help
./run_quality_check.sh --help

# Switch between VS Code and terminal modes
./switch_mode.sh vscode  # For VS Code users (disables problematic validators)
./switch_mode.sh terminal  # For terminal users (enables all validators)
```

### Check Out Our Docs

- [Quick Start Guide](docs/quickstart.md) - Get up and running in 5 minutes
- [Troubleshooting](docs/troubleshooting.md) - Solutions to common issues
- [Contributing Guide](CONTRIBUTING.md) - Learn how to contribute

## Operation Modes

Pre-Commitator offers two operation modes to accommodate different development environments:

### VS Code Mode

```bash
./switch_mode.sh vscode
```

VS Code mode disables certain validators that may cause issues when using VS Code's source control integration:

- Disables **ESLint** to prevent SSL certificate errors when installing from pre-commit
- Disables **Bandit** to prevent SSL certificate errors and "command not found" errors
- Disables **Lizard** and **Semgrep** to prevent "command not found" errors
- Ensures smooth Git operations within VS Code
- Still runs basic checks like trailing whitespace, end-of-file newlines, etc.

This mode is recommended for developers who primarily use VS Code for Git operations.

### Terminal Mode

```bash
./switch_mode.sh terminal
```

Terminal mode enables all validators for comprehensive code quality and security checking:

- Enables **ESLint** for JavaScript/TypeScript validation
- Enables **Lizard** for code complexity analysis
- Enables **Bandit** for Python security checking
- Enables **Semgrep** for multi-language security scanning
- Enables **Horusec** for additional security scanning (if installed)

This mode is recommended for developers who use terminal commands for Git operations and want the full range of validations.

## Detailed Documentation

### Validation Types

Pre-Commitator performs several types of validations:

1. **Code Complexity**

   - Cyclomatic complexity (CCN < 10)
   - Function length (< 100 lines)
   - Function parameters (< 5 parameters)

2. **Security Vulnerabilities**

   - Python: Bandit identifies common security issues (from PyCQA)
   - JavaScript: ESLint security plugin detects web vulnerabilities (official ESLint plugin)
   - Multi-language: Semgrep scans for broader security concerns (from r2c)
   - Multi-language: Horusec detects security vulnerabilities across multiple languages (optional)

3. **Code Style**
   - Python: Black formatting checks
   - JavaScript/TypeScript: ESLint for style enforcement
   - General: Trailing whitespace, end-of-file newlines

### Configuration

Pre-Commitator uses pre-commit's configuration system. Edit `.pre-commit-config.yaml` to:

- Adjust thresholds (complexity, length, etc.)
- Add or remove validation hooks
- Configure language-specific tools

For mode-specific configurations, use the pre-defined templates:

- `config/pre-commit-vscode.yaml` - Configuration for VS Code mode
- `config/pre-commit-terminal.yaml` - Configuration for terminal mode

## Environment Variables

Pre-Commitator uses environment variables to selectively enable or disable specific validators:

- `DISABLE_ESLINT=1` - Disables ESLint JavaScript validation
- `DISABLE_LIZARD=1` - Disables Lizard complexity analysis
- `DISABLE_BANDIT=1` - Disables Bandit Python security checks
- `DISABLE_SEMGREP=1` - Disables Semgrep security scanning

These environment variables are automatically set by the `switch_mode.sh` script based on the selected mode. In VS Code mode, these validators are disabled to prevent issues with SSL certificates and command not found errors.

## Auto-Stage Feature

Pre-Commitator includes an auto-stage feature that automatically stages files modified by pre-commit hooks:

```bash
# Install the auto-stage hook
./src/auto_stage_hook.sh
```

This feature addresses a common pain point where pre-commit hooks fix issues (like trailing whitespace) but require you to manually stage these changes before committing again.

With the auto-stage hook enabled:

1. Pre-commit hooks run and may modify files
2. Modified files are automatically staged
3. You only need to run `git commit` once more to complete the commit

## Using with AI-Generated Code

Pre-Commitator works exceptionally well with AI coding assistants:

1. Generate code with your AI assistant
2. Save the code to a file
3. Run `./run_quality_check.sh filename` to validate
4. If issues are found, ask the AI to fix based on the specific error messages
5. Re-run validation until all issues are resolved

## Troubleshooting

### Common Issues

**Q: The pre-commit hook isn't running when I commit.**
A: Make sure you've installed pre-commit hooks with `pre-commit install` or by running the installer.

**Q: I get "command not found" errors.**
A: Ensure all dependencies are installed. Run `./install.sh` again.

**Q: How do I temporarily bypass checks?**
A: Use `git commit --no-verify` (not recommended for production code).

**Q: Pre-commit hook fixes issues but I have to manually stage the fixed files before committing again.**
A: Install the auto-stage hook: `./src/auto_stage_hook.sh`. This will automatically stage files modified by pre-commit hooks.

**Q: I get SSL certificate errors like `[SSL: CERTIFICATE_VERIFY_FAILED]` when installing eslint environment or running other pre-commit hooks.**
A: This is a common issue on macOS with Python's SSL certificate verification. You have three options:

- Run `./fix_certificates.sh` or `./fix_certificates_unix.sh` to fix Python SSL certificate verification
  - This creates a temporary SSL context fix and sets PYTHONPATH environment variable
- Set PYTHONPATH manually: `export PYTHONPATH=/path/to/pre-commitator`
- Switch to VS Code mode: `./switch_mode.sh vscode` (disables problematic validators that require network access)

The VS Code mode option is the most reliable solution as it completely bypasses the certificate validation issues.

**Q: I see a warning about "pre-commit's script is installed in migration mode".**
A: This happens when multiple pre-commit hooks are installed. Fix it with:

```bash
pre-commit uninstall
pre-commit install -f
./switch_mode.sh vscode  # Or terminal, depending on your preference
```

**Q: How do I install Horusec?**
A: Horusec installation is handled by the `./src/install_horusec.sh` script, which will be called when you run `./switch_mode.sh`. If installation fails, Horusec hooks will be skipped without breaking other validations.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
