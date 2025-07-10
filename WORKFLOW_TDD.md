---
layout: default
title: Test-Driven Development
parent: Core Workflows
nav_order: 2
---

# Test Driven Development

Test-Driven Development (TDD) and Agentic Coding may seem like opposites — one is structured and disciplined, the other fluid and intuitive. But when paired, they create a powerful feedback loop: TDD gives structure to your flow, and Agentic coding gives speed to your structure.

This combination shines when you’re working with complex logic files, such as pricing engines, rules-based validators, or multi-condition workflows. Instead of prompting the AI to generate everything at once, you describe one behavior at a time through tests — and let the AI build up the logic incrementally, safely, and cleanly.

## Why TDD Makes Agentic Coding Better

- **Tests act as prompts:** In the AI-assisted workflow, a test becomes a natural language spec that guides the AI toward exactly the behavior you expect. Instead of saying "generate a function that filters valid emails," you say it('should return only valid emails from a mixed list') and the AI writes the code to pass that test.

- **You reduce hallucination:** The more precise the prompt (in this case, the test), the more accurate the generation.
  TDD keeps the LLM focused on small, testable goals instead of bloated implementations.

- **It builds confidence:** When every code generation step is validated by a test, you know it's working. This is crucial when you’re using AI as your pair.

- **It keeps you in flow:** Tests give you checkpoints. Instead of stopping to debug a vague output, you just write the next test and let the AI catch up.

- **It reinforces clean, behavioral thinking:** TDD forces you to describe what the code should do, not how to write it. That’s exactly how we should prompt LLMs.

## TDD Tips for Agentic Coders

- Start with high-value behavior first, not edge cases.
- Use descriptive test names — the clearer the test, the better the AI result.
- Keep test scopes tight: one behavior per prompt.
- Let the AI refactor — ask it to "clean up the logic but keep all tests green".
- Use pre-commit hooks to run tests and stop bad code from merging.

## Example of Prompt and its output

```txt
### Prompt: Generate TDD Plan from Business Logic

I’m implementing a new feature based on the following business rules from a Jira ticket.
Please help me break it down into a clear **Test-Driven Development flow**, where each step represents a test to be written and the logic to be implemented to pass it.
Output the result as a **markdown checklist** (`tdd-plan.md`) using `[ ]` for each step.
The structure should guide me to:

* Write one test at a time
* Implement just enough code to pass it
* Add more rules incrementally
* Include edge cases and input validation
* Refactor at the end if needed

Here are the business rules:

\`\`\`markdown
Feature: calculate_invoice_total(items, customer_location)

Business rules:

1. Each item has:
   - price (number)
   - quantity (integer)
   - taxable (boolean)

2. Tax rules:
   - For customers in NY: apply 8.875% tax on taxable items
   - For customers in CA: apply 7.25% tax on taxable items
   - For all other locations: apply 5% tax on taxable items
   - Non-taxable items do not receive any tax

3. Discounts:
   - If subtotal (before tax) is greater than $1,000, apply a 5% discount on the subtotal
   - If the total quantity of all items is 10 or more, subtract a $15 shipping discount from the total

4. Final total = subtotal - discounts + tax

5. Edge cases:
   - If item list is empty, return total = 0
   - If location is missing or unknown, default to 5% tax
   - Negative prices or quantities are invalid and should raise an error
\`\`\`

Format the result like this:

\`\`\`markdown
# TDD Plan: [Feature Name]

\[ ] Write test for \[simple behavior]
\[ ] Implement logic to pass test
\[ ] Write test for \[next rule]
\[ ] Update implementation to pass
\[ ] Add test for edge case \[X]
\[ ] Refactor logic for clarity
\`\`\`

You can group tests by theme if needed. Only include things that should be verified through tests.
Avoid assumptions — reason from the rules given.
Before starting creating the file, you can ask questions to the user to clarify your understanding.
Check the boxes above as you progress. This is important, DO NOT FORGET ABOUT THIS.
```

Output:

```txt
# TDD Plan: Calculate Invoice Total

## Setup

- [ ] Create the basic function structure `calculate_invoice_total(items, customer_location)`
- [ ] Set up testing framework

## Basic Functionality

- [ ] Write test for empty items list returning 0
- [ ] Implement logic to return 0 for empty items list
- [ ] Write test for calculating subtotal with a single non-taxable item
- [ ] Implement logic to calculate basic subtotal (price * quantity)
- [ ] Write test for calculating subtotal with multiple non-taxable items
- [ ] Update implementation to handle multiple items

## Tax Rules

- [ ] Write test for default tax rate (5%) with a taxable item
- [ ] Implement logic to apply default tax rate
- [ ] Write test for NY tax rate (8.875%) with taxable item
- [ ] Update implementation to handle NY tax rate
- [ ] Write test for CA tax rate (7.25%) with taxable item
- [ ] Update implementation to handle CA tax rate
- [ ] Write test for mixing taxable and non-taxable items
- [ ] Update implementation to only apply tax to taxable items

## Discount Rules

- [ ] Write test for 5% discount on subtotal > $1,000
- [ ] Implement logic for subtotal discount
- [ ] Write test for $15 shipping discount when total quantity ≥ 10
- [ ] Implement logic for shipping discount
- [ ] Write test for both discounts applying simultaneously
- [ ] Update implementation to handle both discount types

## Edge Cases and Validation

- [ ] Write test for missing location defaulting to 5% tax rate
- [ ] Update implementation to handle missing location
- [ ] Write test for unknown location defaulting to 5% tax rate
- [ ] Update implementation to handle unknown locations
- [ ] Write test for negative price validation
- [ ] Implement error handling for negative prices
- [ ] Write test for negative quantity validation
- [ ] Implement error handling for negative quantities

## Final Calculations

- [ ] Write test for final total calculation (subtotal - discounts + tax)
- [ ] Verify implementation correctly calculates final total
- [ ] Write test for complex scenario with all rules applied
- [ ] Ensure implementation handles all business rules correctly

## Refactoring (if needed)

- [ ] Refactor tax calculation into separate method for clarity
- [ ] Refactor discount calculation into separate method
- [ ] Ensure all tests still pass after refactoring
```

## References

- [TDD with Github Copilot Agent](https://www.loom.com/share/d442996affe14bdea81014183f633988)

## Keep Reading

[Automatic Code Validations](./WORKFLOW_AUTO_VALIDATIONS.md)
