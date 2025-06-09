# Memory Bank

AI models like Copilot and Cursor don’t have persistent memory. They forget everything when you close the tab. That’s where the Memory Bank comes in. A Memory Bank is a structured, markdown-based documentation system that acts as long-term memory for your AI agent. It allows the assistant to “remember” your project context, decisions, and progress across sessions.

## Why It Matters

When using an AI coding agent, continuity matters. Without memory, you waste time re-explaining what the project is, what’s been done, and what patterns to follow. The Memory Bank solves this by externalizing memory into a set of files the agent can read, reference, and update.

## Typical Memory Bank Files

- `projectbrief.md:` Overall scope and goals
- `productContext.md:` UX, users, and problems being solved
- `systemPatterns.md:` Architecture, design patterns, and decisions
- `techContext.md:`Stack, dependencies, and constraints
- `activeContext.md:` Current task, context, and working notes
- `progress.md:` Status log of what’s done and what’s pending

These files live in a folder like `/memory-bank/` or `.github/copilot-instructions.md` and are read at the start of each session. Cursor or Copilot Agent can be guided via custom instructions to always load and update these files.

## How It Works in Practice

- You and the agent update the memory as you go.
- You can ask the agent to “update memory” when progress is made.
- This keeps the AI grounded and reduces hallucinations or rework.
- With an MCP server (like @alioshr/memory-bank-mcp), you can even manage memory banks across multiple projects remotely.

Benefits

- **Persistence:** Memory is retained between sessions.
- **Fewer mistakes:** Past issues and decisions are remembered.
- **Faster onboarding:** Anyone (AI or human) can quickly get up to speed.
- **Better collaboration:** Memory Bank becomes your single source of truth.

This is how we turn stateless LLMs into project-aware partners. You write code — the AI helps more effectively.

## ✅ What should live in a Memory Bank

- **Architecture decisions and design patterns:** Such as `We use hexagonal architecture in the backend. Controllers should not contain business logic.`
- **Project constraints and stack-specific rules:** Such as `Use TanStack Query for all data fetching. Avoid raw fetch or Axios.`
- **Current focus and open technical challenges:** Such as `Currently refactoring authentication flow. Login and refresh token logic is under review.`

## ❌ What should not live in a Memory Bank

- **Sensitive credentials or secrets:** Never include tokens, passwords, database URLs, or access keys — these don’t help AI and create security risks.
- **Detailed code snippets or implementation blocks:** Avoid dumping large functions or full classes — use summaries or refer to file names instead.
- **Unfiltered chat transcripts or raw meeting notes:** Keep content structured, relevant, and purposeful — memory is for context, not clutter.

## Setting Up a Memory Bank with GitHub Copilot

GitHub Copilot doesn’t have built-in memory between sessions, but you can simulate it by using project-level instruction files that act as a persistent Memory Bank. These files are automatically loaded into the model’s context when you prompt inside your project — allowing the AI to "remember" decisions, architecture, conventions, and current tasks.

## Step-by-Step Setup

- Create a `.github/copilot-instructions.m`d file: This is the file GitHub Copilot Agent will read for project-level context. It should live at the root of your project, under a `.github/` folder.
- Define the structure: We recommend structuring the file using the Memory Bank pattern from our experiment:

```txt
# projectbrief.md  
Describes the overall goals of the project, what we're building, and for whom.

# productContext.md  
Why this project exists, the problems it solves, user experience goals, and business context.

# systemPatterns.md  
Document architecture choices, common design patterns, and preferred technical structures.

# techContext.md  
Describe technologies used, external APIs, dev setup, tooling decisions, and known constraints.

# activeContext.md  
Current task, recent changes, open issues, known challenges, and next steps.

# progress.md  
Track completed features, blockers, and evolving decisions over time.
```

You can either embed all this content into `.github/copilot-instructions.md` or split them into files under a folder like `/memory-bank/`, then reference that folder in the Copilot instruction file.

- **Keep it in Markdown:** Both Copilot and Cursor expect markdown format. This ensures the content is readable by both humans and models.

- **Keep it short, structured, and current:** While Copilot can read up to 128K tokens (depending on the model might go up to 1mi tokens), it’s best to keep each file concise. Focus on high-value details the AI can use during code generation or review.

- **Update it regularly:** Whenever major changes are made — new architecture, refactors, or bugs fixed — update activeContext.md and progress.md. You can also prompt the AI with: `Summarize the last 3 pull requests and update activeContext.md`.

- **Optional: Use a Folder Instead of a Single File:** If your project is large or you want modular memory, you can place your Memory Bank files in a folder named /memory-bank/ and then copy summaries or key sections into .github/copilot-instructions.md. This lets humans and AIs reference the same content without overloading a single file.

## Example Instruction (for `.github/copilot-instructions.md`)

```txt
# Copilot Memory Bank

This project uses React + NestJS. All backend code should follow a hexagonal architecture. Frontend code should use TanStack Query and controlled inputs.

Use JWT for authentication and handle all errors using a standard ErrorHandler service.

Refer to the following memory files for deeper project understanding:

- `memory-bank/projectbrief.md`
- `memory-bank/systemPatterns.md`
- `memory-bank/techContext.md`
- `memory-bank/activeContext.md`
```

## References
- [How to Use a Memory Bank in Copilot](https://www.loom.com/share/152cea77575148b8af9fe8538ed30c30?sid=e3dd85c5-60e4-4d54-973c-4d4a3ff89917)
- [10x your Cursor Workflow with Memory Bank](https://www.youtube.com/watch?si=EiHdLnUQMBanl_eO&v=Uufa6flWid4&feature=youtu.be&themeRefresh=1)