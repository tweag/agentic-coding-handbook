---
layout: default
title: Project Guidelines
parent: Tools & Setup
nav_order: 6
---

# Project Level Instructions

One of the most effective ways to improve the quality of AI-generated code is by configuring project-level instructions that guide the behavior of GitHub Copilot and other coding agents. These instructions act like a persistent memory layer — they’re automatically injected into the LLM’s context, helping it follow your project's specific conventions and patterns without needing to be re-explained in every prompt. Copilot instructions can be used for keeping the behavior of the agent as you desire for your workflow. It both keeps how it works in terms of actions is going to execute and its also enforces the code quality.

## Why This Matters

During the experiment, we found that codifying quality expectations and design patterns up front made the AI much more likely to generate correct, review-ready code. It also reduced the need for prompt repetition, improved consistency between developers, and accelerated onboarding.

This concept is directly aligned with Cursor’s .cursor/rules, which was a key enabler in our experiment. The good news is: GitHub Copilot now supports this too through custom instructions.

## What to Include in Project Instructions

Create a file named .github/copilot-instructions.md in the root of your repo. In this Markdown file, document anything you want the AI to consider "non-negotiable" about how your team works, such as:

- Architecture decisions (e.g., This project uses a layered architecture with separate domain and infrastructure folders.)
- Naming conventions and file structure guidelines
- Security patterns (e.g., All user input must be sanitized before DB insertion.)
- Code quality expectations (e.g., Use ?? instead of || for nullish checks.)
- Testing rules (e.g., Every service must include unit tests using Jest and describe.each for parameterized coverage.)
- What to avoid (e.g., Never use any as a type.)

> These instructions are automatically loaded by Copilot Chat when you're prompting in the project, without needing to be referenced in the chat.

## How to Write a Good Project Instructions File

The .github/copilot-instructions.md (or .cursor/rules) file helps AI generate code that aligns with your team’s standards. Think of it as writing onboarding notes for a junior dev who will follow your rules exactly — but won’t ask questions.

Follow these guidelines:

### Be clear and directive

- Use instruction-style language.
  ✅ `Use Axios for all HTTP requests`
  ❌ `We usually prefer Axios.`

### Be specific

- Avoid vague advice.
  ✅ `Put all utility functions in src/utils using camelCase.`
  ❌ `Keep things organized.`

### Prioritize what the AI needs

Focus on structure, naming, preferred libraries, testing, and patterns. Skip in-depth business context it won’t help generation and should be shared as part of the implementation planning and execution.

### Use headers to group rules

Organize content with topics like:

- Project Structure
- Naming Conventions
- Error Handling
- Testing
- Things to Avoid

**Keep it short:** Stick to 1–2 pages. If it’s too long, it may be partially ignored due to context limits.

**Maintain it like code:** Update as project patterns evolve — especially before onboarding or major feature work.

## Resources and Examples

- You can find many rule examples at cursor.directory
- Cursor’s `.cursor/rules` and GitHub’s `.github/copilot-instructions.md` follow the same format — Markdown — and can be reused across tools with little to no adjustment.

- [Clean Code Rules Prompt](https://shumerprompt.com/prompts/clean-code-rules-prompt-554351c6-3bcb-4c20-9c77-f831b4aa6b0a)
- [Code Quality Guidelines Prompt](https://shumerprompt.com/prompts/-code-quality-guidelines-prompt-661c6a3f-cb69-46e6-b75c-97f7bfbb514b)
- [React Rules Prompt](https://shumerprompt.com/prompts/react-rules-prompt-76302cd0-5448-4056-a90e-4057388a9149)
- [Python Best Practices Prompt](https://shumerprompt.com/prompts/python-best-practices-prompt-ac25d837-ff42-4b89-92b1-5a7bbb558047)

```markdown
# COPILOT INSTRUCTIONS OPERATIONAL GUIDELINES

## PRIME DIRECTIVE

Avoid working on more than one file at a time.
Multiple simultaneous edits to a file will cause corruption.
Be chatting and teach about what you are doing while coding.

## LARGE FILE & COMPLEX CHANGE PROTOCOL

### MANDATORY PLANNING PHASE

When working with large files (>300 lines) or complex changes:

1. ALWAYS start by creating a detailed plan BEFORE making any edits
2. Your plan MUST include:

- All functions/sections that need modification
- The order in which changes should be applied
- Dependencies between changes
- Estimated number of separate edits required

3. Format your plan as:

## PROPOSED EDIT PLAN

Working with: [filename]
Total planned edits: [number]

### MAKING EDITS

- Focus on one conceptual change at a time
- Show clear "before" and "after" snippets when proposing changes
- Include concise explanations of what changed and why
- Always check if the edit maintains the project's coding style

### Edit sequence:

1. [First specific change] - Purpose: [why]
2. [Second specific change] - Purpose: [why]
3. Do you approve this plan? I'll proceed with Edit [number] after your confirmation.
4. WAIT for explicit user confirmation before making ANY edits when user ok edit [number]

### EXECUTION PHASE:

- After each individual edit, clearly indicate progress:
  "✅ Completed edit [#] of [total]. Ready for next edit?"
- If you discover additional needed changes during editing:
- STOP and update the plan
- Get approval before continuing

### REFACTORING GUIDANCE:

When refactoring large files:

- Break work into logical, independently functional chunks
- Ensure each intermediate state maintains functionality
- Consider temporary duplication as a valid interim step
- Always indicate the refactoring pattern being applied

### RATE LIMIT AVOIDANCE:

- For very large files, suggest splitting changes across multiple sessions
- Prioritize changes that are logically complete units
- Always provide clear stopping points

## General Requirements:

Use modern technologies as described below for all code suggestions. Prioritize clean, maintainable code with appropriate comments.
```

## Keep Reading

[Examples](./examples.md)
