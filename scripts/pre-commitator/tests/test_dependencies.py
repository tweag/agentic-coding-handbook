#!/usr/bin/env python3
"""
Dependency Test Script - Verifies that all required dependencies are correctly installed.
"""
import importlib
import subprocess
from typing import List, Tuple


def check_python_package(package_name: str) -> Tuple[bool, str]:
    """Check if a Python package is installed and return its version."""
    try:
        module = importlib.import_module(package_name)
        version = getattr(module, "__version__", "unknown")
        return True, version
    except ImportError:
        return False, "Not installed"


def check_command(command: List[str]) -> Tuple[bool, str]:
    """Check if a command-line tool is available."""
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        return True, result.stdout.strip()
    except (subprocess.SubprocessError, FileNotFoundError):
        return False, "Not available"


def main():
    """Run the dependency checks and display results."""
    print("\n🔍 Checking Pre-Commitator Dependencies...\n")

    # List of Python packages to check
    python_packages = [
        "pre_commit",
        "bandit",
        "black",
        "flake8",
        "isort",
        "lizard",
        "semgrep",
        "mypy",
    ]

    # List of command-line tools to check
    commands = [
        (["pre-commit", "--version"], "pre-commit"),
        (["bandit", "--version"], "bandit"),
        (["black", "--version"], "black"),
        (["npm", "--version"], "npm"),
        (["npx", "eslint", "--version"], "eslint"),
        (["git", "--version"], "git"),
    ]

    # Check Python packages
    print("Python Packages:")
    for package in python_packages:
        installed, version = check_python_package(package)
        status = "✅" if installed else "❌"
        print(f"  {status} {package:15} {version}")

    # Check command-line tools
    print("\nCommand-line Tools:")
    for command, name in commands:
        available, output = check_command(command)
        status = "✅" if available else "❌"
        print(f"  {status} {name:15} {output}")

    print("\n✅ Dependency check complete!")


if __name__ == "__main__":
    main()
