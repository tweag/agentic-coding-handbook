#!/usr/bin/env python3
"""
Pre-commit quality gate script that validates code quality and security
on files staged for commit.

This module provides the core validation engine for the Pre-Commitator tool.
It runs various code quality and security tools on specified files and reports
issues found.
"""
import json
import os
import subprocess
import sys
from typing import Dict, List, Optional, Set, Tuple


class QualityGate:
    """Runs code quality and security checks on files.

    This class orchestrates the execution of various code quality and security
    validation tools, collects their results, and formats them for display.

    Attributes:
        errors (List[str]): List of error messages found during validation.
        warnings (List[str]): List of warning messages found during validation.
        files (List[str]): List of files to be checked.
    """

    # File extension mappings
    PYTHON_EXTENSIONS = {".py"}
    JAVASCRIPT_EXTENSIONS = {".js", ".jsx", ".ts", ".tsx"}
    CODE_EXTENSIONS = {
        ".py",
        ".js",
        ".jsx",
        ".ts",
        ".tsx",
        ".java",
        ".cpp",
        ".c",
        ".go",
        ".rb",
        ".php",
        ".swift",
        ".kt",
    }

    def __init__(self):
        """Initialize the QualityGate with empty results lists."""
        self.errors = []
        self.warnings = []
        self.files = []

    def get_staged_files(self) -> List[str]:
        """Get list of files staged for commit in the git repository.

        Returns:
            List[str]: A list of file paths that are staged for commit.
        """
        try:
            result = subprocess.run(
                ["git", "diff", "--name-only", "--cached"],
                capture_output=True,
                text=True,
                check=True,
            )
            files = [f.strip() for f in result.stdout.splitlines() if os.path.exists(f)]
            self.files = files
            return files
        except subprocess.SubprocessError:
            self.errors.append("Error: Failed to get staged files from git")
            return []

    def _filter_files_by_extension(
        self, files: List[str], extensions: Set[str]
    ) -> List[str]:
        """Filter files by their extensions.

        Args:
            files: List of file paths to filter
            extensions: Set of extensions to include (with dot, e.g. {'.py', '.js'})

        Returns:
            List of filtered file paths
        """
        return [f for f in files if any(f.endswith(ext) for ext in extensions)]

    def _run_tool(
        self, command: List[str], tool_name: str
    ) -> Optional[subprocess.CompletedProcess]:
        """Run an external tool and handle common errors.

        Args:
            command: Command to run as a list of strings
            tool_name: Name of the tool for error reporting

        Returns:
            CompletedProcess object or None if the tool is not found
        """
        try:
            return subprocess.run(command, capture_output=True, text=True, check=False)
        except FileNotFoundError:
            msg = f"Warning: {tool_name} not found."
            self.warnings.append(
                f"{msg} Install with 'pip install {tool_name.lower()}'"
            )
            return None
        except Exception as e:
            self.warnings.append(f"Warning: {tool_name} failed with error: {str(e)}")
            return None

    def run_lizard(self, files: List[str]) -> None:
        """Run Lizard complexity analysis on code files.

        Lizard analyzes code complexity metrics such as:
        - Cyclomatic complexity (CCN)
        - Function length
        - Number of parameters

        Args:
            files: List of file paths to analyze
        """
        # Check if Lizard should be disabled (e.g., for VS Code mode)
        if os.environ.get("DISABLE_LIZARD") == "1":
            self.warnings.append(
                "Lizard skipped: Disabled by DISABLE_LIZARD=1 environment variable"
            )
            return

        code_files = self._filter_files_by_extension(files, self.CODE_EXTENSIONS)
        if not code_files:
            return

        cmd = [
            "lizard",
            "--warnings_only",
            "--CCN",
            "10",  # Maximum cyclomatic complexity
            "--length",
            "100",  # Maximum function length
            "--arguments",
            "5",  # Maximum number of arguments
        ] + code_files

        result = self._run_tool(cmd, "Lizard")
        if result and result.stdout.strip():
            complexity_issues = result.stdout.strip().split("\n")
            for issue in complexity_issues:
                if issue.strip():
                    self.warnings.append(f"Complexity: {issue.strip()}")

    def _parse_json_output(
        self, output: str, error_output: str, tool_name: str
    ) -> Optional[Dict]:
        """Parse JSON output from a tool.

        Args:
            output: Standard output containing JSON
            error_output: Standard error output
            tool_name: Name of the tool for error reporting

        Returns:
            Parsed JSON as dict or None if parsing failed
        """
        try:
            return json.loads(output)
        except json.JSONDecodeError:
            if error_output:
                self.warnings.append(f"{tool_name} warning: {error_output}")
            return None

    def run_bandit(self, files: List[str]) -> None:
        """Run Bandit security analysis on Python files.

        Bandit is a security linter designed to find common security issues in Python code.
        It checks for issues like:
        - Use of dangerous functions (eval, exec)
        - Hardcoded passwords
        - SQL injection vulnerabilities
        - Shell injection vulnerabilities

        Args:
            files: List of file paths to analyze
        """
        # Check if Bandit should be disabled
        if os.environ.get("DISABLE_BANDIT") == "1":
            self.warnings.append(
                "Bandit skipped: Disabled by DISABLE_BANDIT=1 environment variable"
            )
            return

        py_files = self._filter_files_by_extension(files, self.PYTHON_EXTENSIONS)
        if not py_files:
            return

        cmd = ["bandit", "-f", "json"] + py_files
        result = self._run_tool(cmd, "Bandit")
        if not result:
            return

        bandit_results = self._parse_json_output(result.stdout, result.stderr, "Bandit")
        if not bandit_results:
            return

        for issue in bandit_results.get("results", []):
            severity = issue.get("issue_severity", "?")
            issue_text = issue.get("issue_text", "Unknown issue")
            filename = issue.get("filename", "unknown")
            line = issue.get("line_number", 0)

            if severity == "HIGH":
                self.errors.append(f"Security: {filename}:{line} - {issue_text}")
            else:
                self.warnings.append(f"Security: {filename}:{line} - {issue_text}")

    def run_eslint(self, files: List[str]) -> None:
        """Run ESLint on JavaScript/TypeScript files.

        ESLint is a static code analysis tool for identifying problematic patterns in JavaScript code.
        It checks for issues like:
        - Syntax errors
        - Bad practices
        - Style inconsistencies
        - Security vulnerabilities (with security plugin)

        Args:
            files: List of file paths to analyze
        """
        # Check if ESLint should be disabled (e.g., for VS Code mode)
        if os.environ.get("DISABLE_ESLINT") == "1":
            self.warnings.append(
                "ESLint skipped: Disabled by DISABLE_ESLINT=1 environment variable"
            )
            return

        js_files = self._filter_files_by_extension(files, self.JAVASCRIPT_EXTENSIONS)
        if not js_files:
            return

        cmd = ["npx", "eslint", "--format", "json"] + js_files
        result = self._run_tool(cmd, "ESLint")
        if not result:
            return

        lint_results = self._parse_json_output(result.stdout, result.stderr, "ESLint")
        if not lint_results:
            # Special handling for ESLint stderr
            if result.stderr and "Error:" in result.stderr:
                self.warnings.append(f"ESLint warning: {result.stderr}")
            return

        for file_result in lint_results:
            filename = file_result.get("filePath", "unknown")
            for message in file_result.get("messages", []):
                severity = message.get("severity", 0)
                msg = message.get("message", "Unknown issue")
                line = message.get("line", 0)

                # ESLint severity: 1=warning, 2=error
                if severity >= 2:  # Error
                    self.errors.append(f"ESLint: {filename}:{line} - {msg}")
                else:  # Warning
                    self.warnings.append(f"ESLint: {filename}:{line} - {msg}")

    def run_semgrep(self, files: List[str]) -> None:
        """Run Semgrep security scanner on code files.

        Semgrep is a lightweight static analysis tool for finding bugs, security vulnerabilities,
        and enforcing code standards. It works across many languages and can detect complex patterns.

        Args:
            files: List of file paths to analyze
        """
        # Check if Semgrep should be disabled
        if os.environ.get("DISABLE_SEMGREP") == "1":
            self.warnings.append(
                "Semgrep skipped: Disabled by DISABLE_SEMGREP=1 environment variable"
            )
            return

        if not files:
            return

        # Filter files by common source code extensions
        filtered_files = self._filter_files_by_extension(files, self.CODE_EXTENSIONS)
        if not filtered_files:
            return

        cmd = ["semgrep", "--config", "auto", "--json", "--error"] + filtered_files
        result = self._run_tool(cmd, "Semgrep")
        if not result:
            return

        semgrep_results = self._parse_json_output(
            result.stdout, result.stderr, "Semgrep"
        )
        if not semgrep_results:
            return

        for issue in semgrep_results.get("results", []):
            # Extract issue details with safe nested access
            extra = issue.get("extra", {})
            severity = extra.get("severity", "medium")
            message = extra.get("message", "Unknown issue")
            path = issue.get("path", "unknown")
            start = issue.get("start", {})
            line = start.get("line", 0)

            # High severity issues are errors, others are warnings
            if severity == "ERROR" or severity == "HIGH":
                self.errors.append(f"Semgrep: {path}:{line} - {message}")
            else:
                self.warnings.append(f"Semgrep: {path}:{line} - {message}")

    def run_all_checks(
        self, specified_files: Optional[List[str]] = None
    ) -> Tuple[bool, List[str]]:
        """Run all quality checks and return status and messages.

        This method orchestrates the entire validation process by running each tool
        on the appropriate files and collecting the results.

        Args:
            specified_files: Optional list of specific files to check. If not provided,
                             staged files from git will be used.

        Returns:
            Tuple containing:
                - Boolean indicating success (True) or failure (False)
                - List of message strings to display to the user
        """
        # Determine which files to check
        if specified_files:
            files = specified_files
            self.files = files
        else:
            files = self.get_staged_files()

        if not files:
            return True, ["No files to check"]

        # Clear previous results
        self.errors = []
        self.warnings = []

        # Run various checks
        self.run_lizard(files)
        self.run_bandit(files)
        self.run_eslint(files)
        self.run_semgrep(files)

        # Format the output messages
        messages = self._format_output_messages()

        # Return status (True if no errors, False otherwise)
        return len(self.errors) == 0, messages

    def _format_output_messages(self) -> List[str]:
        """Format validation results into human-readable messages.

        Returns:
            List of formatted message strings
        """
        messages = []

        # Add errors with emoji and formatting
        if self.errors:
            messages.append("\n🚫 ERRORS:")
            for error in self.errors:
                messages.append(f"  - {error}")

        # Add warnings with emoji and formatting
        if self.warnings:
            messages.append("\n⚠️ WARNINGS:")
            for warning in self.warnings:
                messages.append(f"  - {warning}")

        # Success message if no issues found
        if not self.errors and not self.warnings:
            messages.append("\n✅ All quality checks passed!")

        return messages


def main() -> None:
    """Main entry point for the quality gate script.

    This function handles command-line execution of the quality gate.
    It processes command-line arguments, runs the quality checks,
    and displays the results to the user.

    Returns:
        None. Exits with status code 0 for success, 1 for failure.
    """
    print("\n🔍 Running Code Quality Gate...")
    gate = QualityGate()

    # Process command-line arguments
    specified_files = sys.argv[1:] if len(sys.argv) > 1 else None

    # Run all quality checks
    success, messages = gate.run_all_checks(specified_files)

    # Display results
    for message in messages:
        print(message)

    # Exit with appropriate status code and message
    if not success:
        print("\n❌ Quality gate failed! Please fix the errors above.")
        sys.exit(1)
    else:
        print("\n✅ Quality gate passed!")
        sys.exit(0)


if __name__ == "__main__":
    main()
