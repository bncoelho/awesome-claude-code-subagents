# OpenCode Agent Model Manager

Utility scripts for managing Claude models across all OpenCode agents.

## Quick Start

**Update all agents to the latest Claude models:**

```bash
ruby scripts/update-agents-models.rb
```

**Preview changes before applying (dry-run mode):**

```bash
ruby scripts/update-agents-models.rb --dry-run
```

**Check if your models are up-to-date with Anthropic's latest:**

```bash
ruby scripts/update-agents-models.rb --check-latest
```

**Combine flags to check and preview:**

```bash
ruby scripts/update-agents-models.rb --dry-run --check-latest
```

## Features

- ✅ **Centralized Configuration**: Single YAML file controls all agent models
- ✅ **Dry-Run Mode**: Preview changes before applying them
- ✅ **Latest Model Checking**: Automatically checks Anthropic docs for newest versions
- ✅ **Safe Updates**: Only modifies YAML frontmatter, validates model IDs
- ✅ **Error Handling**: Graceful failures with clear error messages
- ✅ **Idempotent**: Safe to run multiple times, only updates when needed

## What It Does

The model updater synchronizes all 8+ agents with the latest Claude models by:

1. **Reading Configuration**: Loads semantic model mappings from `.opencode/model-config.yaml`
2. **Checking Latest (Optional)**: Fetches latest model info from Anthropic docs
3. **Updating Agent Files**: Updates each agent's model in `.opencode/agent/*.md` and `.opencode/agent/subagents/*.md`
4. **Syncing Configuration**: Updates `opencode.json` with the latest model IDs and temperatures
5. **Providing Feedback**: Shows a summary of all changes

## Configuration

Edit `.opencode/model-config.yaml` to:

- **Map agents to model families**: Which agents use Sonnet, Opus, or Haiku
- **Update model IDs**: When new Claude versions are released
- **Adjust temperatures**: Fine-tune model behavior per agent

### Model Families

```yaml
models:
  sonnet:
    id: "anthropic/claude-sonnet-4-5"      # Latest Sonnet (best balance)
    temperature: 0.2
  
  opus:
    id: "anthropic/claude-opus-4-1"        # Heavy reasoning tasks
    temperature: 0.1
  
  haiku:
    id: "anthropic/claude-haiku-4-5"       # Fast, cost-optimized
    temperature: 0.1
```

### Agent Mappings

```yaml
agents:
  fullstack-developer: sonnet
  backend-developer: sonnet
  frontend-developer: sonnet
  api-designer: sonnet
  pragmatic-code-reviewer: sonnet
  code-reviewer: sonnet
  security-scanner: sonnet
  design-reviewer: sonnet
```

## Why This System?

### Problem: Version Chasing
Without this system, keeping agents updated requires:
- ❌ Manual editing of 8+ files when models change
- ❌ Risk of inconsistencies
- ❌ Tedious copy-pasting of model IDs

### Solution: Semantic Configuration
With this system:
- ✅ One configuration file for all model mappings
- ✅ Single command to update everything
- ✅ Clear separation of concerns (config vs implementation)
- ✅ Easy to scale to 100+ agents

## Workflow

### When New Claude Models Release

1. Check https://docs.claude.com/en/docs/about-claude/models/overview
2. Update `.opencode/model-config.yaml` with new model IDs
3. Run `ruby scripts/update-agents-models.rb`
4. Commit the changes

Example:
```yaml
# Before
sonnet:
  id: "anthropic/claude-sonnet-4-5"

# After (hypothetical)
sonnet:
  id: "anthropic/claude-sonnet-5-0"
```

Then:
```bash
ruby scripts/update-agents-models.rb
git add .opencode/ opencode.json
git commit -m "Update agents to Claude Sonnet 5.0"
```

### When Changing Agent Model Assignments

Update `.opencode/model-config.yaml`:

```yaml
agents:
  architect-reviewer: opus        # Switch from sonnet to opus
  legacy-modernizer: opus         # New agent using opus
  quick-formatter: haiku          # New agent using haiku
```

Then run the updater:
```bash
ruby scripts/update-agents-models.rb
```

## Implementation Details

### Model ID Formats

The script uses **aliases** (recommended by Anthropic):
- ✅ `anthropic/claude-sonnet-4-5` - Auto-updates to latest
- ❌ `anthropic/claude-sonnet-4-5-20250929` - Hardcoded date

