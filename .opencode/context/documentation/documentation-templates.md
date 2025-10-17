# Documentation Templates

Reusable templates for common documentation patterns.

## Language Guidelines

When using these templates, replace subjective adjectives with objective facts:
- Instead of "powerful features" → list specific features (OAuth 2.0 support, webhook subscriptions)
- Instead of "comprehensive guide" → specify what it covers (5 sections, 15 examples)
- Instead of "production-ready" → describe specific qualities (tested, error-handled, validated)
- Instead of "simple and elegant" → provide concrete details (3-step process, 150 lines of code)

See [Objective Language Standards](./writing-standards.md#objective-language) for complete guidance.

## Quick Start Template

```markdown
# Quick Start Guide

Get started with [Product] in less than 5 minutes.

## Prerequisites

Before you begin, ensure you have:
- [Requirement 1] (version X.X or later)
- [Requirement 2]
- [Requirement 3]

## Installation

### Using npm
\```bash
npm install @company/package
\```

### Using yarn
\```bash
yarn add @company/package
\```

## Basic Setup

1. **Initialize the client**
   \```javascript
   const { Client } = require('@company/package');
   
   const client = new Client({
     apiKey: process.env.API_KEY
   });
   \```

2. **Make your first request**
   \```javascript
   const result = await client.getData();
   console.log(result);
   \```

3. **Handle errors**
   \```javascript
   try {
     const result = await client.getData();
     console.log('Success:', result);
   } catch (error) {
     console.error('Error:', error.message);
   }
   \```

## Expected Output

\```json
{
  "success": true,
  "data": {...}
}
\```

## Next Steps

- [Complete API Reference](./api-reference.md)
- [Authentication Guide](./authentication.md)
- [Examples and Tutorials](./examples.md)
- [Troubleshooting](./troubleshooting.md)

## Getting Help

- [Documentation](https://docs.example.com)
- [Discord Community](https://discord.gg/...)
- [GitHub Issues](https://github.com/org/repo/issues)
```

## API Reference Template

```markdown
# API Reference: functionName()

Brief description of what this function does.

## Syntax

\```typescript
functionName(param1, param2, options?)
\```

## Parameters

### param1
- **Type**: `string`
- **Required**: Yes
- **Description**: Description of what this parameter does
- **Example**: `"example-value"`

### param2
- **Type**: `number`
- **Required**: Yes
- **Description**: Description of what this parameter does
- **Constraints**: Must be between 1 and 100
- **Default**: None

### options
- **Type**: `OptionsObject`
- **Required**: No
- **Description**: Optional configuration object

#### OptionsObject Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `timeout` | `number` | No | `5000` | Request timeout in milliseconds |
| `retries` | `number` | No | `3` | Number of retry attempts |
| `cache` | `boolean` | No | `true` | Enable response caching |

## Return Value

Returns a `Promise<ResultType>`

### ResultType

\```typescript
interface ResultType {
  success: boolean;
  data: DataObject;
  metadata: {
    timestamp: string;
    requestId: string;
  };
}
\```

## Errors

This function may throw the following errors:

### ValidationError
Thrown when input parameters fail validation.

**Properties**:
- `message`: Description of validation failure
- `field`: Name of invalid field
- `code`: `"VALIDATION_ERROR"`

### AuthenticationError
Thrown when authentication fails.

**Properties**:
- `message`: "Invalid API key"
- `code`: `"AUTH_ERROR"`

### RateLimitError
Thrown when rate limit is exceeded.

**Properties**:
- `message`: "Rate limit exceeded"
- `retryAfter`: Seconds until rate limit resets
- `code`: `"RATE_LIMIT_ERROR"`

## Examples

### Basic Usage
\```javascript
const result = await functionName('param1-value', 42);
console.log(result.data);
\```

### With Options
\```javascript
const result = await functionName('param1-value', 42, {
  timeout: 10000,
  retries: 5,
  cache: false
});
\```

### Error Handling
\```javascript
try {
  const result = await functionName('param1-value', 42);
  console.log('Success:', result.data);
} catch (error) {
  if (error.code === 'VALIDATION_ERROR') {
    console.error('Invalid input:', error.field);
  } else if (error.code === 'RATE_LIMIT_ERROR') {
    console.error('Rate limited. Retry after:', error.retryAfter);
  } else {
    console.error('Unexpected error:', error.message);
  }
}
\```

### Advanced Usage
\```javascript
// Example showing complex real-world usage
const processItems = async (items) => {
  for (const item of items) {
    try {
      const result = await functionName(item.param1, item.param2, {
        timeout: item.priority === 'high' ? 15000 : 5000,
        retries: item.priority === 'high' ? 5 : 3
      });
      
      console.log(`Processed ${item.id}:`, result.data);
    } catch (error) {
      console.error(`Failed to process ${item.id}:`, error.message);
      // Continue with next item
    }
  }
};
\```

## See Also

- [Related Function 1](./related-function-1.md)
- [Related Function 2](./related-function-2.md)
- [Authentication Guide](./authentication.md)
- [Best Practices](./best-practices.md)
```

## Tutorial Template

```markdown
# Tutorial: Build a [Feature Name]

Learn how to build [feature] from scratch in this step-by-step tutorial.

## What You'll Build

By the end of this tutorial, you'll have:
- [Outcome 1]
- [Outcome 2]
- [Outcome 3]

**Live Demo**: [Link to working example]  
**Source Code**: [Link to GitHub repository]

## Prerequisites

- [Skill/knowledge required]
- [Software requirement] (version X.X or later)
- [Time estimate]: Approximately 30 minutes

## What You'll Learn

- How to [skill 1]
- Understanding [concept]
- Best practices for [topic]

---

## Step 1: Set Up Your Project

### Create Project Structure

\```bash
mkdir my-project
cd my-project
npm init -y
npm install dependencies
\```

### Create Files

\```bash
touch index.js
touch config.js
\```

**Explanation**: We're setting up the basic project structure. The \`index.js\` file will contain our main application logic, and \`config.js\` will hold configuration.

---

## Step 2: [Next Major Step]

### [Sub-step]

\```javascript
// Code for this step
const example = () => {
  // Implementation
};
\```

**What's happening here?**
Detailed explanation of the code, why we're doing it this way, and what to watch out for.

### Test Your Progress

\```bash
npm start
\```

**Expected output**:
\```
Server running on port 3000
\```

---

## Step 3: [Continue with more steps]

[Continue pattern...]

---

## Troubleshooting

### Issue: Error message appears

**Symptom**: [What user sees]

**Cause**: [Why it happens]

**Solution**:
1. Step one to fix
2. Step two to fix

---

## Next Steps

Now that you've built [feature], you can:
- [Enhancement idea 1]
- [Enhancement idea 2]
- [Related tutorial]

## Further Reading

- [Advanced topic 1]
- [Advanced topic 2]
- [Best practices guide]
```

## Troubleshooting Template

```markdown
# Troubleshooting Guide

Common problems and solutions.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Authentication Errors](#authentication-errors)
- [Runtime Errors](#runtime-errors)
- [Performance Issues](#performance-issues)

---

## Installation Issues

### Problem: Package installation fails

**Symptoms**:
\```
npm ERR! code ENOENT
npm ERR! syscall open
\```

**Possible Causes**:
1. Network connectivity issues
2. Npm registry unavailable
3. Corrupted npm cache

**Solutions**:

**Solution 1**: Clear npm cache
\```bash
npm cache clean --force
npm install
\```

**Solution 2**: Use different registry
\```bash
npm config set registry https://registry.npmjs.org/
npm install
\```

**Solution 3**: Check network connectivity
\```bash
ping registry.npmjs.org
\```

**Still not working?** [Contact support](#getting-help)

---

### Problem: Version conflict errors

**Symptoms**:
\```
npm ERR! peer dependency conflict
\```

**Cause**: Incompatible dependency versions

**Solution**:
\```bash
# Option 1: Use --legacy-peer-deps
npm install --legacy-peer-deps

# Option 2: Update dependencies
npm update

# Option 3: Clean install
rm -rf node_modules package-lock.json
npm install
\```

---

## Authentication Errors

### Problem: "Invalid API key" error

**Error Message**:
\```json
{
  "error": "authentication_failed",
  "message": "Invalid API key"
}
\```

**Checklist**:
- [ ] API key is correctly copied (no extra spaces)
- [ ] API key is not expired
- [ ] API key has correct permissions
- [ ] Environment variable is set correctly

**Verification Steps**:

1. **Check environment variable**:
   \```bash
   echo $API_KEY
   \```

2. **Verify API key format**:
   API keys should start with \`sk_\` and be 32 characters long.

3. **Test with curl**:
   \```bash
   curl -H "Authorization: Bearer $API_KEY" \
     https://api.example.com/v1/verify
   \```

**Common Mistakes**:
- ❌ Using test key in production
- ❌ Exposing key in client-side code
- ❌ Key has expired

**Solution**: [Generate new API key](https://dashboard.example.com/keys)

---

## Runtime Errors

### Problem: "Connection timeout" error

**Symptoms**:
- Requests hang for 30+ seconds
- Eventually receive timeout error
- Intermittent failures

**Diagnostic Steps**:

1. **Check API status**:
   Visit [https://status.example.com](https://status.example.com)

2. **Test connectivity**:
   \```bash
   curl -v https://api.example.com/health
   \```

3. **Check firewall settings**:
   Ensure port 443 (HTTPS) is open

4. **Verify DNS resolution**:
   \```bash
   nslookup api.example.com
   \```

**Solutions**:

**Solution 1**: Increase timeout
\```javascript
const client = new Client({
  timeout: 30000 // 30 seconds
});
\```

**Solution 2**: Implement retry logic
\```javascript
const result = await client.request({
  retries: 3,
  retryDelay: 1000
});
\```

**Solution 3**: Use exponential backoff
\```javascript
const backoff = async (fn, maxRetries = 5) => {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await new Promise(r => setTimeout(r, Math.pow(2, i) * 1000));
    }
  }
};
\```

---

## Performance Issues

### Problem: Slow response times

**Symptoms**:
- API responses take > 2 seconds
- Application feels sluggish
- Timeout errors under load

**Diagnostic Checklist**:
- [ ] Check request size (should be < 1MB)
- [ ] Verify pagination is used for large datasets
- [ ] Confirm caching is enabled
- [ ] Check for N+1 query problems

**Optimization Strategies**:

1. **Enable caching**:
   \```javascript
   const client = new Client({
     cache: true,
     cacheTTL: 300 // 5 minutes
   });
   \```

2. **Use pagination**:
   \```javascript
   const results = await client.list({
     limit: 100,
     cursor: 'next-page-token'
   });
   \```

3. **Request only needed fields**:
   \```javascript
   const user = await client.getUser({
     fields: ['id', 'name', 'email'] // Don't fetch everything
   });
   \```

4. **Batch requests**:
   \```javascript
   const results = await client.batch([
     { method: 'getUser', id: 1 },
     { method: 'getUser', id: 2 },
     { method: 'getUser', id: 3 }
   ]);
   \```

---

## Getting Help

If you're still experiencing issues:

1. **Search existing issues**: [GitHub Issues](https://github.com/org/repo/issues)
2. **Check API status**: [status.example.com](https://status.example.com)
3. **Join Discord**: [discord.gg/example](https://discord.gg/example)
4. **Contact support**: support@example.com

When reporting issues, please include:
- Error message (full stack trace)
- Steps to reproduce
- Environment (OS, Node version, package version)
- Request ID (if available)
```

## Migration Guide Template

```markdown
# Migration Guide: v1.x to v2.0

This guide will help you migrate from v1.x to v2.0.

## Overview

**Migration Time**: ~30 minutes for small projects  
**Breaking Changes**: 5 major changes  
**New Features**: OAuth 2.0, GraphQL endpoint, webhooks  
**Deprecations**: API keys (removed in v3.0)

## Before You Begin

1. **Backup your code**: Create a git branch
   \```bash
   git checkout -b migrate-to-v2
   \```

2. **Review your dependencies**:
   \```bash
   npm list @company/sdk
   \```

3. **Read the changelog**: [v2.0.0 Release Notes](./changelog.md#v200)

## Breaking Changes

### 1. Authentication Method Changed

**v1.x** (API Keys):
\```javascript
const client = new Client({ apiKey: 'sk_...' });
\```

**v2.0** (JWT Tokens):
\```javascript
const client = new Client({ 
  auth: {
    token: 'eyJ...'
  }
});
\```

**Migration Steps**:
1. Generate JWT token from [dashboard](https://dashboard.example.com)
2. Replace \`apiKey\` with \`auth.token\`
3. Update environment variables

**Timeline**: API keys deprecated, removed in v3.0 (June 2025)

---

### 2. Response Format Changed

**v1.x**:
\```json
{
  "data": [...],
  "count": 10
}
\```

**v2.0**:
\```json
{
  "data": [...],
  "pagination": {
    "total": 100,
    "limit": 10,
    "cursor": "next_token"
  }
}
\```

**Migration Steps**:
\```javascript
// Update code that accesses count
-const total = response.count;
+const total = response.pagination.total;
\```

---

[Continue with remaining breaking changes...]

## Step-by-Step Migration

### Step 1: Update Package

\```bash
npm install @company/sdk@^2.0.0
\```

### Step 2: Update Authentication

[Detailed steps...]

### Step 3: Update Response Handling

[Detailed steps...]

### Step 4: Test Your Application

\```bash
npm test
\```

## Automated Migration Tool

We provide a codemod to automate most changes:

\```bash
npx @company/codemod v1-to-v2 src/
\```

**What it changes**:
- ✅ Authentication method
- ✅ Response format handling
- ✅ Import statements
- ⚠️  Manual review required for custom implementations

## Rollback Plan

If you need to rollback:

\```bash
git checkout main
npm install @company/sdk@^1.0.0
\```

## Getting Help

- [Migration FAQ](./migration-faq.md)
- [Discord #migration](https://discord.gg/example)
- [v2.0 Examples](./examples/v2.0/)
```

Use these templates as starting points and customize them for your specific documentation needs.
