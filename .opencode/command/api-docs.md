---
description: "Create OpenAPI/Swagger API documentation with interactive examples"
agent: api-documenter
---

You are creating comprehensive API documentation following OpenAPI best practices.

**Request:** $ARGUMENTS

**Context Loaded:**
@.opencode/context/documentation/api-documentation-standards.md
@.opencode/context/documentation/documentation-templates.md
@.opencode/context/core/essential-patterns.md

**Your Workflow:**

1. **ANALYZE** API structure:
   - Inventory all endpoints and operations
   - Review authentication methods
   - Analyze request/response schemas
   - Identify common patterns
   - Map user journeys

2. **CREATE** OpenAPI specification:
   - Write complete OpenAPI 3.1 spec
   - Document all parameters and responses
   - Include authentication details
   - Add comprehensive error codes
   - Provide realistic examples
   - Create reusable components/schemas

3. **GENERATE** supporting documentation:
   - Quick start guide (< 5 min to first call)
   - Authentication guide with examples
   - Code examples in multiple languages:
     - JavaScript/TypeScript (fetch, axios)
     - Python (requests)
     - cURL (for testing)
     - Go (net/http)
   - Integration tutorials
   - Error reference guide
   - Best practices (rate limits, retries)

4. **VALIDATE** completeness:
   - 100% endpoint coverage
   - All schemas documented
   - Examples are runnable
   - Error handling shown
   - Authentication flows clear

**Output Format:**
- OpenAPI/Swagger YAML or JSON specification
- Interactive documentation portal content
- Integration guide with code examples
- Troubleshooting guide

Execute API documentation creation now.
