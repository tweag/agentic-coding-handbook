# Migration Workflow

*A structured approach to modernizing legacy code with the help of AI*

## Overview

This workflow builds on the [Refactoring Workflow](./WORKFLOW_REFACTORING.md) but is focused on **larger migrations** — moving from legacy codebases to modern architectures. Code migration often involves not just cleaning up code but rethinking architecture, decoupling responsibilities, and introducing tests and observability where none existed.

This guide outlines how to combine agentic tools (e.g., Copilot Chat, Cursor, Claude) with deliberate human design to migrate legacy systems safely, incrementally, and with confidence.

> **Important:** Avoid treating migration as a big-bang rewrite. Break the scope into manageable, well-defined chunks. This reduces risk, accelerates feedback, and allows the new system to deliver value earlier.

---

## Step 1: Understand the Legacy Codebase

Before touching anything, build a mental model of how the legacy app works.

### Use AI agents to:

* Extract business rules from old source files
* Generate high-level summaries of legacy files (e.g. `main.cob`, `operations.cob`)
* Identify relationships between components and dependencies
* Search for legacy patterns and undocumented logic through comments, unused paths, or inline configuration
* Suggest boundaries or seams that can be used to insert logging or adapter logic later on
* Identify potential migration challenges (e.g., lack of tests, complex dependencies, custom functions or modules)

#### Suggested Prompt:

```
@workspace explain how the system works, including data flow and file responsibilities.
```

Repeat this per module to reduce hallucination risk. Use chain-of-thought Q\&A if the system is large.

---

## Step 2: Plan the Migration Strategy

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

## Step 3: Establish Stakeholder Communication

**Most migrations fail due to misaligned expectations, not code quality.** Establish clear communication channels early.

### Key Communication Elements

* **Progress Dashboard**: Visual representation of migration status (% complete, modules migrated, risks identified)
* **Regular Updates**: Weekly/bi-weekly reports with concrete progress metrics
* **Risk Communication**: Transparent about potential disruptions, timelines, and mitigation strategies
* **Business Impact Translation**: Convert technical progress into business value metrics

### Use AI agents for stakeholder communication to

* Generate executive summaries from technical progress reports
* Create visual progress dashboards using migration metrics
* Draft stakeholder-friendly explanations of technical decisions
* Suggest communication templates for different audience types (executives, product managers, end users)

#### Suggested Communication Template

```markdown
Migration Progress Update - Week X
- Modules Completed: X/Y (Z% complete)
- Business Value Delivered: [specific features or improvements]
- Upcoming Milestones: [next 2-3 deliverables]
- Risks & Mitigations: [current blockers and solutions]
- Timeline Status: [on track, delayed, ahead of schedule]
```

---

## Step 4: Introduce Tests on the Legacy Side

Before any migration or analysis begins, build a safety net.

Legacy systems often lack test coverage — use that to your advantage.

* Write **unit tests** around critical logic
* Write **end-to-end (e2e) tests** around user-facing flows
* Derive tests from **real input/output examples** in the existing system

These tests will serve as contracts to validate the new implementation, making sure you're not rewriting blindly.

> **Note:** Make sure to cover the critical paths and edge cases. If, for some reason, there are functionalities that are not being used, consider removing them to reduce complexity or rewriting unnecessary parts.

### Use AI agents to:

* Generate boilerplate test cases from existing code
* Translate manually verified inputs and outputs into regression test cases
* Suggest mocking strategies to decouple legacy components
* Validate whether a test exercises all paths (line coverage vs. branch coverage)

### Optional:

Use AI to bootstrap test scaffolding from existing code snippets.

---

## Step 5: Map the Functional and Data Flows

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

## Step 6: Define the Target Architecture

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

## Step 7: Plan Rollback & Fallback Mechanisms

Legacy systems often have implicit assumptions that need explicit safety nets during migration.

### Critical Rollback Considerations

* **Feature Flags**: Use toggles to switch between legacy and new implementations
* **Data Synchronization**: Ensure data consistency during rollbacks
* **Traffic Routing**: Ability to redirect users back to legacy systems
* **Security Context**: Handle authentication/authorization state transitions

### Security Migration Gotchas

* **Hardcoded Secrets**: Legacy systems often embed credentials directly in code
* **Legacy Auth Patterns**: Session-based auth vs. modern token-based systems
* **Permission Models**: Role-based access may need translation layers

### Use AI agents for rollback planning to

* Identify hardcoded secrets and suggest secure alternatives
* Generate feature flag implementations for gradual rollouts
* Create rollback checklists and procedures
* Analyze authentication flows and suggest migration paths
* Design data synchronization strategies between old and new systems

