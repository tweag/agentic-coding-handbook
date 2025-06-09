# Managing the Agent Context

Managing the agent context, especially by breaking features into smaller parts, is critical because of how LLMs work. Large Language Models can only “think” about a finite amount of information at once. When overloaded with too many files, specs, or vague requests, they lose track of important details — a common limitation known as the “lost in the middle” problem.

When you ask an LLM to build too much at once, it often misses dependencies, confuses structures, or generates inconsistent code. This increases bugs and rework. By breaking features into smaller, well-defined tasks, you give the LLM clear goals, reduce hallucinations, and create checkpoints for human validation — improving speed and quality.

A critical part of working with coding agents is feeding the right information, at the right time, in the right size. The engineer must fetch relevant files, surface meaningful snippets, and guide the model. The AI will only be as useful as the context you provide.

## Here are the main ways to provide effective context inside Visual Studio Code using GitHub Copilot Agent:

- **Feeding a well-described, action-oriented implementation plan:** Providing a clear step-by-step plan (like a specification or prompt plan) helps the AI understand the scope of the work and reason through implementation phases safely, one step at a time. This structured planning dramatically improves AI performance and reduces errors. (Source: [The Vibe Coding Workflow](https://www.linkedin.com/pulse/vibe-coding-workflow-michael-papadopoulos-n3wpf/))

- **Writing well-crafted prompts:** Prompts should be clear, specific, and focused. A good prompt clearly defines the task, expected input/output, and any constraints (like preferred frameworks or libraries). The quality of the prompt directly impacts the quality of the AI’s response. (Source: [Prompt engineering for Copilot Chat](https://code.visualstudio.com/docs/copilot/chat/prompt-crafting))

- **Using GitHub Copilot tools to provide additional context:** You can enrich your Copilot prompts by attaching files, folders, codebase search results, terminal outputs, problem reports, and even fetching public web content, ensuring the AI has all necessary information to generate better answers. (Source: [Copilot Chat Context](https://code.visualstudio.com/docs/copilot/chat/copilot-chat-context))

- **Integrating Modular Context Providers (MCPs):** MCPs allow Copilot to connect to external data sources and services dynamically during a session, extending the AI’s capabilities beyond just static files, enabling access to APIs, Figma, Jira, Github, and other live external systems. (Source: [Use MCP servers in VS Code](https://code.visualstudio.com/docs/copilot/chat/mcp-servers))

- **Adding visual attachments like mockup images:** Providing UI mockups, screenshots, or design references helps AI better understand the visual structure and user experience expected in frontend or product-related development tasks.

- **Defining project-level instructions for Copilot:** You can create instructions files to set custom project coding guidelines, preferred patterns, naming conventions, and rules. This ensures that Copilot follows consistent practices automatically across the project. (Source: [Customize Copilot Chat Responses](https://code.visualstudio.com/docs/copilot/copilot-customization))

- **Making sure your codebase is indexed:** When using GitHub Copilot’s code search and context features, ensuring your workspace is properly indexed allows Copilot to find relevant files more accurately and respond with better context-aware answers. (Source: [Copilot Tips and Tricks - Workspace Indexing](https://code.visualstudio.com/docs/copilot/copilot-tips-and-tricks#_workspace-indexing))

- **Use conversational memory strategically:** LLMs remember the flow of your session. Build on past exchanges instead of repeating everything from scratch. If a thread is working, continue it. If not, reset and start over to regain clarity.

- **Let the AI build small before scaling up:** Ask for simpler versions first. Let the model succeed in a small task, then build up complexity gradually. It improves performance and reduces overwhelm.

- **Reuse real code examples:** LLMs reason better from working examples than theory. Paste in past completions, existing code, or samples from similar features to anchor your prompt in reality.

- **Prefer tools that expose context:** Choose coding tools (like Cursor or Claude) that let you see the context window, not hide it. Visibility helps you debug, learn, and iterate faster.

- **Creating and Maintaing Project Documents:** The team can maintain as part of the codebase (such as instructions) or in external systems acessbible by MCPs (such as Confluence) documents that can feed the context with core information on the project. One example is a [UI/UX guidelines](./documents/UI_UX_GUIDELINES.md) that aim to define patterns AI must follow to build user interfaces. Other examples can be a solution design handover document crafted by Modus Solution Design team, or a software architecture documentation.

## References

- [Introduction to the LLM Context Handling Problem](https://www.loom.com/share/29cc930d60c0438eb9174ae90a568051)

## Keep Reading

[Basics of Prompt Engineering](./PROMPT_ENGINEERING.md)