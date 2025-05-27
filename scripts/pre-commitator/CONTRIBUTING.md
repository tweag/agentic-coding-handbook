# Contributing to Pre-Commitator

Thank you for your interest in contributing to Pre-Commitator! This document provides guidelines and instructions for contributing to the project.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** to your local machine
3. **Install dependencies** by running `./install.sh`
4. **Create a new branch** for your feature or bugfix
5. **Make your changes** following our code style guidelines
6. **Run the tests** to ensure your changes don't break existing functionality
7. **Submit a pull request** from your fork to the main repository

## Development Environment Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/pre-commitator.git
cd pre-commitator

# Install development dependencies
./install.sh

# Create a virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install additional development dependencies
pip install pytest pytest-cov mypy

# If you encounter SSL certificate issues (especially on macOS)
./fix_certificates.sh  # for macOS
# OR
./fix_certificates_unix.sh  # for other Unix systems
# OR set the PYTHONPATH environment variable
export PYTHONPATH=$PWD  # Points to the SSL context fix
```

## Project Structure

```
pre-commitator/
├── config/              # Configuration files
├── docs/                # Documentation
├── src/                 # Source code
│   ├── __init__.py
│   ├── quality_gate.py  # Main validation engine
│   └── pre_commit_hook.sh # Pre-commit hook script
├── .pre-commit-config.yaml # Pre-commit configuration
├── install.sh           # Installation script
├── run_quality_check.sh # Main CLI script
└── README.md           # Project documentation
```

## Coding Standards

We follow these standards:

- **Python**: PEP 8 style guide, enforced by Black formatter
- **JavaScript**: ESLint with security plugins
- **Shell scripts**: Shellcheck compliant

## Adding New Validators

To add a new validation tool:

1. Add the dependency to `requirements.txt` or `package.json`
2. Create a new method in `src/quality_gate.py`
3. Call your method from the `run_all_checks` method
4. Add appropriate testing
5. Update documentation

Example of adding a new validator:

```python
def run_new_validator(self, files: List[str]) -> None:
    """Run new validation tool."""
    # Implementation here
    try:
        # Run the tool
        # Parse results
        # Add errors/warnings
    except FileNotFoundError:
        self.warnings.append("Warning: New tool not found. Install with 'pip install new-tool'")
```

## Testing

Before submitting a pull request, make sure all tests pass:

```bash
# Run all tests
./run_tests.sh

# Test your changes
./run_quality_check.sh --all

# Test with example problematic code
./run_quality_check.sh src/demo.py src/demo.js
```

### Using the Test Artifacts Directory

When testing Pre-Commitator, use the `tests/artifacts/` directory for any temporary test files:

1. **Creating Test Files**:
   ```bash
   # Create a test file with trailing whitespace
   echo "This has trailing spaces    " > tests/artifacts/test_whitespace.txt
   ```

2. **Naming Convention**:
   - Prefix all test files with `test_`
   - Use descriptive names that indicate the purpose
   - Example: `test_trailing_whitespace.txt`

3. **Cleanup**:
   - Clean up test files after your tests complete
   - The directory is git-ignored to prevent accidental commits

### Auto-Stage Hook Testing

When making changes to the auto-stage hook, be especially careful to test in both VS Code and terminal modes:

```bash
# Install the auto-stage hook
./src/auto_stage_hook.sh

# Switch to VS Code mode and test
./switch_mode.sh vscode
# Create a test file in the artifacts directory
echo "Test file with trailing spaces    " > tests/artifacts/test_whitespace.txt
git add tests/artifacts/test_whitespace.txt
git commit -m "Testing auto-stage hook"
# Verify the hook works correctly

# Switch to terminal mode and test
./switch_mode.sh terminal
# Test with another file that will trigger hooks
echo "Another test file with trailing spaces    " > tests/artifacts/test_whitespace2.txt
git add tests/artifacts/test_whitespace2.txt
git commit -m "Testing auto-stage hook in terminal mode"
# Verify the hook works correctly

# Clean up test files
rm tests/artifacts/test_whitespace*.txt
```

## Pull Request Process

1. Ensure your code follows our style guidelines
2. Update documentation if necessary
3. Make sure all tests pass
4. Update the README.md with details of your changes if appropriate
5. The PR should work against the main branch

## Security Considerations

- All dependencies must come from trusted, verified sources
- No external HTTP calls in the main validation logic
- Security checks should err on the side of caution
- No hardcoded credentials or sensitive information

## Handling SSL Certificate Issues

When developing Pre-Commitator, you might encounter SSL certificate verification errors, especially on macOS. These typically occur when pre-commit tries to install Node.js environments, or when Python security tools (like Bandit) make HTTPS requests.

### Common SSL Error Symptoms

```
[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate
```

### Solutions (in order of preference)

1. **Switch to VS Code Mode**: For testing/development
   ```bash
   ./switch_mode.sh vscode
   ```

2. **Fix Certificates**:
   ```bash
   ./fix_certificates.sh  # macOS
   ./fix_certificates_unix.sh  # Other Unix systems
   ```

3. **Set PYTHONPATH**: This points to our temporary SSL context fix
   ```bash
   export PYTHONPATH=$PWD
   ```

4. **Install Python Certificates**: For proper macOS certificate installation
   ```bash
   open /Applications/Python\ 3.x/Install\ Certificates.command
   ```

Remember to document any SSL-related changes you make, as they impact both developer and user experience.

## Code Review Criteria

Pull requests will be evaluated based on:

- Code quality and style
- Test coverage
- Documentation
- Security implications
- Performance considerations

## License

By contributing to Pre-Commitator, you agree that your contributions will be licensed under the project license.

Thank you for contributing to making Pre-Commitator better!
