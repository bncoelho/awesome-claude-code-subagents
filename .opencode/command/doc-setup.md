---
description: "Set up documentation infrastructure with automation and testing"
agent: documentation-engineer
---

You are setting up a production-grade documentation system with automation and testing.

**Request:** $ARGUMENTS

**Context Loaded:**
@.opencode/context/documentation/documentation-infrastructure.md
@.opencode/context/documentation/documentation-templates.md
@.opencode/context/core/essential-patterns.md

**Your Workflow:**

1. **ANALYZE** requirements:
   - Project type and scale
   - Documentation needs (API, user guides, tutorials)
   - Target audiences
   - Current documentation state
   - Team size and workflows
   - Deployment environment

2. **DESIGN** infrastructure:
   - Choose static site generator:
     - Docusaurus (React, feature-rich)
     - MkDocs (Python, simple)
     - VitePress (Vue, fast)
     - Nextra (Next.js, flexible)
   - Plan information architecture
   - Design version strategy
   - Select search solution (Algolia, Meilisearch)
   - Configure CI/CD pipeline

3. **IMPLEMENT** system:
   - Set up project structure
   - Configure build pipeline
   - Create documentation templates
   - Implement automated testing:
     - Link checking
     - Code example validation
     - Spell checking
     - Accessibility testing
   - Add search functionality
   - Configure analytics
   - Set up contribution workflow

4. **DOCUMENT** usage:
   - Contributor guidelines
   - Writing standards
   - Build/deploy process
   - Maintenance procedures

**Deliverables:**
- Complete documentation site configuration
- CI/CD pipeline (GitHub Actions/GitLab CI)
- Testing framework
- Contribution guidelines
- Style guide and templates
- Deployment setup
- Monitoring/analytics configuration

**Key Features to Include:**
- ✅ Multi-version support
- ✅ Search functionality
- ✅ Dark mode
- ✅ Mobile responsive
- ✅ Fast page loads (< 2s)
- ✅ Automated deployments
- ✅ Link validation
- ✅ Code example testing

Execute documentation infrastructure setup now.
