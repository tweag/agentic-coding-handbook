# 🔁 Migration Workflow

*A structured approach to modernizing legacy code with the help of AI*

## Overview

This workflow builds on the [Refactoring Workflow](./WORKFLOW_REFACTORING.md) but is focused on **larger migrations** — moving from legacy codebases to modern architectures. Code migration often involves not just cleaning up code but rethinking architecture, decoupling responsibilities, and introducing tests and observability where none existed.

This guide outlines how to combine agentic tools (e.g., Copilot Chat, Cursor, Claude) with deliberate human design to migrate legacy systems safely, incrementally, and with confidence.

> ⚠️ **Important:** Avoid treating migration as a big-bang rewrite. Break the scope into manageable, well-defined chunks. This reduces risk, accelerates feedback, and allows the new system to deliver value earlier.

---

## 🔍 Step 1: Understand the Legacy Codebase

Before touching anything, build a mental model of how the legacy app works.

### Use AI agents to:

* Extract business rules from old source files
* Generate high-level summaries of legacy files (e.g. `main.cob`, `operations.cob`)
* Identify relationships between components and dependencies
* Search for legacy patterns and undocumented logic through comments, unused paths, or inline configuration
* Suggest boundaries or seams that can be used to insert logging or adapter logic later on

#### Suggested Prompt:

```
@workspace explain how the system works, including data flow and file responsibilities.
```

Repeat this per module to reduce hallucination risk. Use chain-of-thought Q\&A if the system is large.

---

## ⚖️ Step 2: Plan the Migration Strategy

Avoid rewriting everything at once. Instead, define a **gradual migration plan**.

* Use the **strangler pattern** to incrementally replace legacy modules
* Introduce **adapters** to allow coexistence of old and new logic
* Prioritize domains based on risk, impact, and churn
* Define **migration slices** (e.g., by domain, UI route, service boundary) and plan deliverables for each

### Use AI agents to:

* Generate draft migration plans based on the code structure and identified responsibilities
* Suggest natural slicing strategies by analyzing module responsibilities and coupling
* Draft adapter layers to connect legacy components with new interfaces
* Prioritize migration items using change frequency, error history, and business importance
* Cluster files by feature, dependency, or frequency of change using embedding-based semantic similarity
* Evaluate compatibility between old and new code contracts (function signatures, object shapes)

#### Suggested Prompts:

```
Based on this codebase, can you suggest a migration plan that replaces modules incrementally?
```

```
Given these legacy modules, which parts should be migrated first to reduce risk and unlock quick wins?
```

Document the plan and revisit it regularly.

---

## 🧪 Step 3: Introduce Tests on the Legacy Side

Before any migration or analysis begins, build a safety net.

Legacy systems often lack test coverage — use that to your advantage.

* Write **unit tests** around critical logic
* Write **end-to-end (e2e) tests** around user-facing flows
* Derive tests from **real input/output examples** in the existing system

These tests will serve as contracts to validate the new implementation, making sure you're not rewriting blindly.

### Use AI agents to:

* Generate boilerplate test cases from existing code
* Translate manually verified inputs and outputs into regression test cases
* Suggest mocking strategies to decouple legacy components
* Validate whether a test exercises all paths (line coverage vs. branch coverage)

### Optional:

Use AI to bootstrap test scaffolding from existing code snippets.

---

## 🔁 Step 4: Map the Functional and Data Flows

Once files are understood individually, map how they interact.

### Use Copilot or Cursor to:

* Create **sequence diagrams** or **Mermaid flowcharts**
* Identify key interactions between services, APIs, and DBs
* Infer undocumented flows between DB tables, queues, and REST calls
* Visualize hidden or indirect coupling via shared global state or side effects

#### Suggested Prompt:

```
Can you create a Mermaid sequence diagram showing how data flows across modules X, Y, Z?
```

Save this as living documentation. Use it to guide architectural decisions.

---

## 🧱 Step 5: Define the Target Architecture

Migration without a destination is just refactoring chaos.

Use this step to define:

* Modular structure (monolith, modular monolith, or microservices)
* Domain boundaries
* Responsibilities per service/module
* Clean Architecture layers (UI / Application / Domain / Infra)

### Use AI agents to:

* Generate candidate modular splits based on current code clustering
* Propose service decomposition plans that reflect domain boundaries
* Map legacy files to future layers and suggest transitional interfaces
* Highlight logic that should move to domain vs. infra

This doesn’t need to be exhaustive, but it must provide **direction**.

---

## 💥 Step 6: Identify and Isolate Technical Debt

Migration is the perfect moment to surface — and kill — hidden debt.

### Use Cursor or Copilot to:

1. Build a file/module inventory
2. Spot common signs of debt: huge functions, global state, complex branching
3. Annotate components needing full rewrites vs. light refactors
4. Measure complexity scores (e.g., cyclomatic complexity) and surface hot spots
5. Estimate how long it will take to rewrite vs. isolate

#### Suggested Prompt Chain:

```
Explain structure → Identify modules → List technical debt areas
```

Validate AI suggestions manually.

---

## 🧠 Step 7: Prompt Engineering for Migration

Agents need context. That means:

* Referencing legacy files directly (`#file:...`)
* Asking for output in reusable chunks
* Guiding with architectural goals (e.g., decoupling, layering)

### Use AI agents to:

* Enforce style and architecture rules in rewritten code
* Refactor legacy logic using modern patterns
* Incrementally build new APIs that are compatible with legacy contracts
* Generate transitional interfaces (adapter, proxy, anti-corruption layer)

#### Example Prompt:

```
Based on the legacy function `processLegacyTransaction()`, can you extract the business rule and propose a cleaner version using service/repository layers?
```

---

## 📊 Step 8: Define Success Metrics

Define KPIs before starting:

* How will you know migration is working?
* How will you measure regressions?

Examples:

* Error rate in new stack vs. old
* Time to deliver new features
* Coverage of legacy code replaced
* Test pass rate on migrated vs. legacy logic
* Developer confidence score for each new release

### Use AI agents to:

* Compare logs and metrics across legacy and new systems
* Automatically tag commits as "migration-related" and track velocity
* Detect regressions by analyzing test snapshots, logs, or API diffs

Track these over time to justify the investment.

---

## 🔌 Final Notes

Migration is as much about **understanding and documentation** as it is about coding. By combining prompt engineering, test-driven safety nets, and architecture-guided planning, you can modernize legacy systems without going blind.

Start small. Plan big. Ship in pieces. And always let the agents help where they can — but never go fully autopilot.

---

## Related Workflows

* [Refactoring Workflow](./WORKFLOW_REFACTORING.md)
* [Prompt Engineering](./PROMPT_ENGINEERING.md)
* [Debugging Workflow](./WORKFLOW_DEBUG.md)
* [Spec-First Development](./WORKFLOW_SPEC_FIRST_APPROACH.md)
