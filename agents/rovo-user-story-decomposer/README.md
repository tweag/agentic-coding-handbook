# 🧠 AI Planning Agents

Breaks a Jira user story (with Gherkin-style acceptance criteria) into small, scoped tasks for delivery. Each task includes:
- Title, Goal, Scope, Dependencies
- Clear validation steps
- Logical execution order
- Parallelization guidance

Output is cleanly structured for use in Jira comments.

See [`PROMPT.md`](./PROMPT.md) for full prompt details.

---

## 📎 How to Use

1. Copy the appropriate `PROMPT.md` into your agent config (ROVO).
2. Provide the user story or ticket input as described.
3. Review the agent’s output for clarity and alignment.
4. Edit if needed, then post to Jira or proceed to implementation.