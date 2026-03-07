# [PROJECT_NAME]

## Overview
[PROJECT_DESCRIPTION]

## Getting Started
1. Clone this repo
2. Run `./setup.sh` to configure the project
3. Open in VS Code and connect via Claude Code

## Claude Code Setup
This repo uses a standardized `.claude/` structure for AI-assisted development.
Before starting work, Claude will read:
- `.claude/instructions.md` – project context and coding conventions
- `.claude/agents.md` – agent roles and responsibilities
- `.claude/handoff-protocol.md` – how agents communicate

## Folder Structure
```
src/        – Source code
tests/      – Tests
docs/       – Documentation
.claude/    – Claude Code configuration
```

## Team
See `.claude/project-metadata.json` for team details.
