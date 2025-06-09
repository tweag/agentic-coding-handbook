# Three Experts Prompt - README

## Overview

The "Three Experts" prompt is a structured framework designed to help you get comprehensive, multi-perspective analysis on complex software engineering problems. By simulating three different experts, each with a distinct viewpoint, you'll receive a more thorough analysis than you might get from a single perspective.

## When to Use This Prompt

This prompt is particularly valuable when:

- You're facing architectural decisions with significant long-term implications
- You're unsure which of several approaches is optimal
- You need to understand trade-offs between different solutions
- You want to ensure you've considered edge cases and potential issues
- You're implementing a complex system and need structured thinking

## How to Use the Prompt

1. **Copy the prompt**: Copy the entire content from the PROMPT.md file.

2. **Fill in the tagged sections**:
   - Replace the text in `<task_description>` with a detailed explanation of your problem
   - (Optional) Fill in `<current_approach>` with any existing implementation details
   - (Optional) Add any `<specific_concerns>` you want addressed

3. **Submit to an AI assistant**: Paste the completed prompt into your preferred AI assistant (like Claude).

4. **Review the multi-perspective analysis**: You'll receive analysis from three different expert perspectives, followed by a collaborative recommendation.

## Tips for Getting the Best Results

- **Be specific and detailed** in your task description. Vague queries get vague responses.
- **Include relevant code snippets** when applicable to give the experts concrete material to work with.
- **Mention your technology stack** and any constraints you're working under.
- **Specify performance requirements** or other non-functional requirements that matter for your use case.
- **Ask follow-up questions** if you need clarification on any part of the response.

## Example Usage

Instead of asking:
> "What's the best way to implement caching in my app?"

Use the prompt with:
> "<task_description>
> I need to implement a caching system for a Node.js e-commerce API that handles approximately 5,000 requests per minute. The data being cached includes product information, user preferences, and shopping cart contents. Currently, our database queries are creating a bottleneck, especially during peak hours. Cache invalidation is particularly challenging since product data is updated from multiple services.
> </task_description>
> 
> <current_approach>
> We're currently using Redis for session management but not for data caching. We've experimented with in-memory caching using Node.js Map objects, but this doesn't work well in our clustered environment.
> </current_approach>
> 
> <specific_concerns>
> - How should we handle cache invalidation across multiple services?
> - What's the appropriate TTL strategy for different types of data?
> - Should we use a write-through or write-behind caching pattern?
> - How do we monitor cache hit/miss rates?
> </specific_concerns>"

## Customization

Feel free to modify the experts' roles based on your specific needs. For example, you might want:
- A security expert
- A DevOps specialist
- A domain-specific expert (e.g., ML engineer, database specialist)
- A UX-focused developer

You can adjust the prompt to specify exactly what type of expertise you need for your particular problem.