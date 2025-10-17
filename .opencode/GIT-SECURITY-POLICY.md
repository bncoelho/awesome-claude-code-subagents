---
title: Git Security Policy for OpenCode Agents
date: 2025-10-17
version: 1.0
---

# Git Security Policy

## Overview

This document defines the git-related security restrictions applied to all OpenCode agents in this repository.

**Core Principle**: Agents NEVER have permission to commit, push, or stage changes to any branch. All git modifications must be explicitly approved and executed by human developers.

---

## Denied Git Operations (All Agents)

The following git operations are **DENIED** across all 8 agents:

```bash
git commit      # ❌ DENIED - Prevent all commits
git push        # ❌ DENIED - Prevent all pushes
git add         # ❌ DENIED - Prevent staging changes
git reset       # ❌ DENIED - Prevent resetting commits
git rebase      # ❌ DENIED - Prevent rebasing
git merge       # ❌ DENIED - Prevent merging branches
```

---

## Allowed Git Operations (Read-Only)

Some agents may be allowed **READ-ONLY** git operations for context:

### Security Scanner
The security scanner agent is allowed to READ git history for vulnerability analysis:

```bash
git diff <files>    # ✅ ALLOWED - View differences
git status          # ✅ ALLOWED - Check repo status
git log <files>     # ✅ ALLOWED - View commit history
git show <commit>   # ✅ ALLOWED - View specific commits
```

**Note**: Even with these read permissions, security-scanner is EXPLICITLY DENIED from committing, pushing, adding, resetting, rebasing, or merging.

---

## Why These Restrictions?

### No Auto-Commits
- Prevents agents from accidentally committing incomplete work
- Ensures all changes go through human review
- Maintains clear audit trail (you see what was changed)

### No Auto-Push
- Agents cannot deploy changes directly to main/master
- Prevents accidental pushes to protected branches
- Ensures peer review process is followed

### No Staging Without Approval
- Prevents sneaky changes being added without your knowledge
- All staged changes are intentional and explicit

### Escalation Required
- Any git operation must be explicitly requested by the agent
- You approve or deny each request
- Clear, intentional control flow

---

## How Agents Work Around This

When agents need to make changes, they should:

1. **Create files** in the working directory
2. **Show you** what was created/modified
3. **Ask for approval** to stage and commit
4. **Provide exact commands** for you to run:
   ```bash
   git add path/to/files
   git commit -m "Your approved message"
   git push origin feature-branch
   ```

---

## Permission Configuration

### Primary Agents (fullstack, backend, frontend developers)

```yaml
permissions:
  bash:
    "rm -rf *": "deny"
    "git commit": "deny"
    "git push": "deny"
    "git add": "deny"
    "git reset": "deny"
    "git rebase": "deny"
    "git merge": "deny"
    "npm publish": "deny"
    "docker system prune": "deny"
  edit:
    "**/*.env*": "deny"
    "**/*.secret": "deny"
    "**/node_modules/**": "deny"
    "**/.git/**": "deny"
```

### Review Agents (pragmatic-code-reviewer, code-reviewer, design-reviewer)

```yaml
permissions:
  bash:
    "*": "deny"              # All bash commands denied
  write:
    "**/*": "deny"           # Cannot write any files
  edit:
    "**/*": "deny"           # Cannot edit any files
```

### Security Scanner (Read-Only + Scanning)

```yaml
permissions:
  bash:
    "git diff*": "allow"     # Can view diffs
    "git status": "allow"    # Can check status
    "git log*": "allow"      # Can view history
    "git show*": "allow"     # Can view commits
    "git commit": "deny"     # ❌ Cannot commit
    "git push": "deny"       # ❌ Cannot push
    "git add": "deny"        # ❌ Cannot stage
    "git reset": "deny"      # ❌ Cannot reset
    "git rebase": "deny"     # ❌ Cannot rebase
    "git merge": "deny"      # ❌ Cannot merge
    "*": "deny"              # All other commands denied
  write:
    "**/*": "deny"           # Cannot write files
  edit:
    "**/*": "deny"           # Cannot edit files
```

### API Designer (Limited Write)

```yaml
permissions:
  bash:
    "*": "deny"              # All bash commands denied
    "git commit": "deny"     # ❌ Cannot commit
    "git push": "deny"       # ❌ Cannot push
    "git add": "deny"        # ❌ Cannot stage
  write:
    "**/*.env*": "deny"      # Cannot write env files
    "**/*.secret": "deny"    # Cannot write secrets
```

---

## Enforcement

These restrictions are **ENFORCED BY OPENCODE CLI** and cannot be bypassed:
- If an agent attempts a denied operation, OpenCode returns a permission error
- The operation is blocked before execution
- The agent sees the error and should report it to you

---

## Future Considerations

### Never Straight to main/master
Even if restrictions were relaxed in the future:
- Agents should NEVER push directly to main/master
- All changes must go through a pull request
- PRs require human review and approval
- Branch protection rules should be enforced

### Staged Approach
If you ever want to give agents more git control:
1. Start with feature branch creation only
2. Later add commit capability with explicit approval
3. Then add push to feature branches
4. Later add PR creation capability
5. NEVER allow direct main/master modification

---

## Testing & Verification

To verify these restrictions are working:

```bash
# These commands should fail with permission errors:
opencode --agent fullstack-developer
> git commit -m "test"
# Error: Permission denied - git commit

opencode --agent backend-developer
> git push origin main
# Error: Permission denied - git push

# But reading should work (for security-scanner):
opencode --agent security-scanner
> git diff HEAD
# Should show the diff output
```

---

## Questions?

If agents request git operations:
1. **Commit requests**: Verify the changes, then you run the commit
2. **Push requests**: Verify the branch, then you run the push
3. **Other requests**: Deny by default, review carefully before allowing

The goal is **safety first** - always maintain human control over repository changes.

---

**Last Updated**: October 17, 2025  
**Status**: ✅ Enforced across all 8 pilot agents  
**Review Cycle**: Quarterly or when requirements change
