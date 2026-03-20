# PROJECT_NAME

> PROJECT_DESCRIPTION

## Getting Started

1. Clone this repository
2. Run `./setup.sh` to configure the project
3. Start coding with Claude Code

> **Tip:** Already have a project? Run `/init` inside Claude Code to auto-generate a `CLAUDE.md` from your codebase.

## Project Structure

```
src/          Source code
tests/        Test files
docs/         Documentation
TODO.md       Living roadmap document (project root)
```

## Claude Code Configuration

This project uses official Claude Code configuration files:

| File                                 | Purpose                                     | Committed? |
| ------------------------------------ | ------------------------------------------- | ---------- |
| `CLAUDE.md` (or `.claude/CLAUDE.md`) | Project instructions and conventions        | Yes        |
| `CLAUDE.local.md`                    | Personal overrides (copy from `.example`)   | No         |
| `.claude/settings.json`              | Shared permissions and hooks                | Yes        |
| `.claude/settings.local.json`        | Personal permissions (copy from `.example`) | No         |
| `.claude/rules/`                     | Path-specific coding rules                  | Yes        |
| `.claude/skills/`                    | Custom slash commands                       | Yes        |
| `.claude/agents/`                    | Subagent definitions (flat `.md` files)     | Yes        |
| `.claudeignore`                      | Exclude files from Claude's context         | Yes        |
| `.mcp.json`                          | MCP server config (copy from `.example`)    | No         |

## Global Configuration (Optional)

Claude Code also supports user-level configuration that applies across all your projects. Run `./global-setup.sh` to optionally install these:

| File                                   | Target                            | Purpose                                             |
| -------------------------------------- | --------------------------------- | --------------------------------------------------- |
| `global/CLAUDE.md.example`             | `~/.claude/CLAUDE.md`             | Cross-project instructions                          |
| `global/settings.json.example`         | `~/.claude/settings.json`         | Global permissions                                  |
| `global/keybindings.json.example`      | `~/.claude/keybindings.json`      | Keyboard shortcuts                                  |
| `global/rules/coding-style.md.example` | `~/.claude/rules/coding-style.md` | Personal coding rules                               |
| `global/rules/docs.md.example`         | `~/.claude/rules/docs.md`         | Documentation rules                                 |
| `global/rules/testing.md.example`      | `~/.claude/rules/testing.md`      | Testing rules                                       |
| `global/rules/git.md.example`          | `~/.claude/rules/git.md`          | Git safety rules                                    |
| `global/skills/*/SKILL.md.example`     | `~/.claude/skills/*/SKILL.md`     | Global skills (start, ship, test, docs, deps, perf) |
| `global/claude.json.example`           | `~/.claude.json`                  | User-scoped MCP servers                             |
| `global/agents/researcher.md.example`  | `~/.claude/agents/researcher.md`  | Personal subagents                                  |
| `global/parent-claude.md.example`      | `~/projects/CLAUDE.md`            | Shared rules for sibling projects                   |

## Development

```bash
# Build
PKG_MANAGER run build

# Test
PKG_MANAGER run test

# Lint
PKG_MANAGER run lint
```
