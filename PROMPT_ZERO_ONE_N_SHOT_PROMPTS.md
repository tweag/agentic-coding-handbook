---
layout: default
title: Zero/One/N-Shot Prompts
parent: Prompt Engineering
nav_order: 4
---

# Zero-Shot, One-Shot, and Multi-Shot Prompts

Prompting is the language of AI. In agentic coding, how you structure your prompts determines not just the quality of the code — but whether the model understands your intent at all.

This page breaks down three foundational prompting methods — Zero-Shot, One-Shot, and Multi-Shot — and demonstrates how to apply them strategically, using real-world engineering use cases with practical, reusable prompt examples.

## N-Shot Prompting

### Zero-Shot Prompting

- Tell the AI what to do without giving examples.
- Best when the task is well-known or model has strong prior knowledge.
- Risk of hallucination increases when task is ambiguous or implementation-sensitive.

### One-Shot Prompting

- Tell the AI what to do and give one example of how to do it.
- Best when you want consistency with an established pattern or want to reuse a known implementation format.

### Multi-Shot Prompting

- Give the AI multiple examples before asking it to continue the pattern.
- Best for generating multiple similar outputs (e.g., test cases, validators, endpoints) with consistent structure or formatting.

## Common use cases

| **Prompt Type** | **Ideal Use Case**                                                                                                   |
| --------------- | -------------------------------------------------------------------------------------------------------------------- |
| Zero-Shot       | Quick code snippets, refactors, doc generation, error analysis                                                       |
| One-Shot        | Repeating logic (e.g., endpoint structure, naming conventions, form components)                                      |
| Multi-Shot      | Bulk generation of tests, translation of logic across modules, repo-wide consistency (e.g., DTOs, service contracts) |

## Examples

### Writing a New API Endpoint with Specific Project Conventions

**Goal**: Create a new POST /users/invite endpoint using the same pattern as other endpoints in the project.

Zero-Shot Prompt

```txt
Write a NestJS controller method to handle POST /users/invite. It should accept email and name, call UserInviteService.inviteUser(), and return a success response or validation error.
```

Risk: Output may drift from project-specific naming, decorators, or DTO structure.

One-Shot Prompt

```txt
Here’s how we write our endpoints:

@Post('/users/register')
registerUser(@Body() body: RegisterUserDto) {
  return this.service.register(body);
}

Now create an endpoint for POST /users/invite that follows the same pattern, usingInviteUserDto and inviteUser().
```

Benefit: Ensures consistency in decorators, naming, and structure.

Multi-Shot Prompt

```txt
Here's how we write our endpoints:

@Post('/users/register')
registerUser(@Body() body: RegisterUserDto) {
  return this.service.register(body);
}

@Post('/users/reset-password')
resetPassword(@Body() body: ResetPasswordDto) {
  return this.service.resetPassword(body);
}

Now write a controller method for POST /users/invite.
```

Benefit: Enables the AI to model based on pattern, not just one instance. Useful for generating a series of aligned endpoints.
