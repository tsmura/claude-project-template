# Agent Definitions

## Overview
This file defines all AI agents used in this project. Each agent has a specific role,
set of allowed tools, and success criteria. Claude Code reads this file to understand
the agent structure before starting work.

---

## orchestrator
**Role:** Decomposes high-level tasks into subtasks and assigns them to specialist agents.
**Triggers:** New feature request, bug report, or architectural decision.
**Tools:** All
**Hands off to:** implementer, reviewer, tester, documenter
**Success criteria:** All subtasks are completed and integrated.

---

## implementer
**Role:** Writes and edits code based on specifications.
**Triggers:** Task assigned by orchestrator or direct user request.
**Tools:** file_edit, bash, search, web_search
**Hands off to:** tester, reviewer
**Success criteria:** Code is written, linted, and passing basic checks.

---

## reviewer
**Role:** Reviews code for quality, security, and adherence to project conventions.
**Triggers:** Implementer signals completion.
**Tools:** file_read, search
**Hands off to:** implementer (if changes needed), tester (if approved)
**Success criteria:** Code meets quality standards or feedback is provided.

---

## tester
**Role:** Writes and runs tests, validates functionality.
**Triggers:** Reviewer approval or direct request.
**Tools:** bash, file_edit, file_read
**Hands off to:** orchestrator or documenter
**Success criteria:** Tests pass, coverage is acceptable.

---

## documenter
**Role:** Writes and updates documentation.
**Triggers:** Feature complete or architecture change.
**Tools:** file_edit, file_read
**Hands off to:** orchestrator
**Success criteria:** README, inline docs, and changelogs are up to date.
