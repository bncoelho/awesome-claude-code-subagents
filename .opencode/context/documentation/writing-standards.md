# Documentation Writing Standards

Best practices and standards for creating clear, effective technical documentation.

## Writing Principles

### Clarity Over Cleverness
**ALWAYS** prioritize clear, simple language:
```markdown
❌ BAD: "Leverage the aforementioned configuration paradigm"
✅ GOOD: "Use the configuration file"

❌ BAD: "Instantiate a novel user entity"
✅ GOOD: "Create a new user"
```

### Active Voice
**USE** active voice for directness:
```markdown
❌ BAD: "The configuration file should be edited"
✅ GOOD: "Edit the configuration file"

❌ BAD: "The API will be called by the client"
✅ GOOD: "The client calls the API"
```

### Present Tense
**WRITE** in present tense:
```markdown
❌ BAD: "The system will validate the input"
✅ GOOD: "The system validates the input"

❌ BAD: "This would create a new user"
✅ GOOD: "This creates a new user"
```

## Structure Standards

### Heading Hierarchy
**MAINTAIN** proper heading structure:
```markdown
# Page Title (H1 - Only one per page)

## Main Section (H2)

### Subsection (H3)

#### Detail Level (H4 - Use sparingly)
```

### Progressive Disclosure
**ORGANIZE** from simple to complex:
```markdown
## Quick Start (simplest path)
- Minimum steps to success
- Working example in < 5 minutes

## Basic Usage (core features)
- Common use cases
- Essential configuration

## Advanced Topics (complex scenarios)
- Edge cases
- Performance tuning

## Reference (complete details)
- All options documented
- Technical specifications
```

### Task-Oriented Structure
**FOCUS** on user goals:
```markdown
# How to Deploy Your Application

## What You'll Accomplish
Deploy your application to production in under 10 minutes.

## Before You Begin
- Node.js 18+ installed
- Git repository configured
- Production environment ready

## Steps
1. Build your application
2. Configure environment variables
3. Deploy to hosting platform
4. Verify deployment success

## Troubleshooting
- [Error: Port already in use](#port-error)
- [Build fails](#build-error)
- [Deployment timeout](#timeout-error)

## Next Steps
- [Configure monitoring](#monitoring)
- [Set up CI/CD](#cicd)
```

## Content Guidelines

### Code Examples
**PROVIDE** complete, runnable examples:
```markdown
❌ BAD: Incomplete snippet
```javascript
api.createUser(data)
```

✅ GOOD: Complete, runnable code
```javascript
const client = new APIClient({
  apiKey: process.env.API_KEY
});

try {
  const user = await client.createUser({
    email: 'user@example.com',
    name: 'John Doe'
  });
  console.log('User created:', user.id);
} catch (error) {
  console.error('Failed to create user:', error.message);
}
```
```

### Error Messages
**WRITE** helpful error documentation:
```markdown
## Error: INVALID_EMAIL

**Message**: "Email format is invalid"

**Cause**: The email address doesn't match the required format (user@domain.com)

**Solution**:
1. Check for typos in the email address
2. Ensure it includes @ and domain
3. Remove any spaces

**Example**:
```javascript
// ❌ Invalid
createUser({ email: 'user@' })

// ✅ Valid
createUser({ email: 'user@example.com' })
```

**Prevention**: Validate email format before submitting
```

### Lists and Tables
**USE** appropriate formatting:
```markdown
// Unordered list for related items
- Feature A
- Feature B
- Feature C

// Ordered list for sequential steps
1. Install dependencies
2. Configure settings
3. Run the application

// Tables for comparisons
| Feature | Free | Pro |
|---------|------|-----|
| Users   | 10   | Unlimited |
| Storage | 1GB  | 100GB |
```

## Language Standards

### Objective Language
**AVOID** subjective adjectives. Use measurable facts and specifications instead.

