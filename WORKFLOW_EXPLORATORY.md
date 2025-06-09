# Exploratory & Refactoring Workflow

> ***Explore → Plan → Code → Commit***

AI tools like Claude, Cursor, and GitHub Copilot are not just code generators — they are reasoning engines. When used intentionally, they can help engineers dissect complex problems, map systems, and implement safe, scalable solutions. This workflow focuses on using AI for exploration and strategy before coding begins.

## Explore – Understand the Problem & Codebase

Before jumping into implementation, prompt the AI to explore the system like a senior engineer would. Ask it to:

- Summarize how a module or flow works: `How does the authentication middleware interact with the session manager?`
- Trace dependencies or call hierarchies: `Which services rely on PaymentService?`
- Review relevant files without writing any code: `Read the files related to logging, but do not write any code yet. Just summarize what they do.`
- Visualize architecture: `Generate a component diagram showing the flow from createInvoice() to downstream services.`

This builds context and exposes unknowns before planning a solution.

## Plan – Reason Through the Solution

Once the problem is understood, ask the AI to make a plan:

- Break down the problem: `What steps are required to decouple the billing module from user management?`
- Think before acting: Use prompts like `Think hard before answering` or `Ultrathink mode: what are the tradeoffs of each solution path?`
- Identify risks or impact: `If we refactor NotificationService, what might break downstream?`
- Generate a step-by-step implementation roadmap: `Write a plan to migrate this legacy feature without regressions.`

Encourage the AI to validate assumptions and propose alternative solutions when appropriate.

## Code – Build Safely and Iteratively

With a plan in place, start coding:

- Prompt the AI to write code one slice at a time, aligned to the plan. `Implement step 1 of the plan: extract logging into a standalone module.`
- Use safety net practices:
  - Write or run unit tests before and after each change
  - Use AI to generate test cases for edge behaviors
  - Refactor in small chunks, validating at each step
  - Ask for help in keeping scope clean: `Refactor this method but keep all existing tests green.`

## Commit – Finalize, Document, and Share

Once the solution is complete:

- Ask the AI to summarize changes:
"Generate a changelog summary and commit message based on the last 3 modified files."
- Auto-update documentation:
"Update the README and Swagger docs to reflect changes to GET /users."
- Push and open a PR, optionally using Claude/Cursor commands like /commit, /pr, or GitHub CLI integration.

## Benefits of the Exploratory Workflow

- Reduces blind spots before writing code
- Improves reasoning, planning, and system understanding
- Supports safer, modular implementations
- Boosts onboarding speed for unfamiliar codebases
- Encourages discipline without blocking creativity

## References

- [Refactoring Code with AI Assistance](https://www.loom.com/share/bc30c068b8c54038aaa02697ea69a9bd?sid=9ba2d4db-239a-4017-838d-c3195e67fc38)