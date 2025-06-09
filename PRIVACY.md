# Privacy Considerations for Agentic Coding

As we adopt AI coding agents in our daily workflow, it's critical that we stay vigilant about data privacy and security. Tools like Cursor, GitHub Copilot Agent, Claude, and others introduce new capabilities — but also new risks if misused.

This page outlines the non-negotiable privacy boundaries, best practices, and tooling recommendations that all developers must follow while using agentic coding techniques.

## What You Must Never Do

### ❌ Do not prompt with real user data

Never paste or reference real user emails, names, phone numbers, IDs, or any personally identifiable information (PII) into prompts.

This includes debugging issues, writing test cases, or requesting data transformations.

### ❌ Do not attach files containing sensitive data

Avoid storing at the codebase (even if git ignored), uploading or referencing exports with live data — such as CSVs, PDF reports, or logs with user identifiers.

These files may be stored temporarily or indexed by your IDE or tool.

### ❌ Do not connect AI tools to production databases

Never connect a agent to a live production database using a Model Context Provider (MCP).

Example: Do not create an MCP integration that fetches data directly from a production live PostgreSQL or DynamoDB instance. It is fine to connect to test data stores.

### ❌ Do not use AI tools that train on your data by default

Avoid uploading the codebase to any AI coding tool that may use inputs to improve their models unless explicitly allowed by legal and security teams.

## What You Should Do Instead

### ✅ Use mock data in all prompts and test cases.

Create safe, fake data sets or anonymized examples when showing the AI how your system behaves.

### ✅ Stick to tools with enterprise-safe defaults.

Preferred tools at Modus Create:

- Cursor – does not train models on your prompts or code.

- GitHub Copilot Agent (enterprise) – keeps data within GitHub and respects repo privacy boundaries.

- Claude (via secure workspace API) – when used through approved infrastructure, Claude does not retain prompt history.

### ✅ Use memory files or documentation, not live data, for context.

Store reusable information in safe .md files like spec.md, activeContext.md, and .copilot-instructions.md.

These are indexed but controllable, and never contain user data.

### ✅ Mask real data when debugging or generating logs.

Use placeholders: "user_123", "test@example.com", "TXN_0001"

Prompt: “This log contains simulated user activity. Based on this structure, can you help identify potential auth failure scenarios?”

### ✅ Connect MCPs to test/dev environment data stores.

## Real Risks If Ignored

- Privacy violations under GDPR, CCPA, HIPAA, or internal customer contracts.
- Credential leaks when full environment configs are prompted without redaction.
- Reputational damage if client data is exposed through AI usage logs or vendor breaches.
- Audit failure due to use of unvetted tools or unapproved data exposure in prompt flows.

Treat every prompt like a commit: if it contains sensitive data, it's already too late: Stay intentional, stay secure — agentic coding is powerful, but privacy comes first.

## Keep Reading

[Contributing](./CONTRIBUTING.md)