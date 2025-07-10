---
layout: default
title: Debugging MCPs
parent: Tools & Setup
nav_order: 3
---

# Debugging with an MCP

There are several Model Context Protocol (MCP) solutions for extracting runtime browser data for debugging and context-aware AI assistance. We evaluated a few current options and compared their abilities to capture console errors, network activity, and application state while ensuring security and privacy compliance. What follows is the preferred option, based on those evaluations.

## Puppeteer MCP

Comprehensive browser runtime data access

- More consistent JavaScript execution for complex scenarios
- Smaller dependency footprint
- Simpler API pattern
- Uses official reference implementation from the @modelcontextprotocol/servers repository

## Setup

Docs: [puppeteer mcp](https://github.com/modelcontextprotocol/servers/tree/main/src/puppeteer)

Installation: `npm install --save-dev @modelcontextprotocol/server-puppeteer`

This package comes from the official Model Context Protocol reference implementation

Configuration in `.vscode/mcp.json`:

```json
"puppeteer_mcp": {
  "command": "npx",
  "args": [
    "@modelcontextprotocol/server-puppeteer"
  ]
}
```

## Limitation and Challenge: Connecting to Existing Browser Sessions

A significant limitation is the inability to easily connect to an already running browser instance where an error occurred. Instead the AI assistant uses the MCP to navigate to the running app based on the running app’s URL, which either reloads the browser window/tab or opens a new browser session.

This presents several challenges for real-world debugging:

- **Error Reproduction:** Developers must reproduce the error in a new browser session controlled by the MCP tool, which may be difficult for intermittent issues or those dependent on specific user actions or state.

- **Context Loss:** When an error occurs in a user's browser, valuable context (console history, network requests, application state) is lost if it cannot be extracted directly from that session.

- **Developer Experience:** The workflow becomes cumbersome as developers need to provide detailed instructions for reproducing the error in a separate MCP-controlled browser instance.
