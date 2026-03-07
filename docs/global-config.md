# Global Claude Code Configuration

Claude Code supports configuration at multiple scopes. This document covers everything **outside** your project directory.

## Configuration Hierarchy

Claude Code loads configuration from multiple scopes, merged in this order:

| Priority | Scope | Instructions | Settings | MCP |
|----------|-------|-------------|----------|-----|
| Highest | Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS) | `managed-settings.json` | `managed-mcp.json` |
| | Project local | `CLAUDE.local.md` | `.claude/settings.local.json` | — |
| | Project | `CLAUDE.md`, `.claude/rules/**/*.md` | `.claude/settings.json` | `.mcp.json` |
| | Parent dirs | `../CLAUDE.md`, `../../CLAUDE.md`, ... | — | — |
| | User rules | — (see User below) | — | — |
| Lowest | User (global) | `~/.claude/CLAUDE.md`, `~/.claude/rules/**/*.md` | `~/.claude/settings.json` | `~/.claude.json` |

**How merging works:**
- For `CLAUDE.md`: all matching files are loaded and concatenated (project-level appears more prominently in context)
- For `settings.json`: array fields like `permissions.allow` are merged across scopes; managed policy cannot be overridden
- For MCP servers: each scope's servers are available independently

## CLAUDE.md Inheritance

Claude walks **up** the directory tree from your working directory, loading `CLAUDE.md` and `CLAUDE.local.md` at each level.

Example: working in `~/projects/myapp/packages/frontend/`
```
~/.claude/CLAUDE.md                          # Global — always loaded
~/projects/CLAUDE.md                         # Parent — loaded (shared across projects)
~/projects/myapp/CLAUDE.md                   # Project root — loaded
~/projects/myapp/packages/CLAUDE.md          # Intermediate — loaded
~/projects/myapp/packages/frontend/CLAUDE.md # Working dir — loaded
```

**Parent directory CLAUDE.md** (`~/projects/CLAUDE.md`) is useful for conventions shared across all your projects — e.g., commit style, documentation standards, planning file location. See `global/parent-claude.md.example`.

## File Reference

### `~/.claude/CLAUDE.md` — Global instructions

Personal instructions applied to every project. Keep under 200 lines.

- **Use for:** cross-project preferences, coding style, workflow conventions
- **Example:** `global/CLAUDE.md.example`
- **Project equivalent:** `CLAUDE.md` (project root)

### `~/.claude/settings.json` — Global settings

Permissions, environment variables, and hooks that apply everywhere.

- **Use for:** tools you always allow/deny, global env vars, notification hooks
- **Example:** `global/settings.json.example`
- **Project equivalent:** `.claude/settings.json`
- **Merging:** `permissions.allow` and `permissions.deny` arrays merge with project settings

### `~/.claude/keybindings.json` — Keyboard shortcuts

Customize Claude Code keyboard shortcuts. Changes auto-reload without restart.

- **Use for:** rebinding submit key, adding chord shortcuts, disabling keys
- **Example:** `global/keybindings.json.example`
- **Schema:** `https://www.schemastore.org/claude-code-keybindings.json`
- **No project equivalent** — keybindings are always global

### `~/.claude/rules/**/*.md` — Global rules

Markdown files discovered recursively. Applied to all projects, before project rules.

- **Use for:** personal coding standards that aren't project-specific
- **Example:** `global/rules/coding-style.md.example`
- **Project equivalent:** `.claude/rules/**/*.md`

### `~/.claude/skills/*/SKILL.md` — Personal skills

Reusable slash commands available in all projects. Each skill is a directory with `SKILL.md` as entrypoint.

- **Invoke:** `/skill-name` or automatically when relevant
- **Example:** `global/skills/git-summary/SKILL.md.example`
- **Project equivalent:** `.claude/skills/*/SKILL.md`
- **Frontmatter options:** `name`, `description`, `allowed-tools`, `model`, `context`

### `~/.claude/agents/*.md` — Personal subagents

Markdown files with YAML frontmatter defining specialized subagents available in all projects.

- **Use for:** code reviewers, researchers, debuggers, domain-specific agents
- **Example:** `global/agents/researcher.md.example`
- **Project equivalent:** `.claude/agents/*.md`
- **Frontmatter fields:** `name`, `description`, `tools`, `model`, `permissionMode`, `hooks`, `memory`, `skills`

### `~/.claude.json` — User-scoped MCP servers

MCP server configuration available across all projects. This file also contains auto-managed app state — only the `mcpServers` section should be manually edited.

- **Use for:** personal dev tools, utilities you use everywhere
- **Add via CLI:** `claude mcp add --scope user <name> <command>`
- **Example:** `global/claude.json.example`
- **Project equivalent:** `.mcp.json`

## Auto-Managed: Memory

Claude Code automatically maintains memory files per project:

```
~/.claude/projects/<project-path>/memory/
  MEMORY.md          # Index (first 200 lines loaded each session)
  debugging.md       # Topic-specific notes
  patterns.md        # Discovered patterns
  ...
```

- **Auto-generated** — do not create manually
- **Machine-local** — not shared across machines
- **Toggle:** `/memory` command or `"autoMemoryEnabled": false` in settings
- **Audit:** run `/memory` to view and edit

## Enterprise / Managed Policy

For managed environments, IT can deploy system-wide configuration:

| OS | Path |
|----|------|
| macOS | `/Library/Application Support/ClaudeCode/` |
| Linux/WSL | `/etc/claude-code/` |
| Windows | `C:\Program Files\ClaudeCode\` |

Files: `CLAUDE.md`, `managed-settings.json`, `managed-mcp.json`

These cannot be overridden by user or project settings.
