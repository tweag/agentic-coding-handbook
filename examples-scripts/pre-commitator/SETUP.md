# Installation & Setup Guide

This guide provides detailed instructions for installing and setting up Pre-Commitator in your development environment.

## System Requirements

- **Operating Systems**: macOS, Linux, Windows (via WSL recommended)
- **Python**: 3.7 or newer
- **Git**: 2.22.0 or newer
- **Node.js**: 14.0 or newer (optional, for JavaScript validation)

## Step-by-Step Installation

### 1. Basic Installation

The simplest way to install is using our installation script:

```bash
./install.sh
```

This script will:
- Install Python dependencies
- Set up pre-commit hooks
- Make scripts executable
- Configure paths
- Ask if you want to use VS Code mode or terminal mode
- Attempt to install Horusec security scanner (optional)

### 2. Manual Installation

If you prefer a manual installation:

#### Install Python Dependencies

```bash
# Create and activate a virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
pip install pre-commit
```

#### Install JavaScript Dependencies (Optional)

```bash
npm install
```

#### Install Pre-commit Hooks

```bash
# Clean installation (recommended)
pre-commit uninstall
pre-commit install -f

# If you see "Running in migration mode" warnings, use:
pre-commit uninstall
pre-commit install -f
```

#### Set Execution Permissions

```bash
chmod +x run_quality_check.sh
chmod +x src/pre_commit_hook.sh
chmod +x src/quality_gate.py
chmod +x switch_mode.sh
chmod +x src/auto_stage_hook.sh
chmod +x src/install_horusec.sh
chmod +x fix_certificates.sh
```

#### Choose Operation Mode

Choose which mode you want to use based on your development environment:

```bash
# For VS Code users (disables problematic validators)
./switch_mode.sh vscode

# For terminal users (enables all validators)
./switch_mode.sh terminal
```

#### Install Auto-Stage Hook (Optional)

If you want modified files to be automatically staged after pre-commit hooks fix them:

```bash
# Install the auto-stage hook
./src/auto_stage_hook.sh
```

This hook works by backing up the original pre-commit hook and creating a new hook that automatically stages files modified by pre-commit hooks. It works seamlessly in both VS Code and Terminal modes, eliminating the need to manually stage files after the pre-commit hooks fix issues.

### 3. Optional Tools Installation

#### Install Semgrep (Security Scanner)

Semgrep is a lightweight static analysis tool used for finding code security issues.

**All platforms**:
```bash
pip install semgrep==1.50.0
```

For more information, visit the official repository: https://github.com/returntocorp/semgrep

#### Install Horusec (Security Scanner)

Horusec is a multi-language security scanner.

```bash
# The install script will detect your OS and install appropriately
./src/install_horusec.sh
```

If Horusec installation fails, the hook will be skipped without affecting other validations.

#### Fix SSL Certificate Issues (macOS)

If you encounter SSL certificate issues on macOS:

```bash
# Fix SSL certificate issues
./fix_certificates.sh
```

## Operation Modes

Pre-Commitator supports two operation modes to accommodate different development environments:

### VS Code Mode

```bash
./switch_mode.sh vscode
```

VS Code mode disables certain validators that may cause issues when using VS Code's source control integration:

- Disables **ESLint** to prevent SSL certificate errors
- Disables **Lizard**, **Bandit**, and **Semgrep** to prevent "command not found" errors
- Uses environment variables to control which validators are active
- Creates a `.env` file that is loaded by the pre-commit hook

### Terminal Mode

```bash
./switch_mode.sh terminal
```

Terminal mode enables all validators for comprehensive code quality checking:

- Enables **ESLint** for JavaScript/TypeScript validation
- Enables **Lizard** for code complexity analysis
- Enables **Bandit** for Python security checking
- Enables **Semgrep** for multi-language security scanning
- Enables **Horusec** for additional security scanning (if installed)

## Configuration

### Customizing Validation Rules

Edit `.pre-commit-config.yaml` to modify the validation settings:

```yaml
# Example: Adjust Lizard complexity thresholds
- repo: local
  hooks:
    - id: lizard
      name: Lizard (code complexity)
      entry: lizard
      language: python
      args: [
          '--warnings_only',
          '--CCN', '15',  # Change from 10 to 15
          '--length', '120',  # Change from 100 to 120
          '--arguments', '5',
        ]
```

### Mode-Specific Configurations

Pre-Commitator includes pre-defined configuration templates for each mode:

- `config/pre-commit-vscode.yaml` - Configuration for VS Code mode
- `config/pre-commit-terminal.yaml` - Configuration for terminal mode

You can customize these templates to adjust which validators are enabled in each mode.

### Environment Variables

Pre-Commitator uses environment variables to selectively enable or disable validators:

- `DISABLE_ESLINT=1` - Disables ESLint JavaScript validation
- `DISABLE_LIZARD=1` - Disables Lizard complexity analysis
- `DISABLE_BANDIT=1` - Disables Bandit Python security checks
- `DISABLE_SEMGREP=1` - Disables Semgrep security scanning

These environment variables are controlled by the `.env` file that is created by the `switch_mode.sh` script.

### Setting Up Specific Languages

#### Python Configuration

Modify `.bandit.yml` to change security scanning settings:

```yaml
# Add additional skips
skips:
  - B101  # assert used
  - B404  # subprocess without shell=True
```

#### JavaScript Configuration

Modify `.eslintrc.json` to customize JavaScript linting:

```json
{
  "plugins": ["security"],
  "extends": ["plugin:security/recommended"],
  "rules": {
    "security/detect-object-injection": "warn",  # Change from error to warn
    "security/detect-non-literal-fs-filename": "error"
  }
}
```

## Integration with CI/CD

### GitHub Actions

Create `.github/workflows/quality-check.yml`:

```yaml
name: Code Quality Check

on:
  pull_request:
    branches: [ main, develop ]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pre-commit
      - name: Run quality checks
        run: |
          ./run_quality_check.sh --all
```

## Troubleshooting

### Common Issues

1. **Permission Denied**:
   ```bash
   chmod +x *.sh src/*.py src/*.sh
   ```

2. **Line Endings on Windows**:
   ```bash
   # Fix line endings
   sed -i 's/\r$//' *.sh src/*.sh
   ```

3. **Missing Dependencies**:
   ```bash
   # Verify Python installations
   pip list

   # Verify Node installations
   npm list
   ```

4. **SSL Certificate Issues on macOS**:
   ```bash
   # Fix SSL certificate verification
   ./fix_certificates.sh

   # Or switch to VS Code mode
   ./switch_mode.sh vscode
   ```

5. **Pre-commit's Script is Installed in Migration Mode**:
   ```bash
   # Reinstall pre-commit hooks
   pre-commit uninstall
   pre-commit install -f
   ./switch_mode.sh vscode  # Or terminal mode
   ```

6. **Auto-staging Not Working**:
   ```bash
   # Reinstall auto-stage hook
   ./src/auto_stage_hook.sh

   # If still not working, check if the pre-commit hook was replaced
   ls -la .git/hooks/pre-commit*

   # Then reinstall again after switching modes
   ./switch_mode.sh terminal  # Or vscode mode
   ./src/auto_stage_hook.sh
   ```

### Getting Help

If you encounter persistent issues, please:

1. Check if all dependencies are installed
2. Verify file permissions
3. Check Python and Node.js versions
4. Open an issue on our GitHub repository

## Next Steps

Once installation is complete, you can:

1. Test your setup: `./run_quality_check.sh src/demo.py`
2. Review sample configurations in the `config/` directory
3. Integrate with your existing projects by copying the relevant files
4. Switch between VS Code and terminal modes as needed
