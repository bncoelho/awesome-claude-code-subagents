# Model Management Strategy - Complete Guide

## Overview

The OpenCode agent system uses **generic model names** to manage Claude model versions centrally. Instead of hardcoding specific model versions in agent files or `opencode.json`, agents reference generic names like `claude-sonnet` that automatically resolve to the latest available version. This ensures:

- ✅ Always using the latest models (when using generic names like `claude-sonnet`)
- ✅ Centralized control (update once, affects all agents using that alias)
- ✅ Semantic clarity (agent intent is clear from alias name)
- ✅ Environment flexibility (different configs for prod/staging/dev)
- ✅ Cost optimization (easily switch to cheaper models for specific tasks)

---

## Current Model Strategy

### Implemented in `opencode.json`

All pilot agents use generic model names that automatically resolve to the latest available versions:

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
    },
    "security-scanner": {
      "model": "claude-sonnet",
      "temperature": 0.1
    },
    "design-reviewer": {
      "model": "claude-sonnet",
      "temperature": 0.2
    }
  }
}
```

### Model Usage by Agent Type

| Agent Type | Model | Use Case | Temperature |
|-----------|-------|----------|-------------|
| **Development** | Claude Sonnet | Fullstack/backend/frontend development | 0.2 |
| **Code Review** | Claude Sonnet | Code review and analysis (precision) | 0.1 |
| **Security** | Claude Sonnet | OWASP vulnerability scanning | 0.1 |
| **Design** | Claude Sonnet | UI/UX and accessibility review | 0.2 |
| **Reasoning** (future) | Claude Opus | Heavy reasoning and complex analysis | 0.1-0.3 |
| **Fast** (future) | Claude Haiku | Simple/quick tasks (cost optimization) | 0.1 |

---

## How It Works

### 1. Agent Files Use Direct Model Names

```yaml
# .opencode/agent/fullstack-developer.md
---
description: "End-to-end feature implementation across frontend, backend, and database"
mode: primary
model: claude-sonnet    # ← Direct model name (generic, always latest)
temperature: 0.2
---
```

All 8 pilot agents use `model: claude-sonnet` which automatically resolves to the latest available Claude Sonnet version.

### 2. OpenCode Resolves to Latest Version

When the agent runs, OpenCode:
1. Reads the agent's `model: claude-sonnet`
2. Resolves to the latest available Claude Sonnet version
3. If new versions release, they're automatically used
4. No manual updates needed to agent files

### 3. Update Centrally When Needed

If you want to pin specific versions or use different models:

**Option A: Update in `opencode.json` (affects all agents using that model)**
```json
{
  "agent": {
    "fullstack-developer": {
      "model": "claude-opus"  // Override to use Opus
    }
  }
}
```

**Option B: Pin to specific version (if API supports it)**
```yaml
# In agent file
model: claude-sonnet-4-20250514
```

---

## Why Generic Names

The pilot uses generic model names directly (e.g., `claude-sonnet` instead of specific versions):

```yaml
# In agent files
model: claude-sonnet    # Always resolves to latest Sonnet
model: claude-opus      # Always resolves to latest Opus
model: claude-haiku     # Always resolves to latest Haiku
```

**Benefits:**
- ✅ Automatically use latest model version when released
- ✅ No manual updates to agent files
- ✅ Agents always benefit from improvements
- ✅ Simple and clean (no version chasing)

**Trade-off:**
- Behavior might change slightly with new model versions (usually improvements)

For production environments, you can optionally override in `opencode.json` to pin specific versions.

---

## Pilot Agents & Their Models

### Primary Agents (User-Facing)

| Agent | Model | Temp | Purpose |
|-------|-------|------|---------|
| **fullstack-developer** | claude-sonnet | 0.2 | Complete feature implementation |
| **backend-developer** | claude-sonnet | 0.2 | Scalable API development |
| **frontend-developer** | claude-sonnet | 0.2 | Modern web interfaces |

### Subagents (Specialized)

| Agent | Model | Temp | Purpose |
|-------|-------|------|---------|
| **pragmatic-code-reviewer** | claude-sonnet | 0.1 | Hierarchical code review |
| **code-reviewer** | claude-sonnet | 0.1 | General code quality |
| **api-designer** | claude-sonnet | 0.1 | API architecture |
| **security-scanner** | claude-sonnet | 0.1 | OWASP vulnerability scanning |
| **design-reviewer** | claude-sonnet | 0.2 | UI/UX + accessibility review |

---

## When to Use Each Model

### Use `claude-sonnet` for (Current Pilot):
- Full-stack, backend, frontend development
- Code review and quality assessment
- Security scanning and auditing
- API design and architecture
- UI/UX design and accessibility review
- **Temperature**: 0.1-0.2 depending on task

### Use `claude-opus` for (Future Scaling):
- Complex problem-solving and architecture decisions
- Multi-step strategic analysis
- Error investigation and troubleshooting
- Performance optimization strategy
- Complex refactoring planning
- Heavy reasoning tasks
- **Temperature**: 0.1-0.3 (depends on task)

### Use `claude-haiku` for (Future Scaling):
- Simple formatting tasks
- Quick syntax checks
- Basic documentation
- Simple utility work
- Cost optimization scenarios
- **Temperature**: 0.1 (fast, deterministic)

---

## Future Agents Using `reasoning`

When we scale to 119+ agents, these agents should use the `reasoning` alias:

**Meta-Orchestration (9 agents):**
- `workflow-orchestrator` - Complex multi-agent coordination
- `multi-agent-coordinator` - Strategic agent planning
- `task-distributor` - Intelligent task allocation
- Others - use `review`

**Quality & Security (12 agents):**
- `architect-reviewer` - Deep architecture analysis
- `chaos-engineer` - Complex failure scenario analysis
- Others - use `review` or `security`

**Developer Experience (10 agents):**
- `legacy-modernizer` - Complex refactoring strategy
- Others - use `development` or `review`

**Data & AI (12 agents):**
- `database-optimizer` - Complex query optimization
- `performance-engineer` - Deep performance analysis
- Others - use `development` or `security`

**Research & Analysis (6 agents):**
- `research-analyst` - Deep research synthesis
- `competitive-analyst` - Strategic analysis
- Others - use `review`

---

## Configuration Examples

### Example 1: Current Pilot Setup

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

### Example 2: Override Specific Agent (Production)

```json
{
  "model": "claude-sonnet",
  "agent": {
    "fullstack-developer": {
      "model": "claude-sonnet",
      "temperature": 0.2
    },
    "architect-reviewer": {
      "model": "claude-opus",      // Heavy reasoning agent
      "temperature": 0.1
    }
  }
}
```

### Example 3: Cost-Optimized (Development)

Use cheaper models during development:

```json
{
  "model": "claude-haiku",          // Default: fast for iteration
  "agent": {
    "security-scanner": {
      "model": "claude-sonnet",     // Keep quality for security
      "temperature": 0.1
    },
    "backend-developer": {
      "model": "claude-haiku",      // Fast iteration
      "temperature": 0.2
    }
  }
}
```

### Example 4: Environment-Specific Files

**Production (`opencode.json`):**
```json
{
  "model": "claude-sonnet",
  "agent": {
    "architect-reviewer": {
      "model": "claude-opus"        // Best quality for critical decisions
    }
  }
}
```

**Development (`opencode.dev.json`):**
```json
{
  "model": "claude-haiku",          // Fast iteration
  "agent": {
    "architect-reviewer": {
      "model": "claude-sonnet"      // Cheaper reasoning for dev
    }
  }
}
```

Usage: `opencode --config opencode.dev.json`

---

## Updating Models When New Versions Release

### Scenario 1: New Claude Sonnet Version

When Claude Sonnet 4.5 is released:

**Option A: Automatic (Recommended)**
```yaml
# No changes needed! "claude-sonnet" automatically uses latest version
model: claude-sonnet
```

**Option B: Pin to Specific Version (if needed)**
```json
{
  "agent": {
    "fullstack-developer": {
      "model": "claude-sonnet-4-20250514"  // Lock to specific version
    }
  }
}
```

### Scenario 2: Testing New Model

Before upgrading all agents, create separate config:

**`opencode.beta.json`:**
```json
{
  "agent": {
    "fullstack-developer": {
      "model": "claude-sonnet-4.5-beta"    // Test new version
    }
  }
}
```

After validation, update main `opencode.json` or use generic name.

### Scenario 3: Cost Optimization

If Opus becomes expensive, downgrade specific agents:

```json
{
  "model": "claude-sonnet",      // Default: cheaper model
  "agent": {
    "architect-reviewer": {
      "model": "claude-opus"     // Only heavy reasoning uses Opus
    }
  }
}
```

---

## Benefits Summary

| Benefit | How It Helps |
|---------|-------------|
| **Always Latest** | Generic names auto-update when new versions release |
| **Centralized** | Change once, all agents benefit |
| **Semantic** | Agent intent clear from alias name |
| **Flexible** | Easy to switch between models per environment |
| **Cost-Conscious** | Optimize which agents use expensive models |
| **A/B Testing** | Test new models before full rollout |
| **Gradual Rollout** | Update aliases one at a time |
| **Documentation** | Self-documenting code (model: review vs model id) |

---

## Common Questions

### Q: How do I know which model my agent is using?

**A:** Check the agent file:
```bash
grep "^model:" .opencode/agent/subagents/pragmatic-code-reviewer.md
# Shows: model: claude-sonnet
```

Or check if overridden in `opencode.json`:
```bash
grep -A5 "pragmatic-code-reviewer" opencode.json
```

### Q: Can I override a model for a specific agent?

**A:** Yes, in `opencode.json`:
```json
{
  "model": "claude-sonnet",
  "agent": {
    "security-scanner": {
      "model": "claude-opus"  // Override to Opus for this agent
    }
  }
}
```

### Q: What if I want different models in production vs development?

**A:** Use separate config files:
```bash
# Production
opencode.json              # Standard setup

