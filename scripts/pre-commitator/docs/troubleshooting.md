# Troubleshooting Guide

This document provides solutions for common issues you might encounter when using Pre-Commitator.

## Installation Issues

### Python Not Found

**Error**: `Python 3 is required but not installed`

**Solution**:
1. Install Python 3.7 or newer from [python.org](https://www.python.org/downloads/)
2. Ensure Python is added to your PATH
3. Verify with `python3 --version`

### Permission Denied Running Scripts

**Error**: `Permission denied: ./install.sh`

**Solution**:
```bash
chmod +x *.sh src/*.sh src/*.py
```

### Line Ending Issues on Windows

**Error**: `bad interpreter: /bin/bash^M: no such file or directory`

**Solution**:
```bash
# Option 1: Using sed
sed -i 's/\r$//' *.sh src/*.sh

# Option 2: Using dos2unix
dos2unix *.sh src/*.sh
```

## Operation Mode Issues

### VS Code Commit Issues

**Error**: SSL certificate errors when committing from VS Code

**Solution**:
```bash
# Switch to VS Code mode
./switch_mode.sh vscode
```

This mode disables ESLint, Lizard, Bandit, and Semgrep to prevent SSL certificate issues and "command not found" errors in VS Code.

### Pre-commit's Script is Installed in Migration Mode

**Error**: `Running in migration mode with existing hooks at .git/hooks/pre-commit.legacy`

**Solution**:
```bash
# Completely reinstall pre-commit hooks
pre-commit uninstall
pre-commit install -f

# Then reactivate your preferred mode
./switch_mode.sh vscode  # Or terminal mode

# Reinstall the auto-stage hook
./src/auto_stage_hook.sh
```

This error occurs when pre-commit detects multiple hook installations or leftovers from previous installations. The solution is to completely uninstall and then force a clean reinstallation of the hooks. After that, remember to reinstall the auto-stage hook to enable automatic staging of files modified by hooks.

### SSL Certificate Errors

**Error**: `[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed`

**Solution**:
```bash
# Option 1: Fix certificates
./fix_certificates.sh

# Option 2: Switch to VS Code mode (disables problematic validators)
./switch_mode.sh vscode
```

## Auto-Stage Issues

### Pre-commit Fixes Issues But Requires Manual Staging

**Issue**: Pre-commit hooks fix issues (like trailing whitespace) but you have to manually stage them

**Solution**:
```bash
# Install the auto-stage hook
./src/auto_stage_hook.sh
```

This will automatically stage files modified by pre-commit hooks, allowing you to just run `git commit` again to complete the commit.

### Auto-Stage Hook Not Working

**Issue**: Files modified by pre-commit hooks are not automatically staged

**Solution**:
```bash
# Check if auto-stage hook is installed
ls -la .git/hooks/pre-commit.original

# Reinstall the auto-stage hook
./src/auto_stage_hook.sh
```

## Horusec Issues

### Horusec Installation Failures

**Error**: `Horusec installation could not be completed`

**Solution**:
This is normal and won't affect other validations. Horusec is designed to be optional, and the hooks will skip it if not installed. If you want to try installing it manually:

```bash
# Manual installation attempt
./src/install_horusec.sh
```

## Runtime Issues

### No Files to Check

**Error**: `No files to check` or `No staged files found`

**Solution**:
1. Make sure you've staged files with `git add`
2. Specify files explicitly: `./run_quality_check.sh path/to/file.py`

### Pre-commit Not Initialized

**Error**: `pre-commit: command not found` or hook not running on commit

**Solution**:
```bash
# Install pre-commit
pip install pre-commit

# Install the hooks
pre-commit install
```

### Missing Dependencies

**Error**: `Warning: Lizard not found` or similar messages about missing tools

**Solution**:
```bash
# Install Python dependencies
pip install -r requirements.txt

# Install JavaScript dependencies
npm install

# Or switch to VS Code mode to disable problematic validators
./switch_mode.sh vscode
```

## Validation Issues

### Complexity Errors

**Error**: `warning: someFunction has 25 NLOC, 15 CCN...`

**Solution**:
1. Refactor complex functions into smaller, focused functions
2. Reduce nested conditionals, consider early returns
3. Or adjust thresholds in `.pre-commit-config.yaml`:
   ```yaml
   - repo: local
     hooks:
       - id: lizard
         args: [
             '--CCN', '15',  # Increase from 10 to 15
             '--length', '120',  # Increase from 100 to 120
           ]
   ```

### Security Issues

**Error**: `Security: subprocess call with shell=True identified`

**Solution**:
```python
# Bad
subprocess.check_output(command, shell=True)

# Good
subprocess.check_output(command.split())
```

**Error**: `Use of possibly insecure function - consider using safer ast.literal_eval`

**Solution**:
```python
# Bad
result = eval(user_input)

# Good
import ast
result = ast.literal_eval(user_input)
```

### JavaScript Security Issues

**Error**: `ESLint: Object injection vulnerability detected`

**Solution**:
```javascript
// Bad
const userData = users[userInput];

// Good
const allowedUsers = ['admin', 'user'];
if (allowedUsers.includes(userInput)) {
  const userData = users[userInput];
}
```

## Advanced Troubleshooting

### Debug Mode

To get more detailed output, use the verbose flag:

```bash
./run_quality_check.sh --verbose
```

### Environment Variables

To check which environment variables are being used to control validators:

```bash
# View the .env file content
cat .env

# Check if environment variables are loaded in the pre-commit hook
export -p | grep DISABLE
```

### Git Hook Not Running

If the pre-commit hook isn't running automatically:

1. Check if hooks are installed:
   ```bash
   ls -la .git/hooks/
   ```

2. Reinstall hooks:
   ```bash
   pre-commit install
   ```

3. Verify pre-commit is configured:
   ```bash
   pre-commit --version
   ```

### Custom Rules Not Working

If your custom validation rules are not being applied:

1. Check the format in `.pre-commit-config.yaml`
2. Run with verbose output to see detailed errors
3. Test individual hooks:
   ```bash
   pre-commit run lizard --verbose
   ```

## Mode Switching

If you need to switch between VS Code and terminal modes:

```bash
# Check current mode
./switch_mode.sh

# Switch to VS Code mode
./switch_mode.sh vscode

# Switch to terminal mode
./switch_mode.sh terminal
```

## Getting More Help

If your issue isn't resolved here:

1. Check the `.pre-commit-config.yaml` file for configuration issues
2. Review the logs in verbose mode
3. Consult the documentation for pre-commit and individual validation tools
4. Open an issue on our GitHub repository
