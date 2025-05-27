# Quickstart Guide for New Developers

Welcome to the Pre-Commitator project! This guide will get you up and running in under 5 minutes.

## Instant Setup

```bash
# One command setup (copy & paste this)
git clone https://github.com/yourusername/pre-commitator.git && cd pre-commitator && ./install.sh -y
```

## What Does Pre-Commitator Do?

Pre-Commitator automatically checks your code for:
- Security vulnerabilities
- Code complexity issues
- Formatting problems
- Best practices

It runs these checks **before** code is committed to your repository, preventing problematic code from ever being committed.

## Basic Commands

| Command | Description |
|---------|-------------|
| `./run_quality_check.sh file.py` | Check a specific file |
| `./run_quality_check.sh` | Check staged files |
| `./run_quality_check.sh --all` | Check all repository files |
| `./run_quality_check.sh --help` | Show all options |

## Common Workflow

1. Write some code
2. Stage it with `git add myfile.py`
3. Run `./run_quality_check.sh` to check for issues
4. Fix any issues that are found
5. Commit your code with `git commit -m "Your message"`

## Example Output

```
🔍 Running Code Quality Gate...

🚫 ERRORS:
  - Security: ./src/demo.py:24 - subprocess call with shell=True identified, security issue.

⚠️ WARNINGS:
  - Complexity: src/demo.js:21: complexFunction has 34 lines, 7 CCN, 6 parameters
  - Security: ./src/demo.py:17 - Use of insecure function eval()

❌ Quality gate failed! Please fix the errors above.
```

## How to Fix Common Issues

### Security Issues

- **subprocess with shell=True**:
  ```python
  # Bad
  subprocess.call("command", shell=True)

  # Good
  subprocess.call(["command", "arg1", "arg2"])
  ```

- **eval() usage**:
  ```python
  # Bad
  result = eval(user_input)

  # Good
  import ast
  result = ast.literal_eval(user_input)
  ```

### Complexity Issues

- Break large functions into smaller ones
- Reduce nesting levels by using early returns
- Extract complex logic into helper functions

## Getting Help

For more detailed information:
- Read the full [README.md](../README.md)
- Check the [SETUP.md](../SETUP.md) for configuration options
- Visit the [troubleshooting](./troubleshooting.md) guide

Happy coding!
