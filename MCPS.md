---
layout: default
title: Model Context Providers (MCPs)
parent: Tools & Setup
nav_order: 2
---

# MCP Use Cases

Model Context Providers (MCPs) extend the AI agent’s capabilities by automatically injecting context from external sources into your prompts. Instead of manually copying and pasting information, MCPs allow the AI to access critical data like Jira tickets, Confluence docs, Figma designs, and GitHub discussions in real time. This improves the accuracy, speed, and quality of AI-generated code and responses.

During our internal experiment, we validated several valuable MCP use cases that had a direct impact on productivity and output quality:

- Fetching feature request details directly from Jira tickets to understand acceptance criteria, edge cases, and business rules.
- Fetching architecture definitions, internal standards, reusable patterns, and product strategy notes from Confluence pages to guide implementations.
- Fetching UI mockups from Figma to generate frontend components aligned with the latest designs.
- Fetching GitHub pull request comments to incorporate peer feedback into the AI-driven coding flow.
- Fetching external API documentation to integrate third-party services faster and with fewer mistakes.
- Fetching live browser data like console errors to debug issues contextually during development.

By using MCPs, developers spend less time tab-switching between tools and more time staying focused on building and improving software.

## Available MCPs for Our Workflows

- Atlassian MCP for Jira and Confluence: [Atlassian Remote MCP](https://www.atlassian.com/platform/remote-mcp-server)

- GitHub MCP for Pull Requests and Comments: [GitHub - github/github-mcp-server: GitHub's official MCP Server](https://github.com/github/github-mcp-server)

- [Figma MCP Plugin (Talk to Figma)](https://www.figma.com/community/plugin/1485687494525374295/cursor-talk-to-figma-mcp-plugin)

MCPs are a core enabler for efficient agentic coding at scale, helping the AI work with richer, more reliable information without needing constant manual intervention.

## Safety & Security Guidelines for Using MCPs

When integrating Model Context Providers (MCPs) into your agentic-coding workflow, security must be front-of-mind. Follow these guardrails to protect your codebase, data, and credentials:

| **Best-Practice**                                                  | **Why it matters**                                                                 | **What to do**                                                                                                                                                             |
| ------------------------------------------------------------------ | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Prefer official MCPs                                               | Vendors maintain their own MCPs, patching bugs and security issues promptly.       | Use the MCP published by the API provider (e.g., GitHub, Atlassian, Figma). Avoid community forks unless absolutely necessary.                                             |
| Keep secrets out of MCPs                                           | Hard-coded credentials are a breach waiting to happen.                             | Store API keys or tokens in your secret-management layer (e.g., HashiCorp Vault, AWS Secrets Manager) and pass them via environment variables or a secrets-injection step. |
| Apply least-privilege keys                                         | Broad tokens increase blast radius if leaked.                                      | Generate scoped API keys that allow only the minimal actions the MCP needs (read-only if possible). Rotate them on a schedule.                                             |
| Use a trusted middleware when no official MCP exists               | Third-party automation hubs already isolate and encrypt credentials.               | Configure the middleware’s official connector and let it proxy requests, keeping your secrets out of an open-source repo.                                                  |
| Audit any unofficial open-source MCP                               | Community packages can contain malicious code, outdated deps, or hidden telemetry. | Fork the repo, review every line, run static analysis (e.g., Semgrep), and pin dependency versions before deploying.                                                       |
| Never trust closed-source, unofficial MCPs that demand credentials | You cannot inspect what you cannot see.                                            | If the provider won’t open the code, treat it as an immediate deal-breaker—no exceptions.                                                                                  |

In the next sections, we will explain how to configure and use each MCP step-by-step inside your coding workflows.

## References

- [Figma and Atlassian MCPs for Cursor](https://www.loom.com/share/2c651abeb3394c38a218f2860084da0d)
- [Introducing the GitHub MCP Server: AI interaction protocol | GitHub Checkout](https://www.youtube.com/watch?v=d3QpQO6Paeg)
- [The Only 3 Videos You Need to Get Started with MCP](https://www.youtube.com/watch?v=YRfOiB0Im64)

## Keep Reading

[Org Level Instructions](./ORG_INSTRUCTIONS.md)
