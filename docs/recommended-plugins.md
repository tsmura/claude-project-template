# Recommended Claude Code Plugins

Install plugins with `claude plugin install <name>`. Plugins are user-global — they apply across all projects.

Run `./global-setup.sh` to install interactively, or install individually below.

## Integrations

| Plugin | Description |
|--------|-------------|
| `firebase` | Manage Firestore, auth, cloud functions, hosting, storage |
| `playwright` | Browser automation and e2e testing |
| `github` | PR/issue management, code search, repository operations |
| `slack` | Search messages, access channels, read threads |
| `figma` | Access design files, extract components, translate designs to code |

## Language Servers

| Plugin | Description |
|--------|-------------|
| `typescript-lsp` | TypeScript/JavaScript code intelligence |
| `pyright-lsp` | Python type checking and code intelligence |

## Development Tools

| Plugin | Description |
|--------|-------------|
| `agent-sdk-dev` | Development kit for Claude Agent SDK |
| `pr-review-toolkit` | Specialized review agents for tests, types, quality |
| `commit-commands` | Git commit, push, and PR workflows |
| `code-review` | Automated PR review with confidence scoring |
| `code-simplifier` | Simplify and refine code for clarity |
| `feature-dev` | Codebase exploration, architecture design, quality review |
| `frontend-design` | Production-grade frontend interfaces |
| `playground` | Interactive single-file HTML explorers |
| `ralph-loop` | Iterative self-referential development loops |
| `plugin-dev` | Toolkit for developing Claude Code plugins |
| `claude-code-setup` | Analyze codebases and recommend automations |
| `claude-md-management` | Audit and maintain CLAUDE.md files |
| `skill-creator` | Create, improve, and benchmark skills |

## Security

| Plugin | Description |
|--------|-------------|
| `security-guidance` | Warns about security issues when editing files |
| `semgrep` | Static analysis for vulnerabilities |
| `sonatype-guide` | Dependency security and vulnerability scanning |

## AI/ML

| Plugin | Description |
|--------|-------------|
| `huggingface-skills` | Build, train, evaluate open source AI models |

## Quick Install All

```bash
# Integrations
claude plugin install firebase
claude plugin install playwright
claude plugin install github
claude plugin install slack
claude plugin install figma

# Language servers
claude plugin install typescript-lsp
claude plugin install pyright-lsp

# Development tools
claude plugin install agent-sdk-dev
claude plugin install pr-review-toolkit
claude plugin install commit-commands
claude plugin install code-review
claude plugin install code-simplifier
claude plugin install feature-dev
claude plugin install frontend-design
claude plugin install playground
claude plugin install ralph-loop
claude plugin install plugin-dev
claude plugin install claude-code-setup
claude plugin install claude-md-management
claude plugin install skill-creator

# Security
claude plugin install security-guidance
claude plugin install semgrep
claude plugin install sonatype-guide

# AI/ML
claude plugin install huggingface-skills
```
