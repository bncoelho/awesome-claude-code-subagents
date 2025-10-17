# OpenCode Agents Library (Pilot)

Production-ready OpenCode agent configurations from the Awesome Claude Code Subagents repository.

## 📊 Overview

**Pilot Status**: ✅ Complete (8/119 agents)

This directory contains OpenCode-compatible agent configurations, context files, and slash commands for a comprehensive AI-native development workflow.

### Quick Stats
- **Total Agents**: 8 (pilot)
- **Agent Types**: 5 primary, 3 subagent
- **Context Files**: 6 focused knowledge bases
- **Slash Commands**: 3 workflow shortcuts
- **Total Lines**: ~1,900+ production documentation

---

## 🎯 Model Alias System

All agents use **semantic model aliases** for centralized model management. Instead of hardcoding specific versions, agents use generic model names like `claude-sonnet` that automatically resolve to the latest available version:

```json
{
  "model": "claude-sonnet",
  "agent": {
    "fullstack-developer": {
      "model": "claude-sonnet",
      "temperature": 0.2
    },
    "pragmatic-code-reviewer": {
      "model": "claude-sonnet",
      "temperature": 0.1
    }
  }
}
```

**Benefits:**
- ✅ Always use latest models (generic names auto-update)
- ✅ Centralized control (update once, all agents benefit)
- ✅ Simple & clean (no version chasing)
- ✅ Cost optimization (easily adjust per environment)
- ✅ Easy scaling (classification guide provided)

See **[MODEL-ALIASES.md](./MODEL-ALIASES.md)** for detailed documentation.

---

## 🎯 Pilot Agents (Ready to Use)

### Primary Agents (User-Facing)
These agents can be accessed directly and handle complete workflows:

| Agent | Purpose | Mode |
|-------|---------|------|
| **fullstack-developer** | End-to-end feature development across frontend, backend, database | Primary |
| **backend-developer** | Scalable API development with performance and security focus | Primary |
| **frontend-developer** | Modern frontend development with accessibility and responsive design | Primary |

### Subagents (Specialized)
These agents are invoked by other agents or via @ mentions for specialized tasks:

| Agent | Purpose | Mode |
|-------|---------|------|
| **pragmatic-code-reviewer** | Hierarchical code review balancing quality with velocity | Subagent |
| **security-scanner** | OWASP-based vulnerability scanning with false-positive filtering | Subagent |
| **design-reviewer** | UI/UX review with WCAG accessibility validation | Subagent |
| **code-reviewer** | Broad code quality and security review across languages | Subagent |
| **api-designer** | REST and GraphQL API architecture and documentation | Subagent |

---

## 🎮 Slash Commands (Try These First)

Quick shortcuts for common workflows:

```bash
# Pragmatic code review of current branch
/review "Review my backend changes for quality and security"

# Security vulnerability scanning
/security-scan "Check for security issues in my new auth implementation"

# Design and UX review
/design-review "Review the new user profile page for accessibility and responsiveness"
```

---

## 📚 Context Files (Knowledge Base)

Shared knowledge base automatically injected into agents:

### Core Patterns
- **essential-patterns.md** - Error handling, validation, logging, security, type safety

### Quality & Review
- **pragmatic-review-framework.md** - 7-level hierarchical review methodology
- **design-review-standards.md** - Visual design, UX, accessibility, responsive design

### Security
- **owasp-vulnerability-patterns.md** - OWASP Top 10 vulnerability patterns and detection
- **false-positive-filters.md** - Intelligent filtering to minimize noise (18 hard exclusions, confidence scoring)

### Accessibility
- **wcag-checklist.md** - WCAG 2.1 AA compliance checklist and validation steps

---

## 🚀 Getting Started

### 1. List Available Agents
```bash
opencode agent list
```

### 2. Use a Primary Agent Directly
```bash
# Start a full-stack feature implementation
opencode --agent fullstack-developer

# Start backend API development
opencode --agent backend-developer
```

### 3. Use Slash Commands
```bash
# In an OpenCode session, run a command
/review "my-branch"
/security-scan "auth-system"
/design-review "components/Button.tsx"
```

### 4. Mention Subagents
```bash
# In an OpenCode session, @ mention a subagent
@pragmatic-code-reviewer please review this architecture change

@security-scanner what are the vulnerability risks here?

@design-reviewer is this accessible?
```

---

## 🔄 Agent Workflows

### Code Review Workflow
```
Your Code → /review → pragmatic-code-reviewer
                    → hierarchical analysis (7 levels)
                    → triage matrix [Critical/Improvement/Nit]
                    → structured report
```

### Security Review Workflow
```
Your Code → /security-scan → security-scanner
                           → context analysis
                           → vulnerability assessment
                           → false-positive filtering (confidence ≥8)
                           → high-confidence findings only
```