```markdown
❌ BAD: "comprehensive test suite"
✅ GOOD: "test suite with 18 tests covering 32 assertions"

❌ BAD: "production-grade Ruby script"
✅ GOOD: "Ruby script with error handling and validation"

❌ BAD: "significantly enhanced"
✅ GOOD: "increased from 8 to 11 agents"

❌ BAD: "robust security hardening"
✅ GOOD: "security features including shell escaping and timeout protection"

❌ BAD: "powerful API with excellent features"
✅ GOOD: "API supporting OAuth 2.0, JWT tokens, and webhook subscriptions"

❌ BAD: "simple and elegant solution"
✅ GOOD: "solution uses 3 components with 150 lines of code"
```

**Adjectives to avoid**:
- Quality descriptors: comprehensive, complete, full, total, thorough
- Grade descriptors: production-grade, enterprise-grade, industrial-strength
- Strength descriptors: powerful, robust, solid, strong, sturdy
- Magnitude descriptors: significant, substantial, considerable, major
- Sentiment descriptors: amazing, excellent, great, best, outstanding
- Difficulty descriptors: simple, easy, trivial, complex, difficult
- Other subjective: advanced, innovative, elegant, beautiful, impressive

**Replace with**:
- Specific counts (18 tests, 11 agents, 300 lines)
- Concrete features (supports OAuth 2.0, includes error handling)
- Measurable metrics (1.3s average load time, 95% test coverage)
- Factual descriptions (uses YAML parsing, validates input)
- Quantified scope (covers 5 endpoints, handles 10 error types)

### Terminology Consistency
**MAINTAIN** consistent terms:
```markdown
✅ Choose one term and use consistently:
- "endpoint" (not "API route", "method", "function")
- "authentication" (not "auth", "login", "verification")
- "user" (not "account", "person", "individual")

✅ Define acronyms on first use:
"Use JSON Web Tokens (JWT) for authentication. JWTs are..."

✅ Match product UI exactly:
If button says "Sign In", documentation should say "Sign In" (not "Log In")
```

### Word Choice
**PREFER** simple, common words:
```markdown
❌ AVOID                    ✅ USE
utilize                    use
commence                   start
terminate                  end
implement                  build/create
facilitate                 help/enable
endeavor                   try
subsequent                 next/later
```

### Pronouns
**USE** second person for users:
```markdown
❌ BAD: "Users can configure their settings"
✅ GOOD: "You can configure your settings"

❌ BAD: "One should back up their data"
✅ GOOD: "Back up your data"
```

## Accessibility Standards

### Alt Text for Images
**PROVIDE** descriptive alt text:
```markdown
❌ BAD: ![screenshot](image.png)
❌ BAD: ![Image](image.png)
✅ GOOD: ![Dashboard showing user analytics with line graph](dashboard.png)
```

### Link Text
**USE** descriptive link text:
```markdown
❌ BAD: Click [here](link) for more information
❌ BAD: For more info see [this page](link)
✅ GOOD: See the [authentication guide](link) for details
✅ GOOD: Learn how to [configure webhooks](link)
```

### Color and Contrast
**ENSURE** information isn't conveyed by color alone:
```markdown
❌ BAD: "Click the red button to delete"
✅ GOOD: "Click the 'Delete' button (shown in red)"

❌ BAD: "Green text indicates success"
✅ GOOD: "Success messages are marked with ✅ and shown in green"
```

## Readability

### Sentence Length
**KEEP** sentences short:
```markdown
❌ BAD: (55 words)
"When you're working with the API, you should always make sure that you include 
proper error handling in your code because if you don't, your application might 
crash when the API returns an error, and this could lead to a poor user experience 
and data loss."

✅ GOOD: (29 words across 3 sentences)
"Always include error handling when using the API. Without it, your application 
might crash on API errors. This leads to poor user experience and potential data loss."
```

