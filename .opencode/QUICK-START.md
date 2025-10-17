# OpenCode Agent Pilot - Quick Start Guide

## 🚀 Start Using Agents Right Now

### Option 1: Use Slash Commands (Easiest)

```bash
# In an OpenCode session:
/review "my-branch"
/security-scan "auth-feature"  
/design-review "new-component"
```

### Option 2: Switch to an Agent Directly

```bash
# Switch agents with Tab or your configured keybind
→ fullstack-developer (for complete features)
→ backend-developer (for APIs)
→ frontend-developer (for UI)
```

### Option 3: @ Mention a Subagent

```bash
# In any conversation:
@pragmatic-code-reviewer review this architecture change
@security-scanner what vulnerabilities do you see?
@design-reviewer is this accessible?
```

---

## 📚 What Each Agent Does

### Primary Agents (Main Development)

| Agent | Use For | Command |
|-------|---------|---------|
| **fullstack-developer** | Complete features (DB→API→UI) | `/switch fullstack-developer` |
| **backend-developer** | APIs, services, databases | `/switch backend-developer` |
| **frontend-developer** | UI components, responsive design | `/switch frontend-developer` |

### Subagents (Specialized)

| Agent | Use For | Mention |
|-------|---------|--------|
| **pragmatic-code-reviewer** | Code quality & best practices | `@pragmatic-code-reviewer` |
| **security-scanner** | Vulnerability detection | `@security-scanner` |
| **design-reviewer** | UI/UX & accessibility | `@design-reviewer` |
| **code-reviewer** | General code review | `@code-reviewer` |
| **api-designer** | API architecture | `@api-designer` |

---

## 🎯 Common Workflows

### Code Review Workflow
```
Your Code Change
    ↓
/review "my changes"
    ↓
pragmatic-code-reviewer
    ↓
Hierarchical analysis (7 levels)
    ↓
Report with [Critical/Improvement/Nit]
```

### Security Review Workflow
```
Your Feature
    ↓
/security-scan "auth system"
    ↓
security-scanner
    ↓
3-phase analysis (context → assess → filter)
    ↓
High-confidence vulnerabilities only
```

### Design Review Workflow
```
Your UI Components
    ↓
/design-review "new component"
    ↓
design-reviewer
    ↓
7-phase review (interaction, responsive, accessibility)
    ↓
Report with [Blocker/High-Priority/Suggestions/Nitpick]
```

---

## 📖 Documentation Files

### Overview
- **README.md** - Full feature documentation
- **PILOT-SUMMARY.md** - Comprehensive pilot details
- **QUICK-START.md** - This file

### Agents (How They Work)
- `.opencode/agent/fullstack-developer.md`
- `.opencode/agent/backend-developer.md`
- `.opencode/agent/frontend-developer.md`
- `.opencode/agent/subagents/pragmatic-code-reviewer.md`
- `.opencode/agent/subagents/security-scanner.md`
- `.opencode/agent/subagents/design-reviewer.md`

### Context (Knowledge Base)
- `.opencode/context/core/essential-patterns.md` - Core coding patterns
- `.opencode/context/quality/pragmatic-review-framework.md` - Review methodology
- `.opencode/context/quality/design-review-standards.md` - Design standards
- `.opencode/context/security/owasp-vulnerability-patterns.md` - Security patterns
- `.opencode/context/security/false-positive-filters.md` - Smart filtering
- `.opencode/context/accessibility/wcag-checklist.md` - A11y standards

### Commands (Shortcuts)
- `.opencode/command/review.md` - `/review` command
- `.opencode/command/security-scan.md` - `/security-scan` command
- `.opencode/command/design-review.md` - `/design-review` command

---

## 💡 Pro Tips

### Tip 1: Planning First
```
fullstack-developer will ask you to approve a plan
before implementing anything. This is intentional!
✅ Say yes to approved plans
```

### Tip 2: Incremental Development
```
All agents implement incrementally (one step at a time)
They validate after each step, so you catch issues early.
```

### Tip 3: Accessibility by Default
```
frontend-developer checks WCAG 2.1 AA compliance
design-reviewer validates keyboard navigation
design-review command tests responsive design
```

