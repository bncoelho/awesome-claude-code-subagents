# Agent Classification Guide - Model Alias Assignment

Complete guide for assigning model aliases to all 119+ agents during the scaling phase.

---

## Quick Reference: Alias Assignment by Category

| Category | Alias Assignment | Rationale |
|----------|------------------|-----------|
| Core Development | `development` | General coding tasks |
| Language Specialists | `development` | Standard implementation |
| Code Review | `review` | Precision over speed |
| Security | `security` | High accuracy required |
| Design/UX | `design` | Balanced analysis |
| Meta-Orchestration | `reasoning` | Complex coordination |
| Infrastructure | `development` | Standard operations |
| Data/AI | `reasoning` or `development` | Depends on complexity |
| Specialized Domains | `reasoning` or `development` | Depends on complexity |
| Business/Product | `reasoning` | Strategic analysis |
| Research | `reasoning` | Deep analysis |

---

## Detailed Agent Classification

### 01-Core Development (11 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| fullstack-developer | development | Primary implementation |
| backend-developer | development | Primary implementation |
| frontend-developer | development | Primary implementation |
| electron-pro | development | Desktop app development |
| api-designer | review | Architecture design (precision) |
| graphql-architect | review | Schema design (precision) |
| microservices-architect | reasoning | Complex system design |
| mobile-developer | development | General development |
| ui-designer | design | Visual design review |
| websocket-engineer | development | Implementation focused |
| wordpress-master | development | CMS development |

**Summary**: 6 development, 2 review, 1 design, 1 reasoning, 1 security

---

### 02-Language Specialists (23 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| typescript-pro | development | Language-specific coding |
| javascript-pro | development | Language-specific coding |
| python-pro | development | Language-specific coding |
| go-pro | development | Language-specific coding |
| rust-engineer | development | Language-specific coding |
| java-architect | reasoning | Complex enterprise patterns |
| c++-pro | development | Systems programming |
| csharp-developer | development | .NET development |
| php-pro | development | Web development |
| kotlin-specialist | development | JVM language |
| swift-expert | development | iOS development |
| flutter-expert | development | Mobile framework |
| vue-expert | development | Framework specialist |
| react-specialist | development | Framework specialist |
| angular-architect | reasoning | Enterprise framework |
| django-developer | development | Web framework |
| nextjs-developer | development | Web framework |
| rails-expert | development | Web framework |
| laravel-specialist | development | Web framework |
| spring-boot-engineer | development | Enterprise framework |
| sql-pro | development | Database queries |
| postgres-pro | development | Database specialist |
| graphql-codegen | development | Code generation |

**Summary**: 20 development, 2 reasoning, 1 special (graphql-codegen)

---

### 03-Infrastructure (12 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| cloud-architect | reasoning | Strategic infrastructure design |
| database-administrator | development | Database operations |
| deployment-engineer | development | Deployment automation |
| devops-engineer | development | CI/CD and automation |
| devops-incident-responder | reasoning | Complex incident analysis |
| incident-responder | reasoning | Complex incident analysis |
| kubernetes-specialist | development | Container orchestration |
| network-engineer | development | Network operations |
| platform-engineer | reasoning | Platform design strategy |
| security-engineer | security | Infrastructure security |
| sre-engineer | reasoning | Strategic reliability engineering |
| terraform-engineer | development | IaC implementation |

**Summary**: 5 development, 4 reasoning, 2 security, 1 special

---

### 04-Quality & Security (12 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| accessibility-tester | design | A11y testing & validation |
| architect-reviewer | reasoning | Deep architecture analysis |
| chaos-engineer | reasoning | Complex resilience testing |
| code-reviewer | review | Code quality assessment |
| compliance-auditor | reasoning | Complex compliance analysis |
| debugger | review | Debug analysis & resolution |
| error-detective | reasoning | Complex error investigation |
| penetration-tester | reasoning | Security testing strategy |
| performance-engineer | reasoning | Complex performance analysis |
| qa-expert | development | Test automation |
| security-auditor | reasoning | Strategic security review |
| test-automator | development | Test framework implementation |
| pragmatic-code-reviewer | review | Hierarchical code review |
| security-scanner | security | Vulnerability scanning |
| design-reviewer | design | Design & UX review |

**Summary**: 2 development, 3 review, 3 design/security, 7 reasoning

---

### 05-Data & AI (12 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| ai-engineer | reasoning | AI system design strategy |
| data-analyst | development | Data analysis |
| data-engineer | development | Data pipeline implementation |
| data-scientist | reasoning | Complex data analysis |
| database-optimizer | reasoning | Complex query optimization |
| llm-architect | reasoning | LLM system design |
| machine-learning-engineer | reasoning | ML system design |
| ml-engineer | reasoning | ML implementation strategy |
| mlops-engineer | development | ML ops automation |
| nlp-engineer | reasoning | NLP system design |
| postgres-pro | development | Database specialist |
| prompt-engineer | review | Prompt optimization (precision) |

