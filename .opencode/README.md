# OpenCode Agents Library (Pilot)

Production-ready OpenCode agent configurations from the Awesome Claude Code Subagents repository.

## 📊 Overview

**Pilot Status**: ✅ Complete (11/119 agents)

This directory contains OpenCode-compatible agent configurations, context files, and slash commands for a comprehensive AI-native development workflow.

### Quick Stats
- **Total Agents**: 11 (pilot)
- **Agent Types**: 3 primary, 8 subagent
- **Context Files**: 8 focused knowledge bases
- **Slash Commands**: 6 workflow shortcuts
- **Total Lines**: ~5,500+ production documentation

---

## 🎯 Model Management System

All agents use **Anthropic's semantic model aliases** for automatic updates and centralized management:

```json
{
  "model": "anthropic/claude-sonnet-4-5",
  "agent": {
    "fullstack-developer": {
      "model": "anthropic/claude-sonnet-4-5",
      "temperature": 0.2
    },
    "pragmatic-code-reviewer": {
      "model": "anthropic/claude-sonnet-4-5",
      "temperature": 0.2
    }
  }
}
```

**Model Aliases** (Auto-updating):
- `anthropic/claude-sonnet-4-5` → Latest Sonnet (best balance)
- `anthropic/claude-opus-4-1` → Latest Opus (complex reasoning)
- `anthropic/claude-haiku-4-5` → Latest Haiku (fast tasks)

**Benefits:**
- ✅ Always use latest models (aliases auto-resolve to newest versions)
- ✅ Centralized control (single config file manages all 8+ agents)
- ✅ No version chasing (aliases update automatically)
- ✅ Automated management (Ruby script for bulk updates)
- ✅ Safety features (dry-run, validation, error handling)

### Model Update Automation

We provide a production-grade Ruby script for managing model versions:

```bash
# Check if models are up-to-date
ruby scripts/update-agents-models.rb --check-latest

# Preview changes before applying
ruby scripts/update-agents-models.rb --dry-run

# Update all agents to latest models
ruby scripts/update-agents-models.rb
```

**Features:**
- ✅ Dry-run mode to preview changes
- ✅ Automatic latest model checking from Anthropic docs
- ✅ Safe YAML parsing with validation
- ✅ Comprehensive error handling
- ✅ Full test suite (18 tests, 100% passing)
- ✅ Security hardened (shell escaping, timeouts)

See **[scripts/README.md](../scripts/README.md)** for detailed documentation.

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
| **api-documenter** | OpenAPI/Swagger specs with interactive portals and examples | Subagent |
| **technical-writer** | Clear, accessible documentation for diverse audiences | Subagent |
| **documentation-engineer** | Documentation systems with automation and testing | Subagent |

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

# Generate OpenAPI/Swagger API documentation
/api-docs "Create OpenAPI spec for the REST API endpoints"

# Set up documentation infrastructure
/doc-setup "Initialize documentation system with Docusaurus"

# Create technical documentation
/document "Write user guide for the authentication flow"
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

### Documentation
- **api-documentation-standards.md** - OpenAPI/Swagger best practices, interactive portals, code generation
- **documentation-infrastructure.md** - Documentation systems, build pipelines, testing, multi-version support

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
/api-docs "src/api/routes"
/doc-setup "docs/"
/document "authentication-guide"
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

### API Documentation Workflow
```
Your API → /api-docs → api-documenter
                     → OpenAPI/Swagger spec generation
                     → endpoint documentation
                     → example requests/responses
                     → interactive portal setup
```

### Documentation Setup Workflow
```
Your Project → /doc-setup → documentation-engineer
                          → infrastructure selection
                          → build pipeline setup
                          → CI/CD integration
                          → testing framework
```

