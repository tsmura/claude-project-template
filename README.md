# PROJECT_NAME

PROJECT_DESCRIPTION

## Getting Started

1. Clone this repository
2. Run `./setup.sh` to configure the project
3. Start coding with Claude Code

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
| `CLAUDE.md` | Project instructions and conventions | Yes |
| `CLAUDE.local.md` | Personal overrides (copy from `.example`) | No |
| `.claude/settings.json` | Shared permissions and hooks | Yes |
| `.claude/settings.local.json` | Personal permissions (copy from `.example`) | No |
| `.claude/rules/` | Path-specific coding rules | Yes |
| `.claude/skills/` | Custom slash commands | Yes |
| `.claude/agents/` | Subagent definitions | Yes |
| `.mcp.json` | MCP server config (copy from `.example`) | No |

## Development

```bash
# Build
PKG_MANAGER run build

# Test
PKG_MANAGER run test

# Lint
PKG_MANAGER run lint
```
