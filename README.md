# PROJECT_NAME

PROJECT_DESCRIPTION

## Getting Started

1. Clone this repository
2. Run `./setup.sh` to configure the project
3. Start coding with Claude Code

> **Tip:** Already have a project? Run `/init` inside Claude Code to auto-generate a `CLAUDE.md` from your codebase.

## Project Structure

```
src/          Source code
tests/        Test files
docs/         Documentation and planning
  plan.md     Living roadmap document
```

## Claude Code Configuration

This project uses official Claude Code configuration files:

| File | Purpose | Committed? |
|---|---|---|
| `CLAUDE.md` (or `.claude/CLAUDE.md`) | Project instructions and conventions | Yes |
| `CLAUDE.local.md` | Personal overrides (copy from `.example`) | No |
| `.claude/settings.json` | Shared permissions and hooks | Yes |
| `.claude/settings.local.json` | Personal permissions (copy from `.example`) | No |
| `.claude/rules/` | Path-specific coding rules | Yes |
| `.claude/skills/` | Custom slash commands | Yes |
| `.claude/agents/` | Subagent definitions (flat `.md` files) | Yes |
| `.mcp.json` | MCP server config (copy from `.example`) | Yes |

## Global Configuration (Optional)

Claude Code also supports user-level configuration that applies across all your projects. Run `./global-setup.sh` to optionally install these:

| File | Target | Purpose |
|---|---|---|
| `global/CLAUDE.md.example` | `~/.claude/CLAUDE.md` | Cross-project instructions |
| `global/settings.json.example` | `~/.claude/settings.json` | Global permissions, env vars |
| `global/keybindings.json.example` | `~/.claude/keybindings.json` | Keyboard shortcuts |
| `global/rules/coding-style.md.example` | `~/.claude/rules/coding-style.md` | Personal coding rules |
| `global/skills/git-summary/SKILL.md.example` | `~/.claude/skills/git-summary/SKILL.md` | Personal skills |
| `global/claude.json.example` | `~/.claude.json` | User-scoped MCP servers |
| `global/agents/researcher.md.example` | `~/.claude/agents/researcher.md` | Personal subagents |
| `global/parent-claude.md.example` | `~/projects/CLAUDE.md` | Shared rules for sibling projects |

See [docs/global-config.md](docs/global-config.md) for the full configuration hierarchy.

## Development

```bash
# Build
PKG_MANAGER run build

# Test
PKG_MANAGER run test

# Lint
PKG_MANAGER run lint
```