### Technical Writing Workflow
```
Your Feature → /document → technical-writer
                         → audience analysis
                         → content structure
                         → clear explanations
                         → code examples
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

**Model Management**:
- Migrated from generic aliases (`claude-sonnet`) to Anthropic semantic aliases (`anthropic/claude-sonnet-4-5`)
- Implemented automated model management system with Ruby script
- Added comprehensive test suite for validation logic
- Security hardened with safe YAML parsing, shell escaping, and timeout protection

**Full Plan**: See `.opencode/PILOT-SUMMARY.md` for detailed pilot information

---

## 🚀 Next Steps (Post-Pilot)

1. **Test in Production**: Use pilot agents in real workflows
2. **Gather Feedback**: Report issues and improvements
3. **Scale Conversion**: Apply patterns to remaining 111+ agents
4. **Automation**: Build conversion scripts for batch processing
5. **Integration**: GitHub Actions workflows for automated reviews

---

## 🛠️ Management Tools

### Model Update Script

**Location**: `scripts/update-agents-models.rb`

A production-grade Ruby script for managing Claude model versions across all agents:

**Key Features:**
- **Safe Operations**: Dry-run mode, YAML validation, comprehensive error handling
- **Latest Model Checking**: Fetches current models from Anthropic documentation
- **Security Hardened**: Safe YAML parsing, shell escaping, timeout protection
- **Well Tested**: 18 tests covering validation, parsing, and edge cases
- **Zero Dependencies**: Uses only Ruby stdlib (no gems required)

**Common Commands:**
```bash
# Check if updates are available
ruby scripts/update-agents-models.rb --check-latest

# Preview changes (safe, no modifications)
ruby scripts/update-agents-models.rb --dry-run

# Apply updates
ruby scripts/update-agents-models.rb

# Get help
ruby scripts/update-agents-models.rb --help

# Run test suite
ruby scripts/test_update_agents_models.rb
```

**Configuration:**
- Central config: `.opencode/model-config.yaml`
- Maps model families (sonnet/opus/haiku) to agents
- Single source of truth for all model assignments

**Test Coverage:**
- ✅ Model ID validation
- ✅ YAML frontmatter parsing
- ✅ Model version extraction
- ✅ Configuration loading
- ✅ Dry-run behavior
- ✅ Error handling

See **[scripts/README.md](../scripts/README.md)** for complete documentation.

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
│       ├── api-designer.md
│       ├── api-documenter.md (NEW)
│       ├── technical-writer.md (NEW)
│       └── documentation-engineer.md (NEW)
├── command/
│   ├── review.md (NEW)
│   ├── security-scan.md (NEW)
│   ├── design-review.md (NEW)
│   ├── api-docs.md (NEW)
│   ├── doc-setup.md (NEW)
│   └── document.md (NEW)
├── context/
│   ├── core/essential-patterns.md (NEW)
│   ├── quality/
│   │   ├── pragmatic-review-framework.md (NEW)
│   │   └── design-review-standards.md (NEW)
│   ├── security/
│   │   ├── owasp-vulnerability-patterns.md (NEW)
│   │   └── false-positive-filters.md (NEW)
│   ├── accessibility/wcag-checklist.md (NEW)
│   └── documentation/
│       ├── api-documentation-standards.md (NEW)
│       └── documentation-infrastructure.md (NEW)
└── README.md (this file)
```

---

## 🎯 Success Metrics (Pilot)

- ✅ 11 agents successfully converted/created
- ✅ 8 focused context files created (~300-640 lines each)
- ✅ 6 slash commands for common workflows
- ✅ All agents properly configured with permissions
- ✅ Pragmatic quality framework successfully integrated
- ✅ Security scanning with false-positive filtering implemented
- ✅ Design review with accessibility focus completed
- ✅ Documentation agents (API, technical writing, systems engineering)
- ✅ Documentation workflows (API docs, infrastructure setup, technical writing)
- ✅ Model management system with automated updates
- ✅ Comprehensive test suite (18 tests, 32 assertions)
- ✅ Production-grade error handling and security hardening

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
