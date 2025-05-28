# Basics of Prompt Engineering

Prompt engineering is the practice of writing clear, structured instructions to guide AI coding agents like GitHub Copilot Agent or Cursor. Just like you'd explain a task to a junior developer, your job is to describe what you want, where to do it, and how to do it — in a way the AI can understand and act on.

During our internal experiment, we learned that prompt quality was one of the most critical success factors. Good prompts led to clean, scalable code. Vague or overly broad prompts caused hallucinations, bugs, and wasted time

## Why It Matters

A prompt is the main way you feed task-level context to the AI. Since the model can't guess what you're thinking, it relies entirely on what you say — and how you say it.

Well-crafted prompts:

- Improve accuracy and consistency
- Reduce hallucinations
- Make AI-generated code easier to validate and maintain
- Save time during reviews and rework

## Core Tips on prompting

- Start prompts with a clear action, expected output, and any important constraints.
- When possible specify the exact file, service, or component where the change should happen.
- Break large features into small, independent prompts whenever possible.
- Use "step-by-step" or "think like an expert" instructions to guide deeper reasoning.
- Attach code snippets, file names, terminal outputs, or #codebase context whenever possible.
- Treat each prompt like a task you would hand off to a junior developer: detailed but focused with clear expectations of the outcome.
- If the AI gives a bad output, refine the original prompt instead of fixing the wrong output manually.
- Validate every result manually — never trust AI output without review and testing.
- Prefer describing the "why" behind a feature when possible — it improves AI’s architectural decisions.
- Remember that vague prompts waste more time than spending a few extra seconds writing a better one.

## Prompting Fundamentals (With Practical Guidance)

Make sure to read the below pages before moving forward:

- [VSCode's Prompt engineering for Copilot Chat](https://code.visualstudio.com/docs/copilot/chat/prompt-crafting)
- [Github's Prompt engineering for Copilot Chat](https://docs.github.com/en/copilot/using-github-copilot/copilot-chat/prompt-engineering-for-copilot-chat)
- [Anthropic's Prompt Library](https://docs.anthropic.com/en/resources/prompt-library/library)
- [Craft Perfect AI Prompts](https://shumerprompt.com/)

## Examples

### Be clear and specific

Do:

```txt
Create a POST /users/login endpoint using NestJS. It should accept email and password, validate input, and return a JWT if credentials are correct. Use class-validator and JWT module.
```

Don’t:

```txt
Add login functionality.
```

### Define scope: one task at a time

Do:

```txt
Add email format validation to the user registration form in RegisterForm.tsx.
```

Don't (This is too broad — likely to produce incomplete or scattered results):

```txt
Finish all validations for the signup flow.
```

### Add context: Include file names, project structure, and relevant implementation details.

Do:

```txt
In auth.controller.ts, add a new endpoint that consumes authService.validateUser() and returns a JWT if valid.
Also, attach files or use the #codebase tag to help Copilot Agent or Cursor read project content.
```

### Describe expected behavior and constraints

Do:

```txt
Add unit tests for parseMedicalReport() in report.utils.ts. Cover edge cases like empty file, invalid format, and corrupted content.
```

Don't:

```txt
Write tests for report parser.
```

### Use a reasoning-first prompt format

#### Three Experts Method

```txt
Simulate three different experts answering the below questions. All experts will write down 1 step of their thinking and then share it with the group. Then all the experts will go on the next step, etc. If any expert realizes they are wrong at any point, then they leave. Stop once you have the final answer for each question.
```

#### Self-Refinement Loop

```txt
Try solving this <add context from IDE>. Then improve your answer in 3 iterations by critiquing and rewriting each version.
These methods improve architectural decisions and reduce low-quality responses.
```

#### Iterate and refine

It's normal to go through multiple prompt rounds. Use a feedback loop:

```txt
Prompt → Validate → Adjust prompt or fix code → Continue
```

> Never assume the first output is ready to merge.

## Common Pitfalls to Avoid

Too vague: Add error handling — What error? Where?

Too large: Build user profile page, backend API, tests, and styling — Break into smaller parts.

Assuming the AI knows your intent — it doesn’t. Be explicit.

Skipping validation — always review, test, and verify AI output.

## Interesting Open Source Prompts

https://shumerprompt.com/prompts/expert-conductor-reasoning-guide-prompt-2ff044e1-5e65-48b3-8004-5f51e10e4a94

https://shumerprompt.com/prompts/vibe-coding-documentation-prompt-de4b2917-b4e3-44bd-ba7c-90eb09b508cd 

https://shumerprompt.com/prompts/super-prompt-generator-optimizer-prompt-22b2a360-9935-49d6-81db-684385866847

https://shumerprompt.com/prompts/o3-maximum-reasoning-prompt-71b5828e-3c09-4df3-a9b7-25ef399e8977

## References

- [Master the core principles of prompt engineering with GitHub Copilot](https://www.youtube.com/watch?v=hh1nOX14TyY)
- [Prompt engineering essentials: Getting better results from LLMs | Tutorial](https://www.youtube.com/watch?v=LAF-lACf2QY)
- [AI prompt engineering: A deep dive](https://www.youtube.com/watch?v=T9aRN5JkmL8)
- [Essential AI prompts for developers](https://www.youtube.com/watch?v=H3M95i4iS5c)

## Go Deeper

- [Three Experts Method](./prompting/THREE_EXPERTS_METHOD.md)
- [Zero-Shot, One-Shot, and Multi-Shot Prompts](./prompting/ZERO_ONE_N_SHOT_PROMPTS.md)

## Keep Reading

[Workflows](./WORKFLOWS.md)