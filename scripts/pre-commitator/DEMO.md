# Pre-Commitator Demo Guide

This guide provides a step-by-step demonstration of Pre-Commitator's capabilities from a completely blank slate. It's designed for training staff members on all possible use cases. This file is excluded from git to maintain a clean repository.

## Starting from Scratch

### Environment Setup

1. **Prerequisites**

   - Ensure you have Python 3.7+ installed
   - Ensure you have Git installed
   - Ensure you have Node.js 14+ installed (for JavaScript validation)

   Verify with:

   ```bash
   python3 --version
   git --version
   node --version
   ```

2. **Clone the Repository**

   ```bash
   # Start in a clean directory
   cd ~/Desktop

   # Clone the repository
   git clone https://github.com/yourusername/pre-commitator.git

   # Navigate to the project
   cd pre-commitator
   ```

3. **Installation**

   ```bash
   # Install with interactive prompts (recommended for first-time setup)
   ./install.sh

   # Or non-interactive installation
   ./install.sh -y

   # Or verbose installation to see detailed progress
   ./install.sh -v
   ```

4. **Verify Installation**

   ```bash
   # Check if all dependencies are correctly installed
   python3 test_dependencies.py
   ```

5. **Run Test Suite**
   ```bash
   # Verify all components work together
   ./run_tests.sh
   ```

## Basic Usage Examples

### Individual File Validation

1. **Validate a Single Python File**

   ```bash
   # 1. Example with a clean file (should pass)
   ./run_quality_check.sh tests/test_clean.py

   # 2. Example with security warnings (should show warnings)
   ./run_quality_check.sh src/demo.py

   # 3. Example with critical issues (should fail)
   ./run_quality_check.sh tests/test_python_issues.py
   ```

2. **Validate a Single JavaScript File**

   ```bash
   # 1. JavaScript file with security and style issues
   ./run_quality_check.sh src/demo.js

   # 2. JavaScript test file with security vulnerabilities
   ./run_quality_check.sh tests/test_js_issues.js
   ```

### Batch Validation

1. **Validate Multiple Files**

   ```bash
   # Check multiple specific files at once
   ./run_quality_check.sh src/demo.py tests/test_clean.py

   # Show the difference in outputs for different file types
   ./run_quality_check.sh src/demo.py src/demo.js
   ```

2. **Validate All Files**
   ```bash
   # Validate all tracked files in the repository
   ./run_quality_check.sh --all
   ```

## Command Line Options

1. **Help Command**

   ```bash
   # Display all available options
   ./run_quality_check.sh --help
   ```

2. **Output Options**

   ```bash
   # Verbose output
   ./run_quality_check.sh --verbose src/demo.py

   # Quiet output (minimal information)
   ./run_quality_check.sh --quiet tests/test_clean.py
   ```

## Git Integration Workflow

1. **Setup Pre-commit Hook**

   ```bash
   # Ensure pre-commit is installed
   pip install pre-commit

   # Install pre-commit hooks
   pre-commit install
   ```

2. **Staged Files Validation**

   ```bash
   # Clear any staged files
   git reset

   # Stage a file with no issues
   git add tests/test_clean.py

   # Validate only staged files (default behavior)
   ./run_quality_check.sh
   ```

3. **Failed Validation Workflow**

   ```bash
   # Stage a file with issues
   git add src/demo.js

   # Validate staged files
   ./run_quality_check.sh

   # See pre-commit hook in action (will block commit due to issues)
   ./src/pre_commit_hook.sh
   ```

4. **Bypassing Validation (Emergency Use Only)**

   ```bash
   # Note: This would be used in a real scenario
   # git commit --no-verify -m "Emergency fix, bypass validation"

   # Instead, just demonstrate the command's existence
   echo "In emergency situations only: git commit --no-verify"
   ```

## Advanced Use Cases

### Custom Configurations

1. **Examine Configuration**

   ```bash
   # View existing configuration examples
   cat config/settings.yaml
   ```

2. **Project-Specific Settings** (for future demonstration)
   ```bash
   # Coming soon: Project-specific configuration
   # ./run_quality_check.sh --config custom_config.yaml
   ```

### Working with AI-Generated Code

1. **Create Example AI-Generated Code**

   ```bash
   # Create a new file simulating AI-generated code with issues
   cat > ai_generated.py << 'EOF'
   #!/usr/bin/env python3
   """
   Example AI-generated code with security and quality issues
   """
   import os
   import subprocess
   import pickle

   # Security issue: eval with user input
   def process_input(user_input):
       return eval(user_input)

   # Complexity issue: too many parameters and nested conditions
   def complex_calculation(a, b, c, d, e, f, g, h):
       result = 0
       if a > 0:
           if b > c:
               if d < e:
                   if f > g:
                       result = a + b + c + d + e + f + g + h
                   else:
                       result = a + b + c + d + e
               else:
                   result = a + b + c
           else:
               result = a
       return result

   # Another security issue: using pickle
   def save_data(data):
       with open("data.pickle", "wb") as f:
           pickle.dump(data, f)

   # Main function with shell injection risk
   def main():
       user_input = input("Enter expression: ")
       print(process_input(user_input))

       # Shell injection risk
       cmd = input("Enter command: ")
       subprocess.run(cmd, shell=True)

   if __name__ == "__main__":
       main()
   EOF
   ```

2. **Validate AI-Generated Code**

   ```bash
   # Run validation on the AI-generated file
   ./run_quality_check.sh ai_generated.py
   ```

