# Multiple Iterations Reasoning Method

The Multiple Iterations Reasoning prompt is a structured approach designed to guide AI systems through progressive rounds of self-improvement. This method leverages iterative analysis and refinement to produce solutions that are more robust, optimized, and thoroughly considered.

In agentic coding, this technique is particularly valuable when dealing with complex problems that benefit from layered analysis, such as algorithm development, system architecture design, or code optimization where the first solution is rarely the best one.

## What's the Method?

**Core Prompt Pattern:**

```txt
I want you to solve the following problem/task: [DESCRIBE PROBLEM OR TASK HERE]

## Iterative Solution Process

### 1. Initial Solution
Provide a concise initial solution to the problem. Focus on core requirements and a working approach. Keep code examples minimal.

### 2. Analysis Rounds (3 iterations)
For each round:

#### a) Critical Analysis
- Strengths: What works well (2-3 key points)
- Weaknesses: Edge cases and limitations (2-3 key points)
- Potential optimizations (1-2 specific improvements)

#### b) Solution Refinement
- Implement key changes that address the most critical weaknesses
- Focus only on substantial improvements
- Note briefly what changed and why

### 3. Last Solution
Provide your optimized solution with:
- A brief summary of major improvements (2-3 sentences)
- Any remaining considerations
```

This creates a self-reflective loop that encourages the AI to critically evaluate and improve its own work multiple times.

| **Use Case**                              | **Why It Works**                                     |
|-------------------------------------------|------------------------------------------------------|
| Algorithm optimization                    | Forces consideration of edge cases and performance   |
| System design refinement                  | Builds in layers of error handling and robustness    |
| Code quality improvement                  | Progressively enhances readability and maintainability|
| Problem-solving with constraints          | Tests solution against increasingly complex criteria |
| Test coverage planning                    | Expands from basic to comprehensive test scenarios   |

## Example 1: Optimizing a Search Algorithm

**Goal:** Develop an efficient algorithm for searching partially sorted data.

Prompt:

```txt
I want you to solve the following problem: Design an algorithm to find a target number in a partially sorted array (elements are sorted in ascending order, then rotated at some pivot).

## Iterative Solution Process

### 1. Initial Solution
Provide a concise initial solution to the problem. Focus on core requirements and a working approach. Keep code examples minimal.

### 2. Analysis Rounds (3 iterations)
For each round:

#### a) Critical Analysis
- Strengths: What works well (2-3 key points)
- Weaknesses: Edge cases and limitations (2-3 key points)
- Potential optimizations (1-2 specific improvements)

#### b) Solution Refinement
- Implement key changes that address the most critical weaknesses
- Focus only on substantial improvements
- Note briefly what changed and why

### 3. Last Solution
Provide your optimized solution with:
- A brief summary of major improvements (2-3 sentences)
- Any remaining considerations
```

**Expected Outcome:**
- Initial solution might use linear search O(n)
- First iteration might identify binary search potential
- Second iteration might handle the rotation complexity
- Final solution likely optimizes to O(log n) with detailed edge cases covered

## Example 2: Designing a Caching Strategy

**Goal:** Create a caching implementation for a data-intensive application.

Prompt:

```txt
I want you to solve the following problem: Design a caching strategy for a web application that handles thousands of product queries per minute with data that changes infrequently (once per day).

## Iterative Solution Process

### 1. Initial Solution
Provide a concise initial solution to the problem. Focus on core requirements and a working approach. Keep code examples minimal.

### 2. Analysis Rounds (3 iterations)
For each round:

#### a) Critical Analysis
- Strengths: What works well (2-3 key points)
- Weaknesses: Edge cases and limitations (2-3 key points)
- Potential optimizations (1-2 specific improvements)

#### b) Solution Refinement
- Implement key changes that address the most critical weaknesses
- Focus only on substantial improvements
- Note briefly what changed and why

### 3. Last Solution
Provide your optimized solution with:
- A brief summary of major improvements (2-3 sentences)
- Any remaining considerations
```

**Expected Outcome:**
- Initial solution might use a simple time-based cache
- Progressive iterations address invalidation strategies, memory concerns
- Later rounds might introduce Redis, cache layers, or warm-up procedures 
- Final solution likely includes a comprehensive strategy with fallbacks

## Example 3: Building a Robust API Error Handling System

**Goal:** Design an error handling system for a microservice architecture.

Prompt:

```txt
I want you to solve the following problem: Design a standardized error handling system for a collection of microservices that needs to provide consistent error responses, logging, retries, and circuit breaking.

## Iterative Solution Process

### 1. Initial Solution
Provide a concise initial solution to the problem. Focus on core requirements and a working approach. Keep code examples minimal.

### 2. Analysis Rounds (3 iterations)
For each round:

#### a) Critical Analysis
- Strengths: What works well (2-3 key points)
- Weaknesses: Edge cases and limitations (2-3 key points)
- Potential optimizations (1-2 specific improvements)

#### b) Solution Refinement
- Implement key changes that address the most critical weaknesses
- Focus only on substantial improvements
- Note briefly what changed and why

### 3. Last Solution
Provide your optimized solution with:
- A brief summary of major improvements (2-3 sentences)
- Any remaining considerations
```

**Expected Outcome:**
- Initial solution might focus on basic error structure
- Middle iterations refine retry policies, circuit breaking logic
- Later iterations might add observability, error aggregation
- Final solution would be a layered approach with examples of implementation

## Summary: Why Use the Multiple Iterations Reasoning Pattern?

| **Benefit**                                     | **Why It Helps in Agentic Coding**                    |
|-------------------------------------------------|------------------------------------------------------|
| Promotes depth over breadth                     | Forces solutions beyond the obvious first approach    |
| Documents the evolution of thinking             | Creates transparency in the solution development      |
| Identifies edge cases systematically            | Reduces the "oh, I didn't think of that" factor      |
| Builds in justified refinement                  | Each improvement has explicit reasoning               |
| Mimics real development processes               | Aligns with how engineers actually solve problems     |
| Works well with modern AI models                | Leverages LLM capabilities for self-critique         |

## Variations

For greater refinement in specific areas:

```txt
For iteration 2, focus specifically on performance optimization.
For iteration 3, focus exclusively on edge case handling.
```

For constrained prompting:

```txt
Limit each solution to under 50 lines of code, forcing increasingly elegant solutions.
```

## References

- [Multiple Iterations Reasoning Prompt Pattern](https://www.loom.com/share/10ecca1aa5a54eaf95669f2fe16cd56f?sid=1607557b-5d22-4d49-935e-933bdde55442)
