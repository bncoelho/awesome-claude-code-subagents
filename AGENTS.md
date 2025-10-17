# AGENTS.md

Guidelines for agentic coding in the Awesome Claude Code Subagents repository.

## Repository Overview

This is a **documentation repository** (not a code repository) containing production-ready subagent definitions for Claude Code. No build/test commands or linting tools are used.

## Build, Lint & Test Commands

- **No build process**: This is a documentation repository
- **No test framework**: Validation is manual review
- **No linting**: Markdown files follow conventions but aren't linted
- **Verification**: Review changes against CONTRIBUTING.md requirements

## Code Style Guidelines

### Markdown Format

- **File type**: All subagents are `.md` files in `categories/{number}-{category}/` folders
- **YAML frontmatter**: Required header with `name`, `description`, and `tools` fields
- **Line length**: Aim for ~80 characters for readability in terminals
- **Sections**: Use H2 headers (`##`) for major sections, H3 (`###`) for subsections

### Naming Conventions

- **Files**: Use kebab-case (e.g., `api-designer.md`)
- **Folders**: Format as `{number:02d}-{category}` (e.g., `01-core-development`)
- **YAML frontmatter name**: Lowercase kebab-case matching filename without `.md`

### Content Structure

Every subagent file must include:
1. **YAML frontmatter** with name, description, and tools list
2. **Role definition** (opening paragraph describing the agent's expertise)
3. **Key responsibilities** as bullet points or checklists
4. **Design principles** (specific to agent type)
5. **Communication Protocol** section with examples
6. **Core capabilities** organized by domain

### Updating Multiple Files

When adding a new subagent, update in this order:
1. Create the agent `.md` file in appropriate category
2. Update main `README.md` (add link in category section, alphabetically sorted)
3. Update category-specific `README.md` (add description, update tables)
4. Verify all links work

### Style Conventions

- Use **bold** for UI elements and key terms: `**bold**`
- Use `backticks` for code, file paths, commands
- Bullet points for lists; numbered for sequences
- Examples show realistic scenarios with context
- Links are relative: `[link-text](subagent.md)`

## Error Handling & Validation

- Check that YAML frontmatter is valid YAML
- Ensure all referenced tools exist or are reasonable MCP tools
- Verify links between category README.md and agent files
- Confirm alphabetical ordering in README.md sections

## No Special Rules

There are no `.cursorrules`, `.github/copilot-instructions.md`, or similar configuration files in this repository.
