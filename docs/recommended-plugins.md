# Recommended Claude Code Plugins

Plugins can be installed at three scopes. Choose the right scope for each plugin:

| Scope | Flag | Settings file | Shared with team? | Use for |
|-------|------|---------------|-------------------|---------|
| **user** (global) | default | `~/.claude/settings.json` | No | Tools you want in every project |
| **project** | `--scope project` | `.claude/settings.json` | Yes (committed) | Stack-specific or team-shared tools |
| **local** | `--scope local` | `.claude/settings.local.json` | No (gitignored) | Personal experiments for one project |

```bash
# Examples
claude plugin install commit-commands                  # global (default)
claude plugin install playwright --scope project       # project (committed)
claude plugin install ralph-loop --scope local         # local (gitignored)
```

Run `./global-setup.sh` to install global plugins interactively. For project plugins, use `./setup.sh` or install manually.

---

## Global Plugins (user scope)

Tools useful across all projects regardless of tech stack. Installed by `./global-setup.sh`.

| Plugin | Description |
|--------|-------------|
| `commit-commands` | Git commit, push, and PR workflows |
| `code-review` | Automated PR review with confidence scoring |
| `code-simplifier` | Simplify and refine code for clarity |
| `pr-review-toolkit` | Specialized review agents for tests, types, quality |
| `claude-code-setup` | Analyze codebases and recommend automations |
| `claude-md-management` | Audit and maintain CLAUDE.md files |
| `skill-creator` | Create, improve, and benchmark skills |
| `plugin-dev` | Toolkit for developing Claude Code plugins |
| `context7` | Up-to-date documentation lookup for any library |

## Project Plugins (project scope)

Install per-project based on your stack. These land in `.claude/settings.json` and are shared with your team. The `./setup.sh` script offers relevant plugins based on your chosen tech stack.

### Frontend / TypeScript

| Plugin | Description |
|--------|-------------|
| `typescript-lsp` | TypeScript/JavaScript code intelligence |
| `playwright` | Browser automation and e2e testing |
| `frontend-design` | Production-grade frontend interfaces |
| `figma` | Access design files, extract components, translate designs to code |

### Backend / Python

| Plugin | Description |
|--------|-------------|
| `pyright-lsp` | Python type checking and code intelligence |

### GCP / Firebase

| Plugin | Description |
|--------|-------------|
| `firebase` | Manage Firestore, auth, cloud functions, hosting, storage |

### Security

| Plugin | Description |
|--------|-------------|
| `security-guidance` | Warns about security issues when editing files |
| `semgrep` | Static analysis for vulnerabilities |
| `sonatype-guide` | Dependency security and vulnerability scanning |

### Development workflow

| Plugin | Description |
|--------|-------------|
| `feature-dev` | Codebase exploration, architecture design, quality review |
| `agent-sdk-dev` | Development kit for Claude Agent SDK |

## Personal Plugins (local scope)

Optional plugins for individual use. Not committed to git.

| Plugin | Description |
|--------|-------------|
| `playground` | Interactive single-file HTML explorers |
| `ralph-loop` | Iterative self-referential development loops |
| `huggingface-skills` | Build, train, evaluate open source AI models |
| `slack` | Search messages, access channels, read threads |

---

## Plugin Authentication

Some plugins require API tokens. Store them in `~/.claude/.env` (see [global-config.md](global-config.md#claudeenv--plugin-secrets) for details).

| Plugin | Required env var | Where to get the token |
|--------|-----------------|----------------------|
| `slack` | `SLACK_BOT_TOKEN` | Slack API → Your Apps → OAuth & Permissions |

Example `~/.claude/.env`:
```bash
SLACK_BOT_TOKEN=xoxb-your_token_here
```

Restart Claude Code after editing this file.

---

## Quick Install Reference

### Global plugins (run once)

```bash
claude plugin install commit-commands
claude plugin install code-review
claude plugin install code-simplifier
claude plugin install pr-review-toolkit
claude plugin install claude-code-setup
claude plugin install claude-md-management
claude plugin install skill-creator
claude plugin install plugin-dev
claude plugin install context7
```

### Project plugins (run per-project, or use setup.sh)

```bash
# Frontend / TypeScript
claude plugin install typescript-lsp --scope project
claude plugin install playwright --scope project
claude plugin install frontend-design --scope project
claude plugin install figma --scope project

# Backend / Python
claude plugin install pyright-lsp --scope project

# GCP / Firebase
claude plugin install firebase --scope project

# Security
claude plugin install security-guidance --scope project
claude plugin install semgrep --scope project
claude plugin install sonatype-guide --scope project

# Development workflow
claude plugin install feature-dev --scope project
claude plugin install agent-sdk-dev --scope project
```

### Personal plugins (optional)

```bash
claude plugin install playground --scope local
claude plugin install ralph-loop --scope local
claude plugin install huggingface-skills --scope local
claude plugin install slack --scope local
```