3. **Fix Issues Based on Feedback**

   ```bash
   # Create fixed version based on Pre-Commitator feedback
   cat > ai_generated_fixed.py << 'EOF'
   #!/usr/bin/env python3
   """
   Example AI-generated code with fixes applied
   """
   import ast
   import subprocess
   import json

   # Fixed: Using ast.literal_eval instead of eval
   def process_input(user_input):
       try:
           return ast.literal_eval(user_input)
       except (SyntaxError, ValueError):
           return None

   # Fixed: Reduced complexity, fewer parameters
   def calculate_result(values):
       """Calculate result from a list of values with simple logic."""
       if not values or len(values) < 2:
           return 0

       result = sum(values)
       if values[0] > values[1]:
           result *= 2
       return result

   # Fixed: Using JSON instead of pickle
   def save_data(data):
       with open("data.json", "w") as f:
           json.dump(data, f)

   # Fixed: No shell=True, uses list of arguments
   def run_command(command_args):
       if isinstance(command_args, str):
           command_args = command_args.split()
       return subprocess.run(command_args, capture_output=True, text=True, shell=False)

   # Main function with fixes
   def main():
       try:
           user_input = input("Enter a tuple or list of numbers: ")
           result = process_input(user_input)
           print(f"Result: {result}")

           # Safe command execution
           command = ["ls", "-la"]
           output = run_command(command)
           print(output.stdout)

       except Exception as e:
           print(f"Error: {e}")

   if __name__ == "__main__":
       main()
   EOF
   ```

4. **Validate Fixed Code**
   ```bash
   # Run validation on the fixed file
   ./run_quality_check.sh ai_generated_fixed.py
   ```

### Language-Specific Features

1. **Python-Specific Features**

   ```bash
   # Demonstrate Python-specific security checks (bandit)
   ./run_quality_check.sh --verbose tests/test_python_issues.py | grep "bandit"
   ```

2. **JavaScript-Specific Features**
   ```bash
   # Demonstrate JavaScript-specific security checks (ESLint)
   ./run_quality_check.sh --verbose tests/test_js_issues.js | grep "ESLint"
   ```

## Real-World Workflow Example

1. **Create a New Feature Branch**

   ```bash
   # Create and checkout a feature branch
   git checkout -b feature/new-calculation
   ```

2. **Create a New File with an Issue**

   ```bash
   # Create a new Python file with an issue
   cat > src/calculate.py << 'EOF'
   #!/usr/bin/env python3
   """
   New calculation module
   """

   def advanced_calculation(x, y):
       """Perform calculation based on inputs."""
       # Security issue: eval with user input
       return eval(f"{x} * {y}")

   def main():
       result = advanced_calculation(5, 10)
       print(f"Result: {result}")

   if __name__ == "__main__":
       main()
   EOF
   ```

3. **Try to Commit (Should Fail)**

   ```bash
   # Stage the new file
   git add src/calculate.py

   # Attempt to commit - pre-commit hook should block this
   git commit -m "Add new calculation function"
   ```

4. **Fix the Issue**

   ```bash
   # Fix the file based on feedback
   cat > src/calculate.py << 'EOF'
   #!/usr/bin/env python3
   """
   New calculation module
   """

   def advanced_calculation(x, y):
       """Perform calculation based on inputs."""
       # Fixed: Direct calculation instead of eval
       return x * y

   def main():
       result = advanced_calculation(5, 10)
       print(f"Result: {result}")

   if __name__ == "__main__":
       main()
   EOF
   ```

5. **Commit Successfully**

   ```bash
   # Stage the fixed file
   git add src/calculate.py

   # Verify it passes checks
   ./run_quality_check.sh

   # Now commit should succeed
   git commit -m "Add new calculation function"
   ```

6. **Cleanup**
   ```bash
   # Discard the feature branch
   git checkout main
   git branch -D feature/new-calculation
   ```

## Troubleshooting During Demo

- **Missing Dependencies**

  ```bash
  # If Python dependencies are missing
  pip install -r requirements.txt

  # If Node dependencies are missing
  npm install
  ```

- **Permission Issues**

  ```bash
  # Make scripts executable
  chmod +x *.sh src/*.sh
  ```

- **Virtual Environment**

  ```bash
  # Create and activate virtual environment
  python -m venv venv
  source venv/bin/activate
  ```

- **SSL Certificate Issues**

  ```bash
  # Option 1: Use our certificate fix scripts
  ./fix_certificates.sh  # for macOS
  # OR
  ./fix_certificates_unix.sh  # for other Unix systems

  # Option 2: Set PYTHONPATH to use our SSL context fix
  export PYTHONPATH=$PWD
  echo "SSL certificate verification disabled (temporary fix)"

  # Option 3: Fix Python certificates properly (macOS)
  open /Applications/Python\ 3.x/Install\ Certificates.command

  # Option 4: Switch to VS Code mode (disables problematic validators)
  ./switch_mode.sh vscode
  ```

- **Pre-commit SSL Errors**

  ```bash
  # If pre-commit has SSL errors when downloading Node.js
  # Option 1: Switch to VS Code mode (recommended & easiest)
  ./switch_mode.sh vscode

  # Option 2: Install Node.js manually first
  brew install node  # On macOS with Homebrew

  # Option 3: Create a pre-commit config exclude
  cat > ~/.config/pre-commit/config.yaml << 'EOF'
  no_node: true
  EOF

  # Option 4: Run Python with our SSL context fix
  export PYTHONPATH=$PWD
  ```

## Presenter Notes

- Highlight the clear error messages designed for both humans and AI
- Emphasize language-agnostic capabilities
- Show how security issues are prioritized as errors
- Demonstrate how the tool integrates into the git workflow
- Explain how AI-friendly error messages help improve AI-generated code
- Show how the modular architecture allows for future extension
