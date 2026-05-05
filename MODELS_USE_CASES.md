---
layout: page
title: Model Use Cases
parent: Tools & Setup
nav_order: 1
---

# Models Use Cases

When integrating AI agents into your development process, selecting the right foundation model is critical for productivity, quality of the output code, and cost-efficiency. Based on our internal experiment and industry observations, here’s how to evaluate and use the leading models:

## Claude Sonnet 4.6 (Anthropic)

**Strengths:** Best for reasoning-heavy tasks like debugging, architecture decisions, system design, and breaking down complex prompts. With Thinking effort set to High, it excels at multi-step planning and structured output.
**Context Window:** 200K tokens, well-suited for multi-file reasoning and complex feature generation.
**When to avoid:** High-frequency interactive prompting where speed is the priority, or when token costs are a concern.

### Ideal Use Cases for Claude Sonnet 4.6 (Anthropic)

- Writing comprehensive specs or planning files like `spec.md`, `plan.md` or `todo.md`.
- Refactoring legacy code with unclear logic.
- Debugging hard-to-identify issues with long history or dependencies.

## GPT-5.4 / GPT-5.4 mini (OpenAI)

**Strengths:** The GPT-5.4 family covers the full spectrum from fast/cheap to flagship reasoning. GPT-5.4 mini is the go-to for speed and cost; GPT-5.4 balances quality and cost; GPT-5.5 is also available for complex reasoning at higher cost.
**Context Window:** 400K tokens (GPT-5.4 mini), 1M tokens (GPT-5.4, GPT-5.5).
**When to avoid:** GPT-5.4 mini for tasks requiring deep multi-step reasoning — use GPT-5.4 or GPT-5.5 instead.

### Ideal Use Cases for GPT-5.4 / GPT-5.4 mini (OpenAI)

- Quick iteration of UI components and scaffolding (GPT-5.4 mini).
- Writing test files, simple APIs, or scaffolding endpoints (GPT-5.4 mini / GPT-5.4).
- Architectural reasoning, complex debugging, and coding tasks on par with Claude (GPT-5.4 / GPT-5.5).

## Gemini 2.5 Pro / Gemini 3.1 Pro (Google)

**Strengths:** Best model for full-repo understanding, DevOps, and infrastructure-as-code. Extremely powerful context window. Gemini 2.5 Pro is the current stable release; Gemini 3.1 Pro is available in preview with enhanced agentic and coding capabilities.

**Context Window:** Up to 1M tokens (Gemini 2.5 Pro).

**When to avoid:** Prompting conversationally on very small tasks — might be overkill in terms of latency and cost. Use Gemini 3 Flash (Preview) for lighter, high-volume tasks.

### Ideal Use Cases for Gemini 2.5 Pro / Gemini 3.1 Pro (Google)

- Modifying infra using CDK/Terraform.
- Coordinating changes across microservices or large monorepos.
- CI/CD automation, API gateway routing, or handling config-heavy workflows.

## Comparison table

| **LLM**           | **Best at**                                         | **Avoid when**                          |
| ----------------- | --------------------------------------------------- | --------------------------------------- |
| Claude Sonnet 4.6 | System reasoning, specs, debugging                  | You need fast short feedback loops      |
| GPT-5.4 mini      | UI, scaffolding, fast/cheap prompting               | You need deep logical accuracy          |
| GPT-5.4 / GPT-5.5 | Complex reasoning and coding on par with Claude    | Speed and low latency are the priority  |
| Gemini 2.5 Pro / 3.1 Pro | Infra/codebase-wide operations and larger codebases | You're doing small or interactive tasks |

Each model offers a unique advantage depending on the nature of the task. For day-to-day work, a combination approach using GPT-5.4 mini for speed and Claude Sonnet 4.6 or Gemini for structure often yields the best outcome.

## Token Efficiency & Cost Awareness in AI Coding Workflows

