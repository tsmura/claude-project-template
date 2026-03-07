# Agent Handoff Protocol

## Overview
When one agent completes its work and passes to another, it must include a
structured handoff message. This ensures context is preserved and the next
agent knows exactly where to start.

## Handoff Format
```
## HANDOFF
- **From:** [agent name]
- **To:** [agent name]
- **Task:** [what was done]
- **Status:** completed | needs_review | blocked
- **Files changed:** [list of files]
- **Next steps:** [what the receiving agent should do]
- **Notes:** [anything important to know]
```

## Status Definitions
- **completed** – Work is done, no issues.
- **needs_review** – Work is done but requires human or reviewer check.
- **blocked** – Cannot proceed, needs clarification. Tag the human.

## Escalation Rule
If an agent is blocked for more than 2 attempts, it must escalate to the
human with a clear description of the blocker. Do not loop indefinitely.

## Context Window Management
- At the start of each session, read `.claude/instructions.md` and `project-metadata.json`.
- Reference `agents.md` to understand your role before starting.
- Keep handoff messages concise — they are context, not logs.