**Summary**: 3 development, 1 review, 8 reasoning

---

### 06-Developer Experience (10 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| build-engineer | development | Build system implementation |
| cli-developer | development | CLI tool development |
| dependency-manager | development | Dependency management |
| documentation-engineer | review | Documentation review (precision) |
| dx-optimizer | reasoning | Strategic developer experience |
| git-workflow-manager | review | Git workflow guidance |
| legacy-modernizer | reasoning | Complex refactoring strategy |
| mcp-developer | development | MCP implementation |
| refactoring-specialist | reasoning | Complex refactoring |
| tooling-engineer | development | Developer tooling |

**Summary**: 5 development, 2 review, 3 reasoning

---

### 07-Specialized Domains (11 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| api-documenter | review | API documentation (precision) |
| blockchain-developer | development | Blockchain implementation |
| embedded-systems | development | Embedded development |
| fintech-engineer | reasoning | Financial system design |
| game-developer | development | Game development |
| iot-engineer | development | IoT systems |
| mobile-app-developer | development | Mobile app development |
| payment-integration | development | Payment system implementation |
| quant-analyst | reasoning | Quantitative analysis |
| risk-manager | reasoning | Risk assessment strategy |
| seo-specialist | review | SEO optimization (precision) |

**Summary**: 5 development, 2 review, 4 reasoning

---

### 08-Business & Product (11 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| business-analyst | reasoning | Strategic business analysis |
| content-marketer | development | Content creation |
| customer-success-manager | reasoning | Strategic customer analysis |
| legal-advisor | reasoning | Legal strategy & analysis |
| product-manager | reasoning | Product strategy |
| project-manager | reasoning | Project planning strategy |
| sales-engineer | review | Sales technical guidance |
| scrum-master | development | Agile facilitation |
| technical-writer | review | Technical documentation |
| ux-researcher | reasoning | UX research strategy |
| wordpress-master | development | CMS development |

**Summary**: 3 development, 3 review, 5 reasoning

---

### 09-Meta-Orchestration (8 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| agent-organizer | reasoning | Multi-agent coordination |
| context-manager | review | Context optimization (precise) |
| error-coordinator | reasoning | Error coordination strategy |
| knowledge-synthesizer | reasoning | Knowledge integration |
| multi-agent-coordinator | reasoning | Complex agent coordination |
| performance-monitor | review | Performance analysis |
| task-distributor | reasoning | Intelligent task allocation |
| workflow-orchestrator | reasoning | Complex workflow design |

**Summary**: 0 development, 2 review, 6 reasoning

---

### 10-Research & Analysis (6 agents)

| Agent | Alias | Reasoning |
|-------|-------|-----------|
| competitive-analyst | reasoning | Competitive strategy |
| data-researcher | reasoning | Complex data research |
| market-researcher | reasoning | Market analysis strategy |
| research-analyst | reasoning | Deep research synthesis |
| search-specialist | review | Search optimization (precision) |
| trend-analyst | reasoning | Trend analysis strategy |

**Summary**: 0 development, 1 review, 5 reasoning

---

## Summary by Alias

### Total Agents: 119

| Alias | Count | % |
|-------|-------|---|
| development | 39 | 33% |
| review | 16 | 13% |
| security | 3 | 3% |
| design | 3 | 3% |
| reasoning | 55 | 46% |
| **TOTAL** | **116** | **100%** |

---

## Assignment Rationale

### `development` (39 agents - 33%)

**Characteristics:**
- Straightforward implementation
- Language/framework specialists
- Standard automation
- Tool development

**Examples:**
- Language specialists (typescript-pro, python-pro, etc.)
- Framework specialists (react-specialist, django-developer)
- Development tools (cli-developer, build-engineer)
- Standard automation (deployment-engineer, devops-engineer)

**Why Sonnet:**
- Balanced speed and quality
- Sufficient for structured tasks
- Cost-effective
- Fast iteration

---

### `review` (16 agents - 13%)

**Characteristics:**
- Analysis and assessment
- Quality judgment needed
- Pattern recognition
- Guideline application

**Examples:**
- pragmatic-code-reviewer
- code-reviewer
- documentation-engineer
- technical-writer
- git-workflow-manager

**Why Sonnet + 0.1 temp:**
- Precision required (low false positives)
- Deterministic output
- Pattern matching
- Consistent analysis

---

### `security` (3 agents - 3%)

**Characteristics:**
- Vulnerability detection
- High confidence required
- Low false positive tolerance
- Security expertise

**Examples:**
- security-scanner
- security-engineer
- security-auditor (advanced)

**Why Sonnet:**
- High accuracy for vulnerability detection
- Can upgrade to Opus for critical deployments
- Low false positive rate with proper filtering

