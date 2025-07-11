---
layout: default
title: Organization Guidelines
parent: Tools & Setup
nav_order: 5
---

# Organization Level Instructions

GitHub Copilot now supports organization-level instructions, allowing administrators to define guidance that applies to all repositories and all users within a GitHub organization. This is a powerful tool to promote consistency, security, and governance across all AI-assisted development workflows.

This page explains how org-level instructions differ from project-level .copilot-instructions.md files and how to use each effectively.

## What Are Organization-Level Instructions?

Organization-level instructions are set in GitHub settings (via the Copilot tab) and are automatically injected into every Copilot Chat interaction for members of the organization — regardless of which repository they are working in.

This creates a baseline AI behavior model for all teams under the org umbrella.

## How It Differs from Project-Level Instructions

| **Feature**    | **Organization-Level**                | **Project-Level**                                             |
| -------------- | ------------------------------------- | ------------------------------------------------------------- |
| Scope          | All users & repos in the org          | Only applies to a specific repo                               |
| Who manages it | Org admins                            | Repo maintainers or developers                                |
| When it loads  | Always in context                     | Only when working in that repo                                |
| Purpose        | Company-wide guidance, policies, tone | Repo-specific architecture, stack, naming, etc.               |
| Format         | Text box in GitHub settings           | Markdown file in repo root: `.github/copilot-instructions.md` |

These two types of instructions are complementary: org-level defines global rules, project-level adds local specificity.

## Use Cases for Organization-Level Instructions

- **Security and Privacy Rules**

```txt
Never suggest using secrets or API keys directly in code.
Avoid using eval() or direct SQL string construction.
```

- **Documentation and Learning Resources**

```txt
When asked about frontend theming, refer to the Confluence Docs at <name>.
Link to internal API documentation for auth-related questions.
```

- **Consistency Across Teams**

```txt
Use PascalCase for class names and camelCase for functions.
Always wrap DB calls with the internal SafeQuery abstraction.
```

- **Style and Formatting Rules**

```txt
All logs must use LoggerService.debug() — never console.log().
Use ?? over || for nullish checks.
```

- **Process Guidelines**

```txt
For any deployment questions, remind the user to check the InfraRunbook first.
When unsure about security decisions, suggest reaching out in #ask-security.
```

## Best Practices for Writing Org-Level Instructions

- **Be clear and prescriptive:** Write them like onboarding rules — not suggestions.
- **Avoid repo-specific logic:** Don’t reference repo file paths or local variables.
- **Use structured categories:** Break into sections like "Security", "Logging", "Naming", etc.
- **Keep it short:** Aim for < 1,000 words to avoid hitting context compression limits.
- **Update periodically:** Sync changes with team-wide rollouts, language style updates, or new security policies.

## When to Use Project vs Org Instructions

| **Scenario**                                | **Use This**       |
| ------------------------------------------- | ------------------ |
| Defining architecture rules for a monorepo  | Project-level      |
| Standardizing logging across all projects   | Organization-level |
| Enforcing naming conventions per team       | Project-level      |
| Controlling AI suggestions for secret usage | Organization-level |
| Teaching a repo-specific design pattern     | Project-level      |

## How to Configure

- Go to your GitHub organization settings.
- Navigate to the Copilot tab.
- Click Custom Instructions.
- Enter your organization-wide instructions in the editor box.
- Save — they’re now live for all Copilot Chat interactions in the org.

Organization instructions are your first layer of LLM governance. They establish shared values and behaviors that AI should reflect — turning Copilot into an extension of your engineering culture.

## References

- [Organization custom instructions now available](https://github.blog/changelog/2025-04-17-organization-custom-instructions-now-available/)

## Keep Reading

[Project Level Instructions](./PRJ_INSTRUCTIONS.md)
