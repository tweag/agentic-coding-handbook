---
applyTo: "**/*.tsx"
---

# Rules and best practices for working with React

## React + TypeScript Coding Standards

- You MUST always use **functional components** with TypeScript.
- You MUST define **prop types** using `interface` or `type` instead of relying on `PropTypes`.
- You MUST always type component props explicitly, even if they are empty (e.g., `FC&lt;{}&gt;` or `React.FC&lt;{ propName: string }&gt;`).
- You SHOULD NEVER use the `any` type. Use more specific types like `unknown`, `string`, or custom types/interfaces.
- You MUST type all state variables using `useState` (e.g., `const [count, setCount] = useState&lt;number&gt;(0);`).
- You MUST always type event handlers explicitly (e.g., `(event: React.ChangeEvent&lt;HTMLInputElement&gt;) =&gt; void`).

## JSX + TypeScript Best Practices

- You MUST always wrap multi-line JSX expressions in parentheses for better readability.
- You MUST use **self-closing tags** for elements without children (e.g., `<img>`, `&lt;input /&gt;`).
- You SHOULD NEVER inline complex logic directly in JSX. Extract it into helper functions or variables for clarity.
- You MUST always provide a `key` prop when rendering lists of elements to ensure proper reconciliation by React.
- You SHOULD ALWAYS type refs using `React.RefObject&lt;T&gt;` or `React.MutableRefObject&lt;T&gt;`.

## Component Design Guidelines

- You MUST follow the **Single Responsibility Principle (SRP)** when designing components. Each component should do one thing well.
- You SHOULD NEVER create components with more than **200 lines of code**. Break them into smaller, reusable components if necessary.
- You MUST always prefer **composition over inheritance** when creating reusable components.
- You SHOULD NEVER pass more than **5 props** to a single component. Use objects or context if more data needs to be passed.
- For reusable components, you MUST use **generic types** where applicable (e.g., `&lt;T&gt;` for lists or forms).

## State Management with TypeScript

- You MUST manage local component state using `useState` or `useReducer`, and you MUST type the state explicitly.
  - Example: `const [state, setState] = useState&lt;{ count: number }&gt;({ count: 0 });`
- For global state, you SHOULD use a dedicated state management library (e.g., Redux, Zustand) or React Context API when appropriate, ensuring all actions and reducers are typed.
- You SHOULD NEVER store derived data in the state. Instead, compute it dynamically from existing state or props.

## Performance Optimization

- You MUST always memoize expensive calculations using `useMemo` and functions using `useCallback`, ensuring proper typing for both.
  - Example: `const memoizedValue = useMemo&lt;number&gt;(() =&gt; computeExpensiveValue(a, b), [a, b]);`
- You SHOULD NEVER pass anonymous functions as props unless memoization is unnecessary.
- You MUST use `React.memo` for functional components that do not need to re-render frequently.
- For large lists, you SHOULD ALWAYS use virtualization libraries like `react-window` or `react-virtualized`.

## Styling Guidelines

- You SHOULD prefer **CSS-in-JS libraries** (e.g., styled-components, Emotion) or utility-first CSS frameworks like TailwindCSS for styling components.
- When using styled-components or Emotion, you MUST type props explicitly in styled components:

```

const StyledButton = styled.button<{ isActive: boolean }>` background-color: ${(props) =&gt; (props.isActive ? 'blue' : 'gray')};  `;

```

- You MUST scope styles to components to avoid global CSS conflicts.
- You SHOULD NEVER hardcode styles directly in JSX unless they are dynamic and cannot be handled via CSS.

## Testing Guidelines

- You MUST write unit tests for all critical components using the specified testing framework (e.g., React Testing Library).
- Tests SHOULD focus on user behavior and component output rather than implementation details.
- You SHOULD mock external dependencies in tests to isolate component behavior.
- For complex interactions, you MUST write integration tests that span multiple components.

## Error Handling

- You MUST handle errors gracefully using error boundaries (`React.ErrorBoundary`) where applicable.
- Error boundaries SHOULD be typed explicitly:

```

class ErrorBoundary extends React.Component<
{ children: React.ReactNode },
{ hasError: boolean }
> {
constructor(props: { children: React.ReactNode }) {
super(props);
this.state = { hasError: false };
}
// Implementation here
}

```

## Accessibility Rules

- You MUST ensure all interactive elements have accessible labels (`aria-label`, `aria-labelledby`, etc.).

## Linting and Formatting

- The codebase MUST adhere to the linting rules defined in `.eslintrc`. Fix all linting issues before committing code.
- Use ESLint plugins like `eslint-plugin-react` and `eslint-plugin-react-hooks`.
- Include TypeScript-specific rules via `@typescript-eslint`.
- Prettier SHOULD be used as the default formatter for consistent styling across files.
