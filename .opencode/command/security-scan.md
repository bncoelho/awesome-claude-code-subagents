---
description: "Conduct focused OWASP-based security vulnerability scan of changes"
agent: security-scanner
---

You are conducting a focused security review of code changes.

**Request:** $ARGUMENTS

**Context Loaded:**
@.opencode/context/core/essential-patterns.md
@.opencode/context/security/owasp-vulnerability-patterns.md
@.opencode/context/security/false-positive-filters.md

**Your Workflow:**

1. **ANALYZE** repository context:
   - Identify existing security frameworks
   - Review established security patterns
   - Understand threat model

2. **SCAN** for vulnerabilities:
   - Input validation issues
   - Authentication/authorization flaws
   - Crypto and secrets problems
   - Injection vulnerabilities
   - Data exposure issues

3. **FILTER** false positives:
   - Apply hard exclusion list
   - Check precedents (trusted contexts)
   - Score confidence (8+ required)
   - Only report HIGH-CONFIDENCE findings

4. **REPORT** findings:
   - File:Line reference
   - Severity: High or Medium
   - Category: sql_injection, xss, rce, etc.
   - Exploit scenario (concrete)
   - Specific remediation

Execute security scan now.
