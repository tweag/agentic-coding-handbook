---
layout: default
title: Debug Workflow
parent: Core Workflows
nav_order: 6
---

# Debugging Workflow for Agentic Coding

Debugging in a Agentic coding workflow is not about blindly fixing bugs — it’s about building a feedback loop where AI helps identify, explain, and resolve issues systematically.

This page outlines the core techniques to debug efficiently with AI agents, using tools like Cursor, Claude, and Model Context Providers (MCPs), while maintaining speed, quality, and confidence.

## Principles Behind Agentic Debugging

- AI can think, but it needs context — error messages, logs, screenshots, and expectations.
- Debugging isn’t a guessing game — it’s a structured narrowing of possible causes.
- Reason before fixing — the best bugfixes come after deliberate analysis.
- Debugging is also about prevention — adding logs, tests, and checkpoints helps catch bugs before they escalate.

## Agentic Debugging Workflow

### Let AI iterate over its own fix and testing loop

Start with a low-stakes prompt using Agent Mode:

```txt
The login form isn’t submitting. Iterate the the loop of attempting to submit, understanding the issue and fixing.
```

Use it when the bug is simple or safe to attempt fixing directly. Cursor excels at debugging React, Next.js, or backend projects this way — particularly via terminal-aware agents.

### Prompt AI to Reason First, Then Act

Use reasoning-first prompts before allowing code changes:

```txt
List 5–7 possible causes for this issue and propose diagnostics for each. Don’t write code yet.
```

This activates Chain-of-Thought logic and prevents AI from jumping to premature fixes.

### Add Logs to Help the AI Debug

Ask the AI to inject logs or debug statements before solving:

```txt
Add logs to print input payload, validation output, and DB query results in this flow.
```

After running the app, copy the output back into the chat or attach logs using Copilot terminal or browser integrations.

### Feed Logs and Errors from the Right Contexts

Use MCPs to supply runtime feedback:

- Browser Console → for UI bugs and script failures
- Terminal Logs → for backend and test runs
- Cloud Logs → from CloudWatch, Kibana, Grafana Loki

Example prompt:

```txt
Use MCP to fetch the last logs from CloudWatch and identify the cause of the 502 error.
```

Paste logs directly when MCPs are unavailable:

```txt
This error occurred after login: TypeError: Cannot read properties of null — fix based on this trace.
```

### Investigate Code Changes via GitHub MCPs

Sometimes bugs are caused by recent commits.

Use:

```txt
Fetch the latest GitHub PRs that changed the auth.ts file. Summarize the changes and identify what could have broken session persistence.
```

This gives the AI critical historical context to connect changes to symptoms.

### Keep Debugging State Clean

- Start a new chat or agent session when context gets noisy
- Revert broken branches using version control or Cursor's "Revert to checkpoint" feature
- Prompt: `Reset the state to the last working version before commit a1b2c3.`

### Two-Stage Debugging Loop

Use this method when bugs are tricky:

- Ask AI to hypothesize and explain.
- Only implement if the plan makes sense to you.
- Favor to use TDD to execute the fix, by writing new tests and running existing ones on every change.
- Validate one step at a time — don’t let the AI go rogue across files.

Prompt:

```txt
Explain what’s broken and how to fix it, but do not modify any files yet.
```

### Preventive Debugging Practices

- Always run locally before committing. Confirm the bug is reproducible.
- Use spec.md and prompt plans to describe expectations clearly.
- Create checkpoint commits after major milestones.
- Add unit and behavior tests to document expected behavior before refactoring.

## Summary: Debugging with AI, Done Right

| **Practice**                | **Benefit**                    |
| --------------------------- | ------------------------------ |
| YOLO Mode                   | Fast fixes for obvious bugs    |
| Chain-of-Thought Prompts    | Prevents wild guesses          |
| Logging Before Fixing       | Easier diagnosis               |
| MCPs for Logs & Errors      | Real production context        |
| GitHub MCP for Code Changes | Tracks regressions             |
| Two-Stage Debugging         | Reduces rework and scope creep |
| Checkpoints & Resets        | Keeps dev environment clean    |

Debugging is where most engineers waste time. With structured prompting, context injection, and thoughtful reasoning, agentic debugging becomes a superpower — not a struggle.

## References

- [Using Copilot to Debug the Front End](https://www.loom.com/share/50de880c8ce5466d9d21c56e9d00bc30?sid=0c35aea6-596f-46e5-a9e3-3e6d6867b6fc)

## Keep Reading

[Memory Bank Workflow](./WORKFLOW_MEMORY_BANK.md)
