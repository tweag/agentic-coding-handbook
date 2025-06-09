## 📘 Overview

This file explains how to use the AI [implementation planning prompt](./PROMPT.md) located in the same directory.  
The prompt is designed to guide an advanced AI coding agent to generate a step-by-step technical plan for delivering a feature or fixing a ticket — **without writing code yet**.

---

## 🧠 What This Prompt Does

It instructs the AI to:

- Ask for context about the feature/ticket
- Collaborate using simulated domain experts (e.g., frontend, UX, architect)
- Analyze the project’s codebase and propose changes
- Collaborate with the human through Q&A and iteration
- Generate a detailed implementation plan in a file named:  
  **`plans/PLAN_<ISSUE_CODE>.md`**

---

## 🧑‍💻 How to Use It

### ✅ 1. Provide Context

Start by giving the AI the issue context. This can be:

- Run this from the coding agent with the **indexed codebase**;
- A **Jira ticket code**
- A **user story** or **acceptance criteria**
- **Figma mocks**, **screenshots**, **diagrams**, or **requirements documents**
- External sources of information that can be accessed by the existing MCPs. Examples are: Confluence, Jira, Figma, Database, Github, Web Search.

💡 If you're using a coding agent, simply paste the info or drag in files. The AI will take it from there.

---

### 🗣️ 2. Let the AI Ask Questions

The AI will:

- Simulate a chain-of-thought discussion between domain experts
- Ask clarifying questions (in batches)
- Suggest external data it might need via MCPs

Answer these questions in full so it can proceed with high accuracy.

---

### 🔍 3. Review Proposed Codebase Changes

The AI will summarize:

- **Files to be changed or created**
- **What will be done**
- **Why each change matters**
- **Any assumptions made**

At this stage: **no code is written**. You're expected to review and provide feedback.

---

### ✍️ 4. Collaborate on Iteration

You can:

- Ask the AI to rephrase or simplify any change
- Ask for alternative implementations
- Add constraints (e.g., limit new files, avoid new deps)

Once you're aligned on the changes, give the AI the green light to generate the plan file.

---

### 📝 5. Receive the Plan File

The AI will generate:  
**`plans/PLAN_<ISSUE_CODE>.md`**

This file contains:

- Implementation phases
- Actionable steps per file
- Design rationales
- Edge case notes
- Checklists and commit summaries

You can now hand this to another AI agent (or dev) to implement.

---

## 🛑 What Not To Do

- **Don't ask the AI to implement code** during planning  
  It will refuse until the plan is finalized.

- **Don't skip the Q&A loop** — context matters.

- **Don't change the output file path/name convention** unless you've updated the prompt.

---

## 📎 Additional Notes

- The AI will mock external APIs only if necessary — and it will clearly label them.
- The AI follows the project’s commit message style and Git policies.
- You can version the plan file as needed (e.g., `PLAN_ADE-101_v2.md` for iterations).

---

## 📣 Questions?

If anything is unclear, just type your question into the coding agent while using the prompt. The AI will either answer or escalate for clarification.

