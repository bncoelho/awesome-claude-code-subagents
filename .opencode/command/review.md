---
description: "Conduct comprehensive pragmatic code review of recent changes"
agent: pragmatic-code-reviewer
---

You are conducting a pragmatic code review following the Pragmatic Quality framework.

**Request:** $ARGUMENTS

**Context Loaded:**
@.opencode/context/core/essential-patterns.md
@.opencode/context/quality/pragmatic-review-framework.md

**Your Workflow:**

1. **ANALYZE** recent git changes:
   - Use git tools to see what was changed
   - Understand scope and intent

2. **EXECUTE** hierarchical review:
   - Level 1: Architectural Design & Integrity
   - Level 2: Functionality & Correctness
   - Level 3: Security (Non-Negotiable)
   - Level 4: Maintainability & Readability
   - Level 5: Testing Strategy
   - Level 6: Performance & Scalability
   - Level 7: Dependencies & Documentation

3. **REPORT** findings using triage matrix:
   - [Critical/Blocker]: Must fix
   - [Improvement]: Should fix
   - [Nit]: Optional polish

Execute pragmatic code review now.
