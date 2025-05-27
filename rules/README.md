# 📜 Cursor Rules Directory

This directory contains **Cursor Rules** files that define the guidelines, standards, and project-specific contexts for AI interactions within this repository. These rules help ensure that AI-generated code adheres to our project’s standards and best practices.

## ⚠️ Important Warning

The files in this repository are stored in .md format for ease of collaboration and version control. However, Cursor requires these files to be in .mdc format to function properly. Please change the extension to `mdc` when configuring it on your project.

## 🧠 **What Are Cursor Rules?**

Cursor Rules are configuration files that guide the AI in understanding how to interact with our codebase. They provide:

- **Project Context:** High-level information about the project’s purpose, architecture, and goals.
- **Coding Standards:** Rules for code quality, formatting, and structure.
- **Behavioral Guidelines:** Instructions on how the AI should reason, suggest changes, or collaborate with developers.
- **File-Specific Rules:** Tailored instructions for specific file types or directories.

For more details, refer to the [official Cursor documentation](https://docs.cursor.com/context/rules-for-ai).

## 🛠️ **How to Use Cursor Rules**

### 1. **Automatic Application**

The AI automatically applies these rules when interacting with files in the repository. Rules are matched based on:

- **Glob Patterns:** Each `.mdc` file specifies which files or directories it applies to using glob patterns (e.g., `src/**/*.ts`).
- **Descriptions:** The AI evaluates whether a rule is relevant based on its description and context.

### 2. **General Rules**

A general-purpose rules file (e.g., `general.mdc`) applies broadly across the project. It provides overarching standards like coding principles, security practices, and architectural decisions.

### 3. **Specific Rules**

Rules targeting specific file types or directories (e.g., `frontend.mdc`, `backend.mdc`) define detailed instructions for those areas of the codebase.

💡 **Tip:** The AI prioritizes specific rules over general ones when they overlap.

## ✅ **What’s Expected When Using Cursor Rules**

When working with Cursor Rules, you can expect:

1. **Consistency Across Codebase:**
    - The AI will generate code that follows our coding standards and architectural guidelines.
    - It will respect project-specific conventions like naming patterns or directory structures.
2. **Context-Aware Suggestions:**
    - The AI will use the information in these rules to understand project-specific goals and constraints.
    - It will avoid making generic suggestions that don’t align with our practices.
3. **Improved Collaboration:**
    - Developers and AI agents work together more effectively by adhering to shared rules.
    - The rules facilitate better onboarding for new developers by embedding knowledge directly into the workflow.

## 🔄 **How to Keep Rules Updated**

To ensure the rules remain effective and relevant, follow these best practices:

### 1. **Review Regularly**

- Revisit rules periodically (e.g., during sprint retrospectives) to ensure they reflect current project needs.
- Remove outdated rules or update descriptions as the project evolves.

### 2. **Add New Rules When Needed**

- Introduce new `.mdc` files for emerging requirements (e.g., new technologies or frameworks).
- Use clear descriptions and glob patterns to target specific areas of the codebase.

### 3. **Collaborate on Updates**

- Discuss rule changes with your team during code reviews or planning sessions.
- Ensure all developers understand new guidelines before enforcing them.

### 4. **Test Rule Effectiveness**

- Observe how well the AI adheres to the rules during interactions.
- Adjust overly strict or ambiguous rules that hinder productivity.

## 📝 **Directory Structure**

Here’s an example of how this directory might be organized:

```
cursor-rules/
├── general.mdc           # General-purpose rules for all files
├── frontend.mdc          # Rules specific to frontend code (React)
├── backend.mdc           # Rules specific to backend code (Node.js)
├── security.mdc          # Security-related guidelines
└── README.md             # This file
```

Each `.mdc` file contains:

- A `Description` explaining its purpose.
- `Globs` specifying which files it applies to.
- Contextual guidance for the AI.

## ⚙️ **Best Practices for Writing Rules**

1. **Be Specific but Flexible:**
    - Write clear instructions without being overly prescriptive.
    - Allow room for creativity where appropriate.
2. **Avoid Overloading Context:**
    - Keep each `.mdc` file focused on a specific area or topic.
    - Avoid duplicating information across multiple files.
3. **Use Actionable Language:**
    - Use terms like “MUST,” “SHOULD,” and “SHOULD NEVER” to clarify expectations.
    - Provide examples when necessary (but keep them concise).
4. **Test New Rules:**
    - After adding or updating a rule, test its impact by interacting with the AI in relevant scenarios.

## 📎 Additional Notes

- Cursor Rules are not static — they evolve as the project grows and changes.
- If you’re unsure about how a rule works or whether it applies, consult this README or ask your team lead.
- For advanced usage tips, check out [Cursor’s official documentation](https://docs.cursor.com/context/rules-for-ai).

## 📣 Questions?

If you have questions about writing or updating Cursor Rules, reach out to your team lead or consult the official documentation linked above.