### Design Review Workflow
```
Your UI → /design-review → design-reviewer
                         → 7-phase review
                         → WCAG testing
                         → responsive validation
                         → structured findings
```

---

## 💡 Key Features

### Pragmatic Quality Framework
Agents use a battle-tested quality framework that:
- Prioritizes net positive improvement over perfection
- Focuses on substance (architecture, security, logic)
- Grounds feedback in engineering principles (SOLID, DRY, KISS)
- Uses consistent triage matrix [Critical/Improvement/Nit]

### Intelligent Security Scanning
Security scanner includes:
- OWASP Top 10 comprehensive coverage
- Sub-task strategy for multi-phase analysis
- False-positive filtering with 18 hard exclusion categories
- Confidence scoring (requires ≥8/10 to report)
- Only high-impact, concrete exploits reported

### Accessible Design Review
Design reviewer ensures:
- WCAG 2.1 AA compliance
- Keyboard navigation testing
- Responsive design validation (desktop/tablet/mobile)
- Live environment testing capability
- Problems over prescriptions communication style

---

## 🔐 Permissions & Safety

Agents are configured with granular permissions:

```yaml
# Example: Backend Developer
permissions:
  bash:
    "rm -rf *": "deny"              # Prevent deletion
    "git push --force": "ask"       # Require approval
    "npm publish": "ask"            # Require approval
  edit:
    "**/*.env*": "deny"             # Protect secrets
    "**/*.secret": "deny"           # Protect secrets
    "**/node_modules/**": "deny"    # Protect dependencies
```

---

## 📖 Documentation

### Agent Files
- `.opencode/agent/` - Primary agents
- `.opencode/agent/subagents/` - Specialized subagents
- Each agent includes detailed workflow and communication rules

### Context Files
- `.opencode/context/core/` - Core patterns
- `.opencode/context/quality/` - Review frameworks
- `.opencode/context/security/` - Security guidance
- `.opencode/context/accessibility/` - Accessibility standards

### Commands
- `.opencode/command/` - Slash command definitions
- Each command loads relevant context automatically

---

## 🎓 Conversion Information

**Original Sources**:
1. **awesome-claude-code-subagents** - 5 agents converted (fullstack, backend, frontend, api-designer, code-reviewer)
2. **claude-code-workflows** - 3 new agents created (pragmatic-code-reviewer, security-scanner, design-reviewer)

**Full Plan**: See `.opencode/PILOT-SUMMARY.md` for detailed pilot information

---

## 🚀 Next Steps (Post-Pilot)

1. **Test in Production**: Use pilot agents in real workflows
2. **Gather Feedback**: Report issues and improvements
3. **Scale Conversion**: Apply patterns to remaining 111+ agents
4. **Automation**: Build conversion scripts for batch processing
5. **Integration**: GitHub Actions workflows for automated reviews

---

## 📋 Pilot Structure

```
.opencode/
├── agent/
│   ├── fullstack-developer.md
│   ├── backend-developer.md
│   ├── frontend-developer.md
│   └── subagents/
│       ├── pragmatic-code-reviewer.md (NEW)
│       ├── security-scanner.md (NEW)
│       ├── design-reviewer.md (NEW)
│       ├── code-reviewer.md
│       └── api-designer.md
├── command/
│   ├── review.md (NEW)
│   ├── security-scan.md (NEW)
│   └── design-review.md (NEW)
├── context/
│   ├── core/essential-patterns.md (NEW)
│   ├── quality/
│   │   ├── pragmatic-review-framework.md (NEW)
│   │   └── design-review-standards.md (NEW)
│   ├── security/
│   │   ├── owasp-vulnerability-patterns.md (NEW)
│   │   └── false-positive-filters.md (NEW)
│   └── accessibility/wcag-checklist.md (NEW)
└── README.md (this file)
```

---

## 🎯 Success Metrics (Pilot)

- ✅ 8 agents successfully converted/created
- ✅ 6 focused context files created (~300 lines each)
- ✅ 3 slash commands for common workflows
- ✅ All agents properly configured with permissions
- ✅ Pragmatic quality framework successfully integrated
- ✅ Security scanning with false-positive filtering implemented
- ✅ Design review with accessibility focus completed

---

## 📞 Support

For issues or questions:
1. Check `.opencode/PILOT-SUMMARY.md` for detailed information
2. Review agent descriptions in individual `.md` files
3. Test with `/review`, `/security-scan`, or `/design-review` commands
4. Report feedback for full-scale conversion planning

---

**Pilot Version**: 1.0  
**Created**: Oct 17, 2024  
**Status**: Ready for testing and feedback  
**Next Phase**: Full 119+ agent conversion  