Why aliases?
- Automatically resolve to newest version within a week of release
- No manual updates needed when patch versions release
- More maintainable for long-term projects

### Semantic Model Names

Instead of thinking about specific versions, think about model families:

| Model Family | Use Case | Example Agents |
|-------------|----------|-----------------|
| **sonnet** | General development, coding, reviews | fullstack-developer, code-reviewer |
| **opus** | Complex reasoning, architecture | architect-reviewer, legacy-modernizer |
| **haiku** | Fast tasks, cost optimization | quick-formatter, simple-checks |

## Scaling to More Agents

When you scale from 8 to 119+ agents, this system scales too:

1. Add new agents to `.opencode/model-config.yaml`:
```yaml
agents:
  # Existing
  fullstack-developer: sonnet
  
  # New agents
  rust-engineer: sonnet
  java-architect: opus
  database-optimizer: opus
  simple-formatter: haiku
```

2. Run the updater:
```bash
ruby scripts/update-agents-models.rb
```

All 100+ agents updated in seconds. ✨

## Technical Details

### Files Modified

- `.opencode/agent/*.md` - Primary agent files
- `.opencode/agent/subagents/*.md` - Specialized agent files
- `opencode.json` - Main OpenCode configuration

### Safety Features

- ✅ Only writes files if content changes
- ✅ Creates valid JSON/YAML
- ✅ Reports errors clearly
- ✅ Backs up nothing (use git!)

### Dependencies

- Ruby 2.6+ (built-in YAML and JSON libraries)
- `curl` (optional, recommended for better HTTP redirect handling)
- `timeout` command (optional, for curl timeouts)
- No external gems required

### Testing

Run the test suite to verify core functionality:

```bash
ruby scripts/test_update_agents_models.rb
```

The test suite covers:
- Model ID validation (accepts valid Anthropic models, rejects others)
- YAML frontmatter parsing and updates
- Model version extraction from HTML
- Configuration loading with safe YAML parsing
- Dry-run behavior (ensures no file modifications)
- Error handling for missing files and invalid JSON

## Troubleshooting

### "Agent file not found"
- Ensure agent exists in `.opencode/agent/` or `.opencode/agent/subagents/`
- Check spelling in `model-config.yaml`

### "Failed to update agent"
- Check file permissions: `chmod +x scripts/update-agents-models.rb`
- Verify agent file has valid YAML frontmatter

### Models not changing in OpenCode
- Verify `opencode.json` was updated
- Restart OpenCode CLI
- Check that model alias is valid at https://docs.claude.com/en/docs/about-claude/models/overview

## Example Commands

```bash
# Check if models are up-to-date
ruby scripts/update-agents-models.rb --check-latest

# Preview what would change (dry-run)
ruby scripts/update-agents-models.rb --dry-run

# Update all agents to latest models
ruby scripts/update-agents-models.rb

# Check and preview together
ruby scripts/update-agents-models.rb --dry-run --check-latest

# View changes after update
git diff --stat

# Rollback if needed
git checkout .opencode/ opencode.json

# Commit the changes
git add .opencode/ opencode.json
git commit -m "Update agents to latest Claude models"

# Get help
ruby scripts/update-agents-models.rb --help
```

## Command Line Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Preview changes without modifying any files |
| `--check-latest` | Check Anthropic docs for latest model versions |
| `--help`, `-h` | Show help message with usage examples |

## Best Practices

1. **Check First**: Use `--check-latest` to see if updates are available
2. **Preview Changes**: Always use `--dry-run` before applying updates
3. **Use Aliases**: Always use `claude-sonnet-4-5` not `claude-sonnet-4-5-20250929`
4. **Update Regularly**: Run when new Claude versions release (typically monthly)
5. **Version Control**: Always commit changes with descriptive messages
6. **Document Changes**: Update model-config.yaml comments with release notes
7. **Test First**: Verify agents work before committing to main

## Next Steps

- [Claude Models Documentation](https://docs.claude.com/en/docs/about-claude/models/overview)
- [Model Pricing](https://docs.claude.com/en/docs/about-claude/pricing)
- [API Reference](https://docs.claude.com/en/api/messages)

## Questions?

See `.opencode/MODEL-ALIASES.md` for more detailed information about model strategy.
