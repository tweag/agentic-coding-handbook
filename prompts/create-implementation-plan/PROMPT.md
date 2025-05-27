# Vibe Coding Implementation Plan Generator

## Context
I need your help creating a detailed implementation plan for a software feature or user story using a "vibe coding" approach. This involves leveraging AI to break down requirements into manageable, testable chunks that can be incrementally built and verified.

## Step 1: Requirement Clarification
First, help me refine and clarify the requirements through a focused conversation:

1. Ask ONE specific, relevant question at a time about the feature/story
2. Use each answer to build understanding of project needs
3. Continue asking targeted questions until we've covered:
   - Core functionality and features
   - Technical architecture
   - Data models and relationships
   - User experience requirements
   - Integration points
   - Performance expectations
   - Edge cases and error handling
   - Security considerations

## Step 2: Comprehensive Specification
Once requirements are clear, create a complete specification document (spec.md) including:

1. **Executive Summary**: Concise overview of feature purpose and goals
2. **Functional Requirements**:
   - Core features and user workflows
   - Interface requirements and interaction patterns
   - Performance expectations and constraints
3. **Technical Specifications**:
   - Architecture design and component relationships
   - Technology stack recommendations with justifications
   - Data models, schemas, and relationships
   - API specifications (if applicable)
   - Integration points with external systems
4. **Implementation Considerations**:
   - Error handling strategies
   - Edge cases and their solutions
   - Security requirements
   - Scalability considerations
5. **Testing Strategy**:
   - Testing approach and coverage expectations
   - Acceptance criteria

## Step 3: Implementation Planning
Break down the specification into an incremental development plan:

1. Draft a high-level blueprint outlining project scope and major components
2. Divide this blueprint into logical, incremental milestones that build upon each other
3. Break down each milestone into specific implementation tasks that are:
   - Focused on a single responsibility
   - Small enough to implement and test confidently
   - Large enough to provide meaningful progress
   - Connected to previous work
4. For each task, create a specific coding prompt that:
   - Clearly states what needs to be implemented
   - References previous code as needed
   - Includes test requirements
   - Explains integration with existing components

## Step 4: Development Roadmap
Generate two key outputs:

1. **prompt_plan.md**: Step-by-step prompts for code generation tools like Cursor, Claude Code, etc.
   ```markdown
   # Implementation Prompts for [Feature Name]
   
   ## Setup and Prerequisites
   
   ```prompt
   [Description of what needs to be set up first]
   
   Please set up the initial project structure for [feature] with the following:
   - [Specific framework/library requirements]
   - [File structure needed]
   - [Configuration requirements]
   
   Generate the following files:
   1. [Filename] - [Purpose]
   2. [Filename] - [Purpose]
   
   Include tests that verify:
   - [Test criteria]
   ```
   
   ## Milestone 1: [Milestone Name]
   
   ### Task 1.1: [Task Name]
   
   **Context:** [Explanation of how this fits into the overall project]
   
   ```prompt
   [Detailed description of what code needs to be implemented]
   
   Requirements:
   - [Specific requirement]
   - [Specific requirement]
   
   This should integrate with [existing component] by [explanation of integration].
   
   Include tests that verify:
   - [Test criteria]
   - [Test criteria]
   ```
   
   ### Task 1.2: [Task Name]
   
   ...
   
   ## Milestone 2: [Milestone Name]
   
   ...
   
   ## Integration and Final Testing
   
   ```prompt
   [Final integration steps]
   
   Please implement integration tests that verify:
   - [Integration test criteria]
   - [Integration test criteria]
   ```
   ```

2. **todo.md**: A comprehensive, actionable checklist of tasks that can be checked off during development
   ```markdown
   # Development Checklist for [Feature Name]
   
   ## Setup and Prerequisites
   - [ ] Set up project structure
   - [ ] Configure development environment
   - [ ] Install required dependencies
   
   ## Milestone 1: [Milestone Name]
   
   ### Core Implementation
   - [ ] Task 1.1: [Clear, actionable description]
     - [ ] Implement [specific component/function]
     - [ ] Write tests for [specific component/function]
     - [ ] Ensure tests are passing
   
   - [ ] Task 1.2: [Clear, actionable description]
     - [ ] Implement [specific component/function]
     - [ ] Write tests for [specific component/function]
     - [ ] Ensure tests are passing
   
   ### Review & Refactoring
   - [ ] Refactor [specific component] for better [performance/readability/etc.]
   - [ ] Ensure all tests still pass after refactoring
   
   ## Milestone 2: [Milestone Name]
   
   ### Feature Implementation
   - [ ] Task 2.1: [Clear, actionable description]
     - [ ] Implement [specific component/function]
     - [ ] Write tests for [specific component/function]
   
   ...
   
   ## Final Integration
   - [ ] Integrate all components
   - [ ] Run comprehensive test suite
   - [ ] Verify all acceptance criteria are met
   
   ## Deployment Preparation
   - [ ] Update documentation
   - [ ] Prepare release notes
   - [ ] Final code review
   ```

## Integration Options
If I've shared any of these resources, use them to enhance your analysis:
- **Jira tickets**: Extract acceptance criteria, requirements, and dependencies
- **Confluence pages**: Gather context, technical documentation, and related information
- **Figma designs**: Reference for UI/UX implementation details and visual requirements
- **Codebase or repository details**: Understand existing architecture and implementation patterns

## Implementation Principles
Throughout the planning process, emphasize:
- Test-driven development (TDD) approach
- Incremental progress with verifiable steps
- Clear dependency chains between components
- Small, focused tasks that build toward the whole
- Integration testing at logical milestones

## Example Input
I need an implementation plan for adding a "forgot password" feature to our authentication system. The feature should allow users to reset their password via email.

## My User Story/Feature
[Replace this with your feature requirements. For example:

Feature: Inventory Management System for Small Retail Business

As a retail store owner, I need a simple inventory management system that allows me to:
- Track product stock levels in real-time
- Receive notifications when items reach low stock thresholds
- Generate inventory reports (daily, weekly, monthly)
- Scan barcodes to quickly update inventory during receiving
- Log sales and automatically adjust inventory counts

Technical context:
- Need to support both web and mobile access
- Should integrate with our existing Square POS system
- Must be cloud-based with offline capabilities
- Currently have approximately 1,500 different SKUs
- Need to support multiple user roles (admin, manager, staff)

Existing systems:
- Square POS for sales
- QuickBooks for accounting
- G Suite for business operations

User profile:
- Small team (5-8 users)
- Limited technical expertise
- Need simple, intuitive interface]