#### Rollback Checklist Template

```markdown
Pre-Migration:
[ ] Feature flags implemented and tested
[ ] Data backup and sync mechanisms verified
[ ] Rollback procedure documented and rehearsed
[ ] Security context transition plan validated

During Migration:
[ ] Monitor error rates and performance metrics
[ ] Validate authentication/authorization flows
[ ] Confirm data consistency between systems
[ ] Test rollback triggers under load

Post-Migration:
[ ] Keep legacy system warm for X days
[ ] Monitor for delayed edge cases
[ ] Document lessons learned
[ ] Update rollback procedures for next iteration
```

---

## Step 8: Identify and Isolate Technical Debt

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

## Step 9: Prompt Engineering for Migration

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

## Step 10: Modernize Toolchain & Infrastructure

**Migration isn't just code** — it often includes modernizing the entire development and deployment ecosystem. Plan these updates to run **parallel** to code migration where possible.

### Infrastructure Modernization Areas

* **CI/CD Pipelines**: Jenkins → GitHub Actions, CircleCI, or similar
* **Observability Stack**: Legacy monitoring → OpenTelemetry, structured logging
* **Deployment Strategy**: Manual deploys → Infrastructure as Code (Terraform, CDK)
* **Development Tools**: IDE setup, linting, testing frameworks

### Use AI agents for infrastructure migration to

* Generate GitHub Actions workflows from existing Jenkins pipelines
* Create Infrastructure as Code templates for current manual deployments
* Suggest observability improvements and instrumentation points
* Generate migration scripts for database schemas and data
* Design monitoring dashboards for both legacy and new systems

### Migration Timeline Priorities

1. **Development tools first** - improves developer velocity immediately
2. **CI/CD next** - ensures safe, repeatable deployments
3. **Observability early** - provides visibility into migration progress
4. **Infrastructure last** - once code patterns are established

#### Infrastructure Migration Checklist

```markdown
Development Environment:
[ ] Modern IDE configuration and extensions
[ ] Automated code formatting and linting
[ ] Local development environment automation
[ ] Testing framework modernization

CI/CD Pipeline:
[ ] Automated testing in CI
[ ] Security scanning integration
[ ] Deployment automation
[ ] Rollback mechanisms

Observability:
[ ] Structured logging implementation
[ ] Metrics collection and dashboards
[ ] Distributed tracing setup
[ ] Alerting and incident response

Infrastructure:
[ ] Infrastructure as Code adoption
[ ] Security baseline hardening
[ ] Backup and disaster recovery
[ ] Performance monitoring
```

---

## Step 11: Define Success Metrics

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

## Step 12: Prepare Developer Onboarding Documentation

**New developers joining mid-migration need context fast.** Create living documentation that captures decisions and rationale.

### Essential Onboarding Materials

* **Migration Decision Log**: Why certain approaches were chosen over alternatives
* **Architecture Decision Records (ADRs)**: Document significant technical decisions
* **Code Map**: Visual guide showing what's been migrated, what's in progress, and what's legacy
* **Local Development Setup**: How to run both legacy and new systems locally

### Use AI agents for onboarding to

* Generate ADRs from code changes and migration decisions
* Create visual code maps showing migration progress
* Draft onboarding checklists for new team members
* Maintain up-to-date setup instructions based on current codebase state
* Generate context-rich code comments explaining migration-specific patterns

#### Sample ADR Template

```markdown
# ADR-001: Migration Strategy for User Authentication

## Status: Accepted

## Context
Legacy system uses session-based auth with server-side state.
Modern requirements need stateless, scalable authentication.

## Decision
Implement JWT-based authentication with refresh token rotation.

## Consequences
- Positive: Stateless, horizontally scalable
- Negative: Requires token refresh logic
- Migration: Dual-mode support during transition

## Implementation Notes
[Technical details and code examples]
```

---

## Final Notes

Migration is as much about **understanding and documentation** as it is about coding. By combining prompt engineering, test-driven safety nets, and architecture-guided planning, you can modernize legacy systems without going blind.

Start small. Plan big. Ship in pieces. And always let the agents help where they can — but never go fully autopilot.

---

## Related Workflows

* [Refactoring Workflow](./WORKFLOW_REFACTORING.md)
* [Prompt Engineering](./PROMPT_ENGINEERING.md)
* [Debugging Workflow](./WORKFLOW_DEBUG.md)
* [Spec-First Development](./WORKFLOW_SPEC_FIRST_APPROACH.md)