---

### `design` (3 agents - 3%)

**Characteristics:**
- Aesthetic judgment
- UX/accessibility analysis
- Visual assessment
- User experience focus

**Examples:**
- design-reviewer
- accessibility-tester
- ui-designer

**Why Sonnet + 0.2 temp:**
- Balanced analysis needed
- Creative thinking required
- Accessibility expertise
- Responsive design evaluation

---

### `reasoning` (55 agents - 46%)

**Characteristics:**
- Complex problem-solving
- Strategic decisions
- Multi-step analysis
- Novel situations
- Architecture/design decisions
- Deep understanding required

**Examples:**
- architect-reviewer (complex systems)
- ai-engineer (LLM strategy)
- microservices-architect (complex design)
- legacy-modernizer (complex refactoring)
- workflow-orchestrator (complex coordination)
- product-manager (strategic decisions)
- competitive-analyst (deep analysis)

**Why Opus:**
- Complex reasoning capabilities
- Multi-step problem solving
- Strategic decision support
- Novel situation handling
- Better at edge cases
- Superior architecture thinking

---

## Implementation Guide

### Phase 1: Pilot Agents (Already Done)
✅ 8 agents use appropriate aliases:
- 3 development
- 3 review
- 1 security
- 1 design

### Phase 2: Scale to 119 Agents

1. **Extract remaining 111 agents** from awesome-claude-code-subagents
2. **Classify using this guide** based on agent purpose
3. **Update agent files** with appropriate alias
4. **Test** that aliases resolve correctly
5. **Document** any special cases

### Phase 3: Cost Optimization

After classification, analyze costs:

```
Current: All reasoning → Claude Opus
  • Very expensive for large fleet
  
Optimized: Select reasoning agents → Claude Opus
  • Only critical agents use Opus
  • Others use Sonnet for 2-3x cost savings
```

### Phase 4: Environment-Based

For different environments:

```json
// Production (best quality)
"reasoning": "claude-opus"

// Staging (balance quality/cost)
"reasoning": "claude-sonnet"

// Development (fast iteration)
"reasoning": "claude-haiku"
```

---

## Special Cases

### Agents with Flexible Alias

Some agents could work with multiple aliases:

| Agent | Primary | Alternative | Decision Factor |
|-------|---------|-------------|-----------------|
| error-detective | reasoning | review | Complexity of errors |
| performance-engineer | reasoning | development | Type of optimization |
| database-optimizer | reasoning | development | Query complexity |

**Recommendation:** Use primary; switch alternative only for cost reasons.

---

## Cost Estimation

### By Alias Usage

```
39 development agents @ Sonnet price  = $X
16 review agents @ Sonnet price       = $X
3 security agents @ Sonnet price      = $X
3 design agents @ Sonnet price        = $X
55 reasoning agents @ Opus price      = $Y (5x Sonnet)

Total monthly cost varies by usage patterns
```

### Cost Optimization Strategies

1. **Selective Opus**: Only 10-15 critical reasoning agents use Opus; others use Sonnet
2. **Tiered Environments**: Dev uses Haiku, staging uses Sonnet, prod uses Opus
3. **Gradual Rollout**: Test new models before upgrading all agents
4. **Batch Operations**: Use Haiku for bulk operations, Opus for strategic work

---

## Testing the Classification

When scaling to 119+ agents:

```bash
# Verify alias assignments
for agent in .opencode/agent/*/*.md; do
  model=$(grep "^model:" "$agent" | cut -d' ' -f2)
  echo "$agent: $model"
done

# Count by alias
grep -h "^model:" .opencode/agent/*/*.md | sort | uniq -c
```

---

## Future Adjustments

Monitor and adjust based on:

1. **Performance**: If reasoning agents underperform, upgrade to Opus
2. **Cost**: If Opus too expensive, downgrade some to Sonnet
3. **New Models**: When Claude 4.5+ releases, evaluate agent performance
4. **Usage Patterns**: Heavy users of specific agents get priority for Opus

---

## References

- **Model Aliases**: `MODEL-ALIASES.md`
- **Current Configuration**: `opencode.json`
- **Pilot Agents**: `.opencode/agent/` and `.opencode/agent/subagents/`
- **Pilot Status**: `PILOT-SUMMARY.md`

---

## Checklist for Scaling

- [ ] Review all 111 remaining agents
- [ ] Classify each agent using this guide
- [ ] Update agent files with aliases
- [ ] Update opencode.json with any custom aliases needed
- [ ] Test alias resolution
- [ ] Document any exceptions
- [ ] Create cost estimation
- [ ] Plan environment-based configs
- [ ] Test on staging before production rollout

---

**Last Updated**: Oct 17, 2024  
**Status**: Ready for implementation  
**Next Phase**: Scale to 119+ agents with this classification  
