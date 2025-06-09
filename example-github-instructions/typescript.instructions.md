---
applyTo: "**/*.ts,**/*.tsx"
---

# General rules and best practices for working with TypeScript code

## TypeScript Coding Standards

- You MUST always use strict typing. Avoid the `any` type unless absolutely necessary.
- You MUST always enable and respect the strict mode in the `tsconfig.json` file.
- You MUST always prefer type aliases or interfaces over inline object types for better readability and reusability.
- You MUST always annotate function return types explicitly, except for trivial cases where inference is obvious (e.g., getters).
- You MUST always use readonly for properties that should not be modified after initialization.
- You MUST always use strict null checks.
- You MUST always prefer interface over type when possible.
- You MUST always utilize type guards and assertions for runtime type checking.
- You MUST always implement proper type inference to reduce explicit type annotations.
- You MUST always use nullish coalescing operator (`??`) instead of a logical or (`||`), as it is a safer operator.
- You SHOULD NEVER use non-null assertions (`!`) unless you are certain the value cannot be null or undefined.

## Best Practices for TypeScript Features

### Union and Intersection Types

- You MUST use union types (`|`) to represent a value that can be one of several types.
- You SHOULD use intersection types (`&`) sparingly and only when combining multiple types is necessary.

### Enums

- You SHOULD prefer using string literal unions over enums unless enums are required for specific use cases.

### Generics

- You MUST use generics to create reusable components or functions when working with collections or dynamic data structures.
- You SHOULD ALWAYS provide meaningful names for generic type parameters (e.g., `TItem` instead of just `T`).

## Error Handling

- You MUST always handle errors gracefully using `try-catch` blocks or equivalent mechanisms.
- You SHOULD NEVER throw raw strings or numbers as errors. Always throw instances of `Error` or custom error classes.
- You MUST annotate error handling logic with meaningful comments to explain why errors are being caught or re-thrown.

## Code Organization

- You MUST organize your code into modules to promote reusability and maintainability.
- You SHOULD group related utility functions into separate files (e.g., `utils.ts`).
- You MUST follow a consistent import order:
  1. Node.js built-ins (e.g., `fs`, `path`)
  2. External libraries (e.g., `react`, `lodash`)
  3. Internal imports (relative paths)

## Testing Guidelines

- You MUST write unit tests for all critical functions and components using the testing framework specified by the project (e.g., Vitest).
- You SHOULD aim for at least 80% test coverage across all TypeScript files.
- You MUST mock external dependencies in tests to isolate functionality.
- Tests SHOULD include edge cases and failure scenarios.

## Security Rules

- You SHOULD NEVER expose sensitive data (e.g., API keys) in TypeScript files. Use environment variables instead.
- You MUST validate all user inputs thoroughly to prevent injection attacks or other vulnerabilities.
- You MUST sanitize any data before rendering it in a UI component to prevent XSS attacks.

## Performance Optimization

- You SHOULD ALWAYS avoid expensive operations inside loops or frequently called functions.
- You MUST debounce or throttle expensive operations triggered by user events (e.g., scrolling, resizing).
- When working with large datasets, you SHOULD prefer lazy loading or pagination over loading everything at once.

## Linting and Formatting

- The codebase MUST adhere to the linting rules defined in `.eslintrc`. Fix all linting issues before committing code.
- Prettier SHOULD be used as the default formatter for consistent styling across files.
