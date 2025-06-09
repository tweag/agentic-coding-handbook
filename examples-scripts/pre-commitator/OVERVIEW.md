# Pre-Commitator: Implementation Overview

## Architecture

Pre-Commitator consists of the following components:

1. **Quality Gate Python Script** (`src/quality_gate.py`):
   - Core validation engine that runs multiple quality checks
   - Supports Python, JavaScript, and other language checks
   - Provides clear, formatted error messages
   - Designed to be run both by pre-commit hooks and manually
   - Supports environment variables to selectively disable validators

2. **Pre-Commit Hook Integration** (`src/pre_commit_hook.sh`):
   - Automatically runs quality gate during git commits
   - Blocks commits if quality issues are found
   - Provides colorful, clear output
   - Loads environment variables from .env file

3. **Command-Line Interface** (`run_quality_check.sh`):
   - User-friendly CLI for running checks manually
   - Can check staged files, specific files, or all files
   - Makes it easy to validate code before committing

4. **Installation Script** (`install.sh`):
   - Installs all necessary dependencies
   - Sets up pre-commit hooks
   - Makes scripts executable
   - Configures VS Code or terminal mode based on user preference

5. **Mode Switcher** (`switch_mode.sh`):
   - Switches between VS Code-compatible mode and terminal-optimized mode
   - Creates appropriate .env file to disable validators in VS Code mode
   - Uses pre-defined configuration templates for consistent setup
   - Attempts to install Horusec (optional security scanner)

6. **Auto-Stage Hook** (`src/auto_stage_hook.sh`):
   - Automatically stages files modified by pre-commit hooks
   - Eliminates the need to manually stage files after hook modifications
   - Provides a seamless commit experience

7. **SSL Certificate Fix** (`fix_certificates.sh` and `fix_certificates_unix.sh`):
   - Fixes SSL certificate issues on macOS for Python
   - Provides alternative installation methods for certificates
   - Creates a temporary SSL context fix via ssl_context_fix.py
   - Sets PYTHONPATH environment variable to enable the fix
   - Prevents "[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed" errors
   - Essential for pre-commit hooks that need network access

8. **Horusec Installation** (`src/install_horusec.sh`):
   - Installs Horusec security scanner based on platform
   - Handles installation failures gracefully
   - Provides platform-specific installation methods

## Implementation Details

### Quality Validations

1. **File Hygiene**:
   - Trailing whitespace
   - End-of-file newlines
   - YAML validity
   - File size limits

2. **Code Quality**:
   - Complexity metrics (Lizard)
   - Code formatting (Black for Python)
   - Static analysis

3. **Security**:
   - Bandit for Python security scanning
   - ESLint security plugin for JavaScript/TypeScript
   - Horusec multi-language scanner
   - Semgrep for pattern-based security scanning
   - Dependency vulnerability checks (pip-audit)

### Features

1. **Language Support**:
   - Fully supports Python, JavaScript, and TypeScript
   - Architecture supports expansion to other languages like Java, Go, Ruby, PHP, etc.
   - Each validator only runs on relevant file types

2. **Performance**:
   - Only checks files that are being committed
   - Fast execution for developer workflow

3. **Clear Error Reporting**:
   - Error messages designed to be understood by both humans and AI
   - Categorizes errors vs. warnings
   - Shows file, line, and issue description

4. **Extensibility**:
   - Easy to add new validation tools
   - Pre-commit configuration allows customization

5. **Environment-Specific Modes**:
   - VS Code mode for IDE integration
   - Terminal mode for full validation capability
   - Environment variables control enabled validators

## Operation Modes

### VS Code Mode

VS Code mode disables certain validators that may cause issues when using VS Code's integrated source control:

1. **Implementation**:
   - Uses `.env` file to set environment variables
   - Disables problematic validators via environment variables
   - Pre-commit hook loads these variables at runtime

2. **Disabled Validators**:
   - ESLint (due to SSL certificate issues when installing from pre-commit)
   - Lizard (to prevent "command not found" errors)
   - Bandit (to prevent "command not found" errors and SSL certificate issues)
   - Semgrep (to prevent "command not found" errors)

3. **Configuration**:
   - Uses `config/pre-commit-vscode.yaml` template

### Terminal Mode

Terminal mode enables all validators for comprehensive code quality checking:

1. **Implementation**:
   - Removes `.env` file if it exists
   - Enables all validators by default
   - Ensures full validation capability

2. **Enabled Validators**:
   - ESLint for JavaScript validation
   - Lizard for complexity analysis
   - Bandit for Python security
   - Semgrep for security scanning
   - Horusec for additional security scanning

3. **Configuration**:
   - Uses `config/pre-commit-terminal.yaml` template

## Usage with AI

This tool is designed to work well with AI-generated code:

1. When AI generates code, run the quality check before using it
2. Error messages are structured to be easily parsed by AI
3. AI can understand and fix issues based on the error messages

## Auto-Stage Implementation

The auto-stage feature works by:

1. Backing up the original pre-commit hook to `pre-commit.original`
2. Creating a new pre-commit hook that:
   - Runs the original pre-commit hook
   - Detects when files are modified by pre-commit hooks
   - Automatically stages those modified files
   - Preserves the exit code of the original hook
3. Providing a seamless experience across both VS Code and Terminal modes
4. Instructing the user to commit again to complete the process

This feature significantly improves the development workflow by eliminating the manual step of staging files that were automatically modified by pre-commit hooks, like whitespace or formatting fixes. The implementation is designed to be resilient to pre-commit reinstallation by maintaining a backup of the original hook.

## Future Improvements

1. **More Language Support**:
   - Add Rust, C/C++ specialized validators

2. **CI/CD Integration**:
   - GitHub Actions workflow
   - GitLab CI pipeline

3. **Reporting Dashboard**:
   - Trend analysis of code quality over time
   - Visual representation of issues
