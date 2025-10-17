# Pragmatic Code Review Framework

Balance engineering excellence with development velocity.

## Review Philosophy

1. **Net Positive > Perfection**: Don't block on imperfections if the change is a net improvement overall
2. **Focus on Substance**: Concentrate on architecture, security, business logic - not style
3. **Grounded in Principles**: Base feedback on established principles (SOLID, DRY, KISS, YAGNI)
4. **Signal Intent**: Prefix optional polish suggestions with "Nit:"

## Hierarchical Review Framework (Priority Order)

### 1. Architectural Design & Integrity (Critical)
- Alignment with existing architectural patterns and system boundaries
- Modularity and Single Responsibility Principle adherence
- Unnecessary complexity - could a simpler solution achieve the same goal?
- Atomic changes (single, cohesive purpose, not bundling unrelated work)
- Appropriate abstraction levels and separation of concerns

### 2. Functionality & Correctness (Critical)
- Code correctly implements the intended business logic
- Handling of edge cases, error conditions, and unexpected inputs
- Detection of logical flaws, race conditions, or concurrency issues
- State management and data flow correctness
- Idempotency where appropriate

### 3. Security (Non-Negotiable)
- All user input validated, sanitized, and escaped (XSS, SQLi prevention)
- Authentication and authorization checks on protected resources
- No hardcoded secrets, API keys, or credentials
- Data exposure in logs, error messages, or API responses
- CORS, CSP, and other security headers where applicable
- Cryptographic implementations use standard libraries

### 4. Maintainability & Readability (High Priority)
- Code clarity for future developers
- Naming conventions descriptive and consistent
- Control flow complexity and nesting depth reasonable
- Comments explain "why" (intent/trade-offs) not "what" (mechanics)
- Error messages aid debugging
- Code duplication candidates for refactoring

### 5. Testing Strategy & Robustness (High Priority)
- Test coverage appropriate to code complexity and criticality
- Tests cover failure modes, security edge cases, and error paths
- Test maintainability and clarity
- Appropriate test isolation and mock usage
- Missing integration or end-to-end tests for critical paths

### 6. Performance & Scalability (Important)
**Backend:**
- N+1 queries detection and prevention
- Missing indexes or inefficient algorithms
- Database query optimization

**Frontend:**
- Bundle size impact
- Rendering performance
- Core Web Vitals

**General:**
- Caching strategies and invalidation logic
- Memory leaks or resource exhaustion
- API design consistency and pagination

### 7. Dependencies & Documentation (Important)
- Necessity of new third-party dependencies
- Dependency security, maintenance status, and license compatibility
- API documentation updates for contract changes
- Configuration or deployment documentation updates

## Triage Matrix

Categorize findings to help author prioritize:

- **[Critical/Blocker]**: Must fix before merge (security vulnerability, architectural regression)
- **[Improvement]**: Strong recommendation (better implementation, best practices)
- **[Nit]**: Minor polish (optional, style, non-critical improvements)

## Communication Principles

- **Actionable**: Provide specific, actionable suggestions
- **Explain the Why**: Ground suggestions in engineering principles
- **Constructive**: Maintain objectivity and assume good intent
- **Grounded**: Base feedback on technical facts, not opinions

## Output Report Structure

```markdown
### Code Review Summary
[Overall assessment and high-level observations]

### Findings

#### Critical Issues
- [File:Line]: [Issue description and why critical]

#### Suggested Improvements
- [File:Line]: [Suggestion and rationale]

#### Nitpicks
- Nit: [File:Line]: [Minor detail]
```
