# Model Aliases - Quick Reference

## Current Aliases (in opencode.json)

```json
{
  "models": {
    "development": "claude-sonnet",
    "review": "claude-sonnet",
    "security": "claude-sonnet",
    "design": "claude-sonnet",
    "reasoning": "claude-opus",
    "fast": "claude-haiku"
  }
}
```

## When to Use Each Alias

| Alias | Model | Temperature | Use For | Agents |
|-------|-------|-------------|---------|--------|
| **development** | Sonnet | 0.2 | General coding work | fullstack, backend, frontend |
| **review** | Sonnet | 0.1 | Code analysis | pragmatic-code-reviewer, code-reviewer, api-designer |
| **security** | Sonnet | 0.1 | Security scanning | security-scanner |
| **design** | Sonnet | 0.2 | UI/UX review | design-reviewer |
| **reasoning** | Opus | 0.1-0.3 | Heavy analysis | (for future agents) |
| **fast** | Haiku | 0.1 | Simple tasks | (for future agents) |

## Using Aliases in Agent Files

```yaml
# In .opencode/agent/your-agent.md
---
description: "Your agent description"
mode: primary
model: development    # ← Use alias, not specific version
temperature: 0.2
---
```

## Updating Models for Production

### When Claude Sonnet 4.5 Releases

```json
// Option 1: Keep Generic (Recommended)
"models": {
  "development": "claude-sonnet"  // Auto-updates to 4.5
}

// Option 2: Pin to Specific Version
"models": {
  "development": "claude-sonnet-4.5-20250815"
}
```

### Then All Agents Using That Alias Get Updated Automatically

No agent file changes needed!

## Cost Optimization

```json
// Production (High Quality)
{
  "reasoning": "claude-opus",
  "development": "claude-sonnet"
}

// Development (Fast Iteration)
{
  "reasoning": "claude-sonnet",
  "development": "claude-haiku"
}
```

## Pilot Agents Status

✅ All 8 pilot agents use aliases:
- 3 using `development`
- 3 using `review`
- 1 using `security`
- 1 using `design`

## Files Reference

- **Main Config**: `opencode.json`
- **Full Guide**: `MODEL-ALIASES.md`
- **Scaling Guide**: `AGENT-CLASSIFICATION-GUIDE.md`
- **This File**: `MODEL-ALIASES-QUICK-REF.md`

## Common Tasks

### Find which alias an agent uses
```bash
grep "^model:" .opencode/agent/your-agent.md
# Returns: model: development
```

### Find all agents using an alias
```bash
grep -r "model: review" .opencode/agent/
# Lists all agents using review alias
```

### Count agents by alias
```bash
grep -rh "^model:" .opencode/agent/ | sort | uniq -c
```

### Change all agents to a new model
```json
// In opencode.json, update ONE line:
"development": "claude-sonnet-4.5"  // Was "claude-sonnet"

// All agents using "development" now use 4.5 automatically!
```

## Key Points

✅ Always reference aliases in agent files, never hardcoded versions
✅ Update model versions in `opencode.json` only
✅ Generic names (claude-sonnet) auto-update, specific versions don't
✅ Use `reasoning` alias for complex operations (Opus)
✅ Different configs per environment for cost optimization

## Questions?

See `MODEL-ALIASES.md` for detailed documentation and `AGENT-CLASSIFICATION-GUIDE.md` for scaling to 119+ agents.
