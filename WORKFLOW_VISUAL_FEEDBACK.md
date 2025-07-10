---
layout: default
title: Visual Feedback Loop
parent: Core Workflows
nav_order: 4
---

# Visual Feedback Workflow with AI Agents

When working on frontends, code alone doesn’t always tell the full story. What users see — and how the UI behaves across screen sizes, states, and interactions — is critical to quality. This workflow introduces how to use screenshots and browser context as inputs for AI-assisted iteration.

By pairing screenshots with prompts and augmenting context via browser-based MCPs, developers can give AI direct visibility into what’s wrong — and receive precise, design-aligned suggestions for improvement.

## When to Use This Workflow

- After generating a UI screen with AI and you want to validate spacing, layout, or responsiveness
- When reviewing visual bugs reported by QA or designers
- When refactoring visual components or improving cross-browser compatibility

## Capture a Screenshot for Feedback

Use your browser’s built-in tools or a screenshot extension to capture:

- A full-page screenshot
- A clipped component or layout section
- A specific device viewport (e.g. mobile)

Save the image and drop it directly into Cursor (or Claude if supported), then use a prompt like:

```txt
Here’s what the UI looks like. The layout doesn’t match the Figma design — spacing is off and the sidebar is misaligned. What improvements can we make to align with a clean, balanced layout?
```

## Tips

- Point out specific problems (“font size too large on buttons”, “image is overflowing container”)
- Use annotations if supported by the tool (e.g., cursor artifacts or Claude screenshots)

## Add Browser Context with MCPs

For deeper debugging or responsive fixes, feed AI more signals using browser-based Modular Context Providers (MCPs):

Available Browser Contexts via MCPs:

- Console Logs Prompt: `Use browser MCP to fetch latest errors and logs. What do these console warnings mean?`
- DOM Structure Prompt: `Fetch current DOM and analyze why #sidebar has overlapping margin.`
- Network Activity Prompt: `Analyze failed network calls on page load using captured logs. Suggest fixes.`

Use a browser MCP (e.g., Chrome DevTools MCP) to automatically extract these values into context for the AI to reason about layout bugs, render issues, or API failures.

## Iterate and Apply Fixes

After analyzing the feedback, prompt the AI to generate safe changes step-by-step:

```txt
Based on the feedback, update the CSS for the header to improve vertical alignment and add spacing between nav items.
```

### Use AI to:

- Refactor layout
- Suggest style tokens from your design system
- Detect visual regressions between versions
- Repeat by capturing new screenshots after each iteration to validate progress.

### Benefits of the Visual Feedback Workflow

- Makes invisible problems visible — especially spacing, color, font, and layout inconsistencies
- Accelerates alignment with design intent (e.g., Figma specs)
- Helps non-technical stakeholders (QA, design) participate in reviews using screenshots
- Combines what the user sees with what the code is doing under the hood

## Example Prompts

```txt
Here’s a screenshot of the user profile screen. Improve the layout to match a clean card-based structure with better spacing.
```

```txt
Use the DOM structure to suggest accessibility fixes based on ARIA roles and contrast.
```

```txt
Given the failed API call shown in network logs, what’s likely missing in the fetch logic?
```

## References

- [Using Copilot with Visual Feedback](https://www.loom.com/share/a811bd60a39e4bd38073637e24101af8?sid=f3e88fab-2768-44bb-8b66-970229dbaee6)

## Keep Reading

[Debugging Workflow](./WORKFLOW_DEBUG.md)