### Paragraph Length
**LIMIT** to 3-4 sentences or 100 words:
```markdown
✅ GOOD: Short, focused paragraphs
The API uses OAuth 2.0 for authentication. You'll need to register your 
application to get credentials.

Each request requires a Bearer token in the Authorization header. Tokens 
expire after 1 hour.

✅ Add white space between concepts for scanning
```

### Scannable Format
**STRUCTURE** for scanning:
```markdown
✅ Use headings frequently (every 2-3 paragraphs)
✅ Use bulleted/numbered lists
✅ Use bold for important terms (sparingly)
✅ Use code blocks for technical content
✅ Break up text with visuals
✅ Add "callout" boxes for warnings/tips
```

## Quality Checklist

Before publishing, verify:

### Content Quality
- [ ] Technically accurate (reviewed by SME)
- [ ] Complete (covers all features/scenarios)
- [ ] Examples are tested and working
- [ ] No broken links (internal or external)
- [ ] Screenshots are current
- [ ] Terminology is consistent

### Writing Quality
- [ ] Clear and concise language
- [ ] Active voice used throughout
- [ ] Present tense maintained
- [ ] Proper heading hierarchy
- [ ] No jargon or jargon defined
- [ ] Readability score ≥ 60 (Flesch Reading Ease)

### Accessibility
- [ ] All images have alt text
- [ ] Links have descriptive text
- [ ] Color not sole information carrier
- [ ] Proper semantic HTML
- [ ] Keyboard navigation supported

### SEO
- [ ] Title is descriptive and < 60 characters
- [ ] Meta description present and < 160 characters
- [ ] Headings use keywords naturally
- [ ] URL is clean and descriptive

## Common Mistakes to Avoid

### ❌ Assuming Knowledge
```markdown
BAD: "Simply configure the webhook endpoint"
GOOD: "Configure the webhook endpoint (the URL where you'll receive events)"
```

### ❌ Vague Instructions
```markdown
BAD: "Set up your environment"
GOOD: "Install Node.js 18 or later and create a `.env` file"
```

### ❌ Missing Context
```markdown
BAD: "Run `npm start`"
GOOD: "In your project directory, run `npm start` to start the development server"
```

### ❌ Outdated Examples
```markdown
❌ Always update examples when features change
✅ Test examples in CI/CD pipeline
✅ Version documentation with product
```

## Documentation Types

### Quick Start Guide
**Goal**: Success in < 5 minutes
```markdown
# Quick Start

## Install
npm install @company/sdk

## Configure
const client = new Client({ apiKey: 'YOUR_KEY' });

## Make Your First Call
const result = await client.getData();
console.log(result);

## Next Steps
- [Full API Reference](#api)
- [Authentication Guide](#auth)
- [Examples](#examples)
```

### Tutorial
**Goal**: Learn by doing
```markdown
# Building a Todo App

**What you'll build**: A working todo application with full CRUD
**Time required**: 30 minutes
**Prerequisites**: Node.js, basic JavaScript knowledge

## Step 1: Set Up Project
[Detailed instructions...]

## Step 2: Create Todo Model
[Code with explanations...]

## Step 3: Build the API
[Progressive steps...]

## What You Learned
- How to structure an API
- Working with databases
- Error handling patterns

## Next Steps
- Add authentication
- Deploy to production
```

### Reference Documentation
**Goal**: Complete technical details
```markdown
# API Reference: createUser()

## Syntax
```javascript
client.createUser(userData)
```

## Parameters
- `userData` (object, required): User information
  - `email` (string, required): Valid email address
  - `name` (string, required): User's full name
  - `role` (string, optional): User role. Default: "user"

## Returns
Promise<User>: Created user object

## Errors
- `ValidationError`: Invalid input data
- `ConflictError`: Email already exists
- `AuthError`: Invalid API key

## Example
[Complete working example]

## See Also
- [User Management](#users)
- [Authentication](#auth)
```

Always prioritize user success, clarity, and accessibility in all documentation.
