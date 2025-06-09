# Frontend Debugging Prompt

This prompt is designed to help engineers systematically debug frontend issues by analyzing possible causes, identifying the most likely ones, and validating assumptions before implementing fixes.

## Purpose

When faced with frontend bugs, errors in the console, or unexpected application behavior, this prompt helps structure the debugging process to efficiently identify and resolve the root cause.

## How to Use This Prompt

1. Copy the content from [PROMPT.md](./PROMPT.md)
2. Fill in the template with specific details about your issue
3. Submit the completed prompt to an AI assistant

## Template Sections

### Problem Analysis
Describe the issue you're experiencing in detail:
- The specific error or unexpected behavior
- Environment details
- Relevant code snippets
- Recent changes that might be related

### Analysis Request
Ask the AI to:
- Consider multiple possible causes
- Narrow down to the most likely ones
- Suggest debugging techniques
- Provide a systematic approach to fixing the issue

## Specialized Debugging Scenarios

For more specific frontend debugging scenarios, consider using these tailored approaches:

### Visual/UI Issues
Focus on:
- Screenshots of expected vs. actual appearance
- CSS/component code
- Layout and styling inconsistencies

### Performance Issues
Include:
- Load time measurements
- Memory usage data
- Component hierarchy
- Rendering patterns

### State Management Issues
Provide:
- State flow diagrams
- Component relationships
- Data mutation points
- State management libraries used

### Browser Compatibility Issues
Specify:
- Affected browsers and versions
- Behavior differences
- Polyfills and compatibility libraries

## Integration with Model Context Protocol (MCP) Tools

When using Model Context Protocol (MCP) tools for advanced debugging:
1. Set up the appropriate MCP tool for your browser
2. Collect console logs, network requests, and rendering information
3. Include this data in your prompt for more accurate analysis

## Example

```
Issue: Login form submission not working
Error Message: "Uncaught TypeError: Cannot read property 'value' of undefined"
Expected Behavior: Form submits and user is authenticated
Actual Behavior: Nothing happens on submit, error appears in console

Environment:
- Browser: Chrome 118.0
- OS: macOS 12.6
- Framework/Library: React 18.2, Formik 2.4

Code Context:
const handleSubmit = (e) => {
  e.preventDefault();
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;
  authService.login(username, password);
}

Recent Changes: Refactored form to use Formik instead of native form elements
Troubleshooting Steps Tried: Verified form element IDs, checked authService methods
```