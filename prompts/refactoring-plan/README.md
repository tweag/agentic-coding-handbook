# Code Refactoring Prompt

This prompt helps developers plan and execute targeted refactoring to improve code quality, maintainability, and readability without altering core behavior.

## Purpose

The refactoring prompt assists with:

- Planning focused code improvements in specific areas of your codebase
- Identifying issues like complexity, duplication, and code smells
- Creating a safe, incremental approach to refactoring
- Validating that behavior is preserved after changes
- Integrating with static analysis tools (optional)

## When to Use

This prompt is especially useful when:

- You need to extend or modify legacy code and want to improve it first
- Code reviewers have suggested improvements after a PR
- Quality gates (e.g., Lizard or SonarQube) highlight issues in a module
- You're improving AI-generated code before adding features
- You're paying down technical debt in a controlled, safe manner

## How to Use

1. **Run the prompt**: Use [PROMPT.md](./PROMPT.md) as your prompt to Copilot or another AI assistant.

2. **Answer the initial questions**:
   - Which part of code needs refactoring (files, directories, components)
   - Your main concerns with the current code

3. **Let the AI analyze your code**: The AI will:
   - Examine your codebase structure
   - Identify potential issues
   - Ask clarifying questions about your priorities

4. **Review the refactoring plan**: The AI will propose:
   - A step-by-step refactoring strategy
   - Specific code changes to implement
   - Testing approaches to verify behavior

5. **Execute the plan**: Follow the suggested steps, making incremental changes and validating as you go.

## MCP Integration

This prompt supports Model Context Protocol (MCP) integrations to enhance analysis with:

- Static analysis tools like SonarQube
- Complexity metrics from tools like Lizard
- Linting results from ESLint/TSLint
- Test coverage data

If these integrations are available in your environment, the AI will automatically leverage them.

## Example Usage

```
I need help refactoring the authentication flow in my React application. It's currently spread across multiple files in src/common/auth/ and has become overly complex with duplicate logic. I want to improve its structure and testability without changing the core behavior.
```

The AI will guide you through analyzing and improving the code in a conversational manner.