As AI becomes part of our daily software development process, it’s essential to understand that the way we interact with AI models impacts both cost and performance. Even if you're using tools like GitHub Copilot, Cursor, or Claude on a fixed monthly license, there are still important limits tied to usage — especially around context window size and token quotas.

This section explains why developers must learn to work efficiently, and why engineering leaders and managers should actively support a cost-conscious mindset.

## Why This Matters

### For Developers

- **Better prompts cost less:** Specific, scoped prompts reduce token use and improve AI accuracy.
- **Avoid degraded performance:** Tools like Cursor and Copilot operate under token and context limits. Once usage exceeds those thresholds, performance drops (longer latency, weaker completions, missing context).
- **Prevent feature lockout:** Some tools may stop working temporarily when quota caps are exceeded — requiring additional credits or waiting until reset.

### For Managers

- **A flat-rate is not unlimited:** Even with monthly pricing, most tools have soft or hard caps. Token abuse leads to throttling or degraded service across the team.
- **Track usage:** Understanding team-wide usage patterns can help plan licenses, detect misuse, and manage renewal tiers.
- **Token efficiency = productivity efficiency:** Well-structured AI interactions save engineering time, avoid retries, and improve project timelines.

## Best Practices for Developers: Prompt Efficiently, Work Smart

- **Be Specific, Not Chatty:** Replace vague instructions with task-focused prompts. Don’t: `Can you help me fix this maybe?`. Instead do: `Refactor validateUser() to support optional phone number.`.
- **Use Attachments, Not Dumps:** Don’t paste full files into prompts. Use file references or context attachment features (#codebase, Cursor context menu).
- **One Task per Prompt:** Instead of asking for a test, refactor, and docs in one go — split into focused steps. Reduces retries and output bloat.
- **Limit Output Size:** Add constraints: `Return only the code, no explanation.`, `Limit to 20 lines.` Keeps the interaction sharp and reduces unnecessary token consumption, especially in tools where both input and output count toward your quota.
- **Avoid Recursive Prompt Chains Without Limits:** Prompts like `Refine this 10 times` may sound clever but can generate thousands of tokens. Use: `Improve this once. Stop after 2 iterations.`
- **Use Lighter Models for Simpler Tasks:** For documentation, variable naming, or test generation, faster and cheaper options like GPT-5.4 mini are often sufficient.
  Reserve GPT-5.4, GPT-5.5, or Claude Sonnet 4.6 (with Thinking effort High) for architectural reasoning or multi-file refactoring.
- **Use Memory Banks and Instructions Files:** Store recurring context (architecture rules, naming patterns, stack details) in `.github/copilot-instructions.md`, `.cursor/rules`, or `CLAUDE.md`. This prevents repeating the same setup context in every prompt — a common source of wasted tokens.

| **Prompt Style**          | **Input Tokens** | **Output Tokens** | **Total** | **Result**               |
| ------------------------- | ---------------- | ----------------- | --------- | ------------------------ |
| Chatty, vague, multi-task | 700              | 1400              | 2100      | Low quality, AI misfires |
| Focused, scoped, clear    | 200              | 600               | 800       | High quality, no retries |

Even small improvements save thousands of tokens per day when repeated across engineers.

## What Managers Should Do

- Set token-awareness as a team expectation — just like we manage test coverage or code review discipline.
- Encourage shared context assets (instructions files, prompt plans, `spec.md`, etc.).
- Monitor usage if possible — via OpenAI dashboards, Claude usage logs, or billing APIs.
- Default to value-tier models where appropriate (e.g., staging/dev workflows).

By applying token-efficient practices, we keep our tools responsive, our budgets sustainable, and our workflows high-impact. This isn’t just about saving money — it’s about engineering with intention.

## References

- [Choosing the right AI model for your task](https://docs.github.com/en/copilot/using-github-copilot/ai-models/choosing-the-right-ai-model-for-your-task)

## Keep Reading

[Privacy Considerations](./PRIVACY.md)
