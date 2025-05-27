# Pre-Commitator Documentation

Welcome to the Pre-Commitator documentation! This directory contains guides and resources to help you get the most out of Pre-Commitator.

## Getting Started

- [Quickstart Guide](quickstart.md) - Get up and running in 5 minutes
- [Installation & Setup](../SETUP.md) - Detailed installation instructions

## Troubleshooting & Help

- [Troubleshooting Guide](troubleshooting.md) - Solutions to common issues
- [Contributing Guide](../CONTRIBUTING.md) - How to contribute to the project

## Reference

- [Configuration Reference](../config/README.md) - Configuration options
- [Main README](../README.md) - Project overview

## Directory Structure

```
docs/
├── images/              # Diagrams and screenshots
├── quickstart.md        # Quick start guide for new users
├── troubleshooting.md   # Solutions to common issues
└── README.md            # This file
```

## Command Reference

| Command | Description |
|---------|-------------|
| `./install.sh` | Install Pre-Commitator |
| `./install.sh -y` | Non-interactive installation |
| `./run_quality_check.sh` | Check staged files |
| `./run_quality_check.sh file.py` | Check a specific file |
| `./run_quality_check.sh --all` | Check all repository files |
| `./run_quality_check.sh --help` | Show all options |
