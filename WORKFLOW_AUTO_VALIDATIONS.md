---
layout: default
title: Auto Validations
parent: Core Workflows
nav_order: 7
---

# Automatic Code Validations

A powerful capability of AI coding agents is their ability to run code validation tools, analyze the feedback, and self-correct the code until it meets all defined quality standards. This turns your prompting loop into a smarter, more reliable workflow, where the AI not only writes code but also learns from validation outputs and fixes issues automatically.

## Why It Matters

In our experiment, this approach drastically reduced rework, improved code quality, and made the AI a more useful coding assistant. Instead of shipping code with hidden lint errors or poor complexity, the agent could catch and fix these issues in real time, before a human even reviewed it.

## How It Works

- The developer prompts the AI to implement a function or feature.
- The AI writes the code and runs validation scripts (linters, formatters, test suites, etc.).
- If a validation fails, the AI uses the feedback from the terminal output as new context and iterates.
- Once all validations pass, the AI can move on and proceed with committing the code.

## Example: Cognitive Complexity with Lizard

We use a pre-configured script that runs [Lizard](https://github.com/terryyin/lizard) and enforces a cognitive complexity limit of 10.

- The AI writes a new function.
- It runs the Lizard script.
- The script returns: `Function X has cognitive complexity of 15`
- The AI picks up this feedback and rewrites the function to bring complexity under the limit.

This loop can be applied to many validation tools.

## Common Validations Used in the Loop

- Linters (e.g., ESLint)
- Formatters (e.g., Prettier)
- Unit tests (e.g., Jest, Vitest)
- Code complexity analyzers (e.g., Lizard, SonarQube)
- Static analysis tools (e.g., TypeScript compiler, Horusec, Bandit)

## Git Integration with Pre-Commit / Pre-Push Hooks

This self-correction loop can also be extended to Git commands. For example:

- You ask the AI: `Stage and commit all changes that pass our validations.`
- The AI:
  - Runs the pre-commit hooks
  - Captures the output
  - Fixes any issues that arise
  - Repeats until validations pass
  - Then commits the changes

This ensures that no invalid code ever gets committed, keeping your repo clean and compliant with team rules.

## References

- [Enhancing Code Quality with AI](https://www.loom.com/share/32bd23d355d9438587d55d7a87b58ed1)

## Keep Reading

[Exploratory & Refactoring Workflow](./WORKFLOW_EXPLORATORY.md)