# Development
opencode.dev.json          # Cost-optimized setup

# Use with:
opencode --config opencode.dev.json
```

### Q: Can I use models from different providers?

**A:** Yes, OpenCode supports any provider:
```json
{
  "agent": {
    "primary-agent": {
      "model": "anthropic/claude-sonnet"
    },
    "backup-agent": {
      "model": "openai/gpt-4-turbo"
    }
  }
}
```

### Q: What happens when new Claude versions release?

**A:** With generic names, it's automatic:
- `claude-sonnet` automatically uses the latest Sonnet version
- No changes needed to `opencode.json` or agent files
- All agents benefit from improvements immediately

---

## Best Practices

✅ **DO:**
- Use generic model names (claude-sonnet, claude-opus, claude-haiku)
- Keep model definitions in `opencode.json` centralized
- Override specific agents only when needed
- Use separate config files for different environments
- Test cost impact before changing models globally

❌ **DON'T:**
- Hardcode specific versioned models in agent files (use generic names)
- Create separate configs for every small variation
- Override models inconsistently across agents
- Forget to document why you're using a specific model for an agent
- Mix generic and versioned models randomly

---

## Implementation Checklist

- [x] Define model strategy using generic names
- [x] Update all 8 pilot agents to use generic models
- [x] Configure agents in `opencode.json`
- [x] Document system in MODEL-ALIASES.md
- [x] Create scaling guide with model assignments
- [ ] Test with actual OpenCode CLI
- [ ] Validate agents resolve models correctly
- [ ] Document for team members

---

## Next Steps

When scaling to 119+ agents:

1. **Review Classification** - Determine which agents use which alias
2. **Add Reasoning Agents** - Create agents that benefit from Opus
3. **Cost Analysis** - Estimate API costs for different configurations
4. **Documentation** - Create agent classification guide
5. **Testing** - Validate aliases work with new agents

See `AGENT-CLASSIFICATION-GUIDE.md` for detailed guidance on which agents should use which alias during scaling.

---

## File References

- **Configuration**: `opencode.json`
- **Agent Files**: `.opencode/agent/` and `.opencode/agent/subagents/`
- **Documentation**: `MODEL-ALIASES.md` (this file)
- **Scaling Guide**: `AGENT-CLASSIFICATION-GUIDE.md`

---

**Last Updated**: Oct 17, 2024  
**Pilot Status**: ✅ All 8 agents use aliases  
**Ready to Scale**: ✅ Yes  
