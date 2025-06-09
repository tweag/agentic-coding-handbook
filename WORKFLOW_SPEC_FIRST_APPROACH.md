# Spec-First Approach

AI coding agents like Copilot or Cursor rely entirely on what you give them as input. If your context is vague or scattered, the AI will produce code that’s inaccurate, inconsistent, or overly generic. That’s where Spec-First approach shines: it is an practice that allows you to feed the AI a high-quality, focused scope of work, leading to better outputs with fewer corrections.

Spec-First is about starting the agent conversation with clarity, not code. Instead of jumping into implementation, you begin by collaborating with the AI to generate a detailed, structured specification of the feature. This gives both you and the model a shared understanding before a single line of code is written.

But here’s the key: you don’t write the spec manually. You generate it by prompting the AI inside Copilot Agent Mode, with access to your codebase, using a reasoning-capable model.

## Why This Matters

- LLMs don’t read your mind. They need structured, explicit context.
- A well-written spec gives the AI a clear mental model of the feature.
- It enables prompt modularity — breaking work into smaller, action oriented and atomic level chunks.
- It makes AI collaboration more predictable, testable, and scalable.

## How to Apply Spec-First in Practice

**Open GitHub Copilot Chat in Agent Mode:** Make sure Agent Mode is active and has access to the codebase (using #codebase or context attachments). This gives the AI visibility into file structure, dependencies, and naming conventions, making its responses more grounded and accurate.

**Use a Reasoning Model:** Pick a model or enable reasoning in models like Claude Sonnet 3.7, GPT o* or Gemini 2.5 Pro. These models excel at multi-step thinking and structured dialogue, which is ideal for generating specs. Gemini 2.5 Pro has a larger context window, which will help to write a better plan over a larger codebase.

**Create the files plan.md and todo.md:** Creating plan.md and todo.md ensures that AI coding agents work from a clear, structured understanding of the project. plan.md captures the full implementation blueprint, while todo.md breaks it into small, promptable tasks, enabling safer, more accurate code generation, better validation checkpoints, and faster, more reliable development cycles.