### Tip 4: Security First
```
security-scanner uses OWASP Top 10 patterns
Only reports high-confidence findings (≥8/10)
Filters out false positives automatically
```

### Tip 5: Pragmatic Reviews
```
pragmatic-code-reviewer uses: Net Positive > Perfection
Focuses on substance, not style
Philosophy-based feedback grounded in principles
```

---

## 🔄 Example Workflow

### Scenario: Building a User Authentication Feature

**Step 1**: Start with fullstack-developer
```
→ Switch to fullstack-developer
→ "I need to add user authentication with JWT"
→ Approve the proposed plan
→ Watch incremental development
```

**Step 2**: After implementation, review security
```
/security-scan "auth implementation"
→ security-scanner analyzes for vulnerabilities
→ Reports only high-confidence issues
```

**Step 3**: Code review with pragmatic framework
```
/review "my-auth-branch"
→ pragmatic-code-reviewer analyzes in 7 levels
→ Architecture → Correctness → Security → Maintainability → Testing → Performance → Dependencies
```

**Step 4**: If UI component, design review
```
/design-review "LoginComponent.tsx"
→ design-reviewer validates:
  - Interaction & flows
  - Responsiveness (desktop/tablet/mobile)
  - Visual polish
  - WCAG 2.1 AA accessibility
  - Content clarity
```

---

## ⚡ Quick Command Reference

```bash
# Code Review
/review "analyze my changes"

# Security Scanning  
/security-scan "check for vulnerabilities"

# Design Review
/design-review "new UI component"

# Switch Agents
Tab or your configured keybind

# @ Mention Subagents
@pragmatic-code-reviewer @security-scanner @design-reviewer
```

---

## 🛠️ Agent Permissions

All agents are configured with safety controls:

```yaml
✅ fullstack-developer
  Can: Read, Write, Edit code
  Cannot: Delete, Force push, Modify .env files

✅ backend-developer
  Can: Read, Write, Edit code
  Cannot: Delete, Publish to npm, Modify secrets

✅ frontend-developer
  Can: Read, Write, Edit code
  Cannot: Delete, Force push, Touch node_modules

✅ pragmatic-code-reviewer
  Can: Read only
  Cannot: Modify files

✅ security-scanner
  Can: Read, Use git commands
  Cannot: Modify files

✅ design-reviewer
  Can: Read only
  Cannot: Modify files
```

---

## 📞 Troubleshooting

### Agent Not Responding
- Check if agent is enabled: `opencode agent list`
- Verify context files exist in `.opencode/context/`
- Check agent has correct permissions

### Command Not Found
- Verify command exists: `ls .opencode/command/`
- Check syntax: `/review`, `/security-scan`, `/design-review`
- Space after slash required

### Context Not Loading
- Verify files exist at referenced paths
- Check no circular @ references
- Confirm file paths start with `@.opencode/`

### Permissions Denied
- Some commands require approval (git push, npm publish)
- Review permission config in agent file
- Check if bash command matches blocked patterns

---

## 📚 Learn More

- Full details: `.opencode/README.md`
- Pilot summary: `.opencode/PILOT-SUMMARY.md`
- Individual agent docs: `.opencode/agent/*.md`
- Context knowledge base: `.opencode/context/*/`

---

## 🎯 What's Next?

The pilot includes 8 production-ready agents and 6 context files.

**Future versions** will add:
- 111+ more agents (120+ total)
- Language-specific agents (TypeScript, Python, Go, etc.)
- Framework specialists (React, Next.js, Django, etc.)
- Infrastructure agents (Kubernetes, AWS, etc.)
- Specialized agents (Blockchain, FinTech, etc.)

---

## ✨ Enjoy!

You now have a complete OpenCode agent system for:
- ✅ Feature development (full-stack, backend, frontend)
- ✅ Code review (pragmatic quality framework)
- ✅ Security scanning (OWASP-based)
- ✅ Design review (WCAG accessibility)
- ✅ API design (REST and GraphQL)

**Happy coding!** 🚀
