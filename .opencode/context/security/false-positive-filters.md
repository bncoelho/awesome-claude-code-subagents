# False-Positive Filtering for Security Reviews

Maximize signal-to-noise ratio by intelligently filtering findings.

## Hard Exclusions (Automatically Exclude)

1. **DOS/Resource Exhaustion**: Do not report denial-of-service or resource exhaustion vulnerabilities
2. **Disk-Based Secrets**: Do not report secrets stored on disk if otherwise secured
3. **Rate Limiting**: Do not report rate limiting or service overload concerns
4. **Memory/CPU**: Do not report memory consumption or CPU exhaustion issues
5. **Non-Critical Validation**: Do not report input validation concerns without proven security impact
6. **GitHub Actions**: Do not report input sanitization in workflows unless clearly triggerable via untrusted input
7. **Lack of Hardening**: Code isn't expected to implement all security best practices
8. **Theoretical Race Conditions**: Only report if concretely problematic, not theoretical timing attacks
9. **Outdated Libraries**: Vulnerabilities in third-party libraries managed separately
10. **Memory Safety**: Memory safety issues (buffer overflow, use-after-free) impossible in safe languages
11. **Test Files**: Do not report findings in files used only for testing
12. **Log Spoofing**: Outputting un-sanitized user input to logs is not a vulnerability
13. **SSRF (Path-Only)**: SSRF concerns only if controlling host/protocol, not just path
14. **AI Prompts**: Including user-controlled content in AI prompts not a vulnerability
15. **Regex Injection**: Injecting untrusted content into regex not a vulnerability
16. **Regex DOS**: Do not report regex denial-of-service
17. **Documentation**: Do not report findings in markdown/documentation files
18. **Audit Logs**: Lack of audit logs not a vulnerability

## Trusted Contexts (Safe Patterns)

1. **Environment Variables**: Trusted in secure environments, not attacker-controlled
2. **UUIDs**: Can be assumed unguessable, no validation needed
3. **React/Angular XSS**: Generally XSS-safe unless using dangerouslySetInnerHTML/bypassSecurityTrustHtml
4. **Client-Side Permission Checks**: Not required, server-side validation enforced
5. **Shell Script Injection**: Not exploitable if no untrusted input
6. **Logging URLs**: URLs in logs are safe (only flag if logging secrets/credentials)
7. **Generic Error Messages**: Returning generic errors is not a vulnerability

## Confidence Scoring

Assign confidence scores from 1-10:

- **1-3**: Low confidence → Likely false positive → EXCLUDE
- **4-6**: Medium confidence → Needs investigation → EXCLUDE for security reviews
- **7-7**: Borderline → Only report if very specific attack path → EXCLUDE
- **8-10**: High confidence → Likely true vulnerability → INCLUDE

**Requirement**: Only report findings with ≥8 confidence score

## High-Confidence Signals

Look for these indicators:

- Clear, specific attack path identified
- Exploit scenario demonstrated or obvious
- Real-world vulnerability pattern matched
- High exploitation probability
- Significant impact potential
- Tested or verified exploitation path

## Low-Confidence Red Flags

Exclude if showing these indicators:

- Theoretical concern lacking concrete attack path
- Requires unlikely/impossible preconditions
- Unproven exploitation scenario
- Defense-in-depth issue only
- Low probability of exploitation
- Speculative vulnerability

## Severity Guidelines

Only report HIGH and MEDIUM findings (exclude LOW):

- **HIGH**: Directly exploitable → RCE, data breach, authentication bypass
- **MEDIUM**: Specific conditions required → Significant impact if exploited
- **LOW**: Defense-in-depth → Lower exploitation probability

## Signal Quality Criteria

For each remaining finding, verify:

1. **Concrete**: Is there an exploitable vulnerability with clear attack path?
2. **Real Risk**: Real security risk vs. theoretical best practice?
3. **Specific**: Specific code locations and reproduction steps available?
4. **Actionable**: Would security team act on this finding?

## Output Requirements

Each reported finding must include:

- **File:Line**: Specific location
- **Severity**: High or Medium only
- **Category**: sql_injection, xss, rce, auth_bypass, secrets, crypto, injection, data_exposure
- **Confidence Score**: 8-10 only
- **Description**: Detailed technical description
- **Exploit Scenario**: Concrete attack path with specific steps
- **Recommendation**: Specific fix with code example if possible

## Example: Filtering Process

**Raw Finding**: "Missing rate limiting on API endpoint"
- ❌ Hard exclusion #3 (rate limiting concern)
- **Result**: EXCLUDE

**Raw Finding**: "User input passed directly to eval() in dashboard configuration"
- ✅ Input comes from user
- ✅ eval() executes code
- ✅ Clear RCE path
- ✅ High impact
- Confidence: 9/10
- **Result**: INCLUDE as HIGH severity

**Raw Finding**: "Potential race condition in cache invalidation"
- ❌ Hard exclusion #8 (theoretical race condition without concrete impact)
- ❌ No specific exploit scenario
- **Result**: EXCLUDE
