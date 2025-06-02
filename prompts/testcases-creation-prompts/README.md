# Testcase Coverage & Edge Cases Prompt - Usage Guide

This guide explains how to use the provided QA prompt to maximize your project's test coverage, especially for negative and edge scenarios.

---

## How to Use the Prompt

1. **Copy the Prompt:**  
   Copy the prompt from `PROMPT.md` and provide it to your QA team or AI tool, along with your project context.

2. **Generate Testcases:**  
   The QA or AI will generate a comprehensive set of testcases, covering unhappy paths, edge cases, invalid input, timeouts, unauthorized access, and non-ideal user behaviors.  
   All testcases will be organized by category and written in the format:
   - Verify that user can't sign up without filling the mandatory fields
   - Verify the behaviour when user who already had an account trying to register again

3. **Review Techniques:**  
   The prompt instructs to apply three expert QA techniques (such as Boundary Value Analysis, Error Guessing, and Exploratory Testing) and to review the testcases twice, ensuring completeness and quality.

4. **Check Output:**  
   All generated testcases will be saved in a separate file named `testcases_checklist.md` for easy review and tracking.

---

## Best Practices

- **Provide Project Context:**  
  The more details you provide about your project, the more relevant and thorough the testcases will be.

- **Iterative Review:**  
  Use the expert review techniques as described in the prompt to iteratively improve the testcases.

- **Collaborate:**  
  Share the `testcases_checklist.md` file with your team for further feedback and continuous improvement.

- **Keep Updated:**  
  Update the checklist as your project evolves or new features are added.

---

## Benefits

- **Improved Coverage:**  
  Ensures all negative, edge, and non-ideal scenarios are tested.
- **Reduced Risk:**  
  Helps catch bugs that might otherwise go unnoticed.
- **Clear Documentation:**  
  Keeps your testcases organized and easy to maintain.

---

By following this guide and using the prompt, you can significantly improve the reliability and robustness of your project through better test coverage.