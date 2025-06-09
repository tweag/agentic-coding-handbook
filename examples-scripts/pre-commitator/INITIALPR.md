Pre-Commitator is a powerful pre-commit validation tool that ensures your code meets quality and security standards before it's committed. It's designed to detect
issues at the earliest possible point in the development lifecycle while providing a smooth developer experience.

Overview

This PR introduces Pre-Commitator with a robust auto-staging feature that significantly improves the developer workflow. The tool combines multiple validation
techniques into a unified quality gate that runs automatically before code is committed.

Key Features

- Multi-Language Support: Works with Python, JavaScript, TypeScript, Java, and more
- VS Code & Terminal Modes: Environment-specific configurations to prevent SSL certificate and IDE integration issues
- Comprehensive Validation:
  - Code complexity analysis via Lizard
  - Security scanning via Bandit, Semgrep, and Horusec
  - Style enforcement via Black and ESLint
  - File hygiene checks (whitespace, EOF newlines)
- Auto-Stage Capability: Automatically stages files modified by pre-commit hooks
- Clear Error Messages: Designed to be understood by both humans and AI
- Performance Optimized: Only checks files being committed

Auto-Stage Implementation

The auto-stage feature addresses a significant pain point in the pre-commit workflow:

1. When pre-commit hooks automatically fix issues (like trailing whitespace)
2. The auto-stage hook detects these modifications
3. Modified files are automatically staged
4. User can simply run git commit again to complete their commit

This eliminates the frustrating manual step of having to git add files that were modified by hooks before committing again.

Technical Architecture

Pre-Commitator consists of several key components:

- Quality Gate Engine (quality_gate.py): Core validation logic
- Pre-Commit Hook Integration (pre_commit_hook.sh): Git hook integration
- Auto-Stage Hook (auto_stage_hook.sh): Seamless commit experience
- Mode Switcher (switch_mode.sh): Environment-specific configuration with SSL certificate issue handling
- Command-Line Interface (run_quality_check.sh): Manual validation tool

The implementation is designed to be flexible, extensible, and developer-friendly, making code quality enforcement a seamless part of the development workflow rather
than a hurdle.
