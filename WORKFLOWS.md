# Workflows

Agentic coding is not just about writing code faster with AI — it’s about adopting a new way of thinking and working. It shifts the developer’s role from line-by-line author to high-leverage problem solver, using AI tools to explore, plan, scaffold, validate, and iterate. To make this shift effective and repeatable, we rely on structured workflows grounded in a set of core principles.

## Core Principles of Agentic Coding Workflows

Prompting is the new coding interface: You don’t tell the AI just what to do — you show it how to think. Clear, scoped, and iterative prompts are essential.

Work in small, testable units: Break down tasks into vertical slices. The smaller the prompt scope, the better the quality of the AI’s response.

Context is everything: AI doesn’t “know” your project unless you tell it. Use tools like prompt plans, spec.md, MCPs, and .copilot-instructions.md to load the right information.

Validate early, validate often: TDD, pre-commit hooks, and self-correction loops turn validation into part of the coding loop — not an afterthought.

AI is a collaborator, not a replacement: Human judgment is still required for architecture, edge cases, and code reviews. The AI is there to scale your intent, not to replace it.

Use Git to keep track of changes: Work with AI to chunk the work in smaller batches and keep the practice of committing to git after coding, reviewing and testing each one of the batches. If changes are made to the wrong file due hallucinations, reverting the step is easy.

## Workflows are

- **[Spec-First Approach](./WORKFLOW_SPEC_FIRST_APPROACH.md):** AI coding agents like Copilot or Cursor rely entirely on what you give them as input. If your context is vague or scattered, the AI will produce code that’s inaccurate, inconsistent, or overly generic. That’s where Spec-First approach shines: it is an practice that allows you to feed the AI a high-quality, focused scope of work, leading to better outputs with fewer corrections.

- **[Automatic Code Validations](./WORKFLOW_AUTO_VALIDATIONS.md):** A powerful capability of AI coding agents is their ability to run code validation tools, analyze the feedback, and self-correct the code until it meets all defined quality standards. This turns your prompting loop into a smarter, more reliable workflow, where the AI not only writes code but also learns from validation outputs and fixes issues automatically.

- **[Test Driven Development](./WORKFLOW_TDD.md):** Test-Driven Development (TDD) and Agentic Coding may seem like opposites — one is structured and disciplined, the other fluid and intuitive. But when paired, they create a powerful feedback loop: TDD gives structure to your flow, and Agentic coding gives speed to your structure.This combination shines when you’re working with complex logic files, such as pricing engines, rules-based validators, or multi-condition workflows. Instead of prompting the AI to generate everything at once, you describe one behavior at a time through tests — and let the AI build up the logic incrementally, safely, and cleanly.

- **[Exploratory & Refactoring Workflow](./WORKFLOW_EXPLORATORY.md):** Explore → Plan → Code → Commit, AI tools like Claude, Cursor, and GitHub Copilot are not just code generators — they are reasoning engines. When used intentionally, they can help engineers dissect complex problems, map systems, and implement safe, scalable solutions. This workflow focuses on using AI for exploration and strategy before coding begins.

- **[Visual Feedback Workflow with AI Agents](./WORKFLOW_VISUAL_FEEDBACK.md):** When working on frontends, code alone doesn’t always tell the full story. What users see — and how the UI behaves across screen sizes, states, and interactions — is critical to quality. This workflow introduces how to use screenshots and browser context as inputs for AI-assisted iteration. By pairing screenshots with prompts and augmenting context via browser-based MCPs, developers can give AI direct visibility into what’s wrong — and receive precise, design-aligned suggestions for improvement.

- **[Debugging Workflow for Agentic Coding](./WORKFLOW_DEBUG.md):** Debugging in a Agentic coding workflow is not about blindly fixing bugs — it’s about building a feedback loop where AI helps identify, explain, and resolve issues systematically. This page outlines the core techniques to debug efficiently with AI agents, using tools like Cursor, Claude, and Model Context Providers (MCPs), while maintaining speed, quality, and confidence.

- **[Memory Bank](./WORKFLOW_MEMORY_BANK.md):** AI models like Copilot and Cursor don’t have persistent memory. They forget everything when you close the tab. That’s where the Memory Bank comes in. A Memory Bank is a structured, markdown-based documentation system that acts as long-term memory for your AI agent. It allows the assistant to “remember” your project context, decisions, and progress across.

## Keep Reading

[MCP Use Cases](./MCPS.md)