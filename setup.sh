#!/usr/bin/env bash
set -euo pipefail

echo "Claude Code Project Template Setup"
echo "==================================="
echo ""

# Cross-platform sed in-place
sedi() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}

# Escape special characters for sed replacement
escape_sed() {
  printf '%s' "$1" | sed 's/[&/\]/\\&/g'
}

# Collect input
read -rp "Project name: " PROJECT_NAME
read -rp "Short description: " PROJECT_DESCRIPTION
read -rp "Tech stack (e.g., TypeScript, Python, Go): " TECH_STACK
read -rp "Test framework (e.g., vitest, pytest, go test): " TEST_FRAMEWORK
read -rp "Package manager (e.g., npm, pnpm, uv, cargo): " PKG_MANAGER

# Validate required fields
if [[ -z "$PROJECT_NAME" ]]; then
  echo "Error: Project name is required." >&2
  exit 1
fi

# Escape values for sed
PROJECT_NAME_ESC=$(escape_sed "$PROJECT_NAME")
PROJECT_DESCRIPTION_ESC=$(escape_sed "${PROJECT_DESCRIPTION:-No description}")
TECH_STACK_ESC=$(escape_sed "${TECH_STACK:-Not specified}")
TEST_FRAMEWORK_ESC=$(escape_sed "${TEST_FRAMEWORK:-Not specified}")
PKG_MANAGER_ESC=$(escape_sed "${PKG_MANAGER:-npm}")

# Apply substitutions to CLAUDE.md
sedi "s/PROJECT_NAME/$PROJECT_NAME_ESC/g" CLAUDE.md
sedi "s/PROJECT_DESCRIPTION/$PROJECT_DESCRIPTION_ESC/g" CLAUDE.md
sedi "s/TECH_STACK/$TECH_STACK_ESC/g" CLAUDE.md
sedi "s/TEST_FRAMEWORK/$TEST_FRAMEWORK_ESC/g" CLAUDE.md
sedi "s/PKG_MANAGER/$PKG_MANAGER_ESC/g" CLAUDE.md

# Apply substitutions to README.md
sedi "s/PROJECT_NAME/$PROJECT_NAME_ESC/g" README.md
sedi "s/PROJECT_DESCRIPTION/$PROJECT_DESCRIPTION_ESC/g" README.md
sedi "s/PKG_MANAGER/$PKG_MANAGER_ESC/g" README.md

# Update docs/plan.md with project name
sedi "s/# Project Plan/# $PROJECT_NAME_ESC — Plan/" docs/plan.md

# Update .claude/settings.json permissions for the chosen package manager
PKG="${PKG_MANAGER:-npm}"
if [[ "$PKG" != "npm" ]]; then
  # Replace npm run with the chosen package manager's run command
  sedi "s|Bash(npm run \*)|Bash($PKG_MANAGER_ESC run *)|" .claude/settings.json

  # Replace npx with the appropriate exec command
  case "$PKG" in
    pnpm)  sedi "s|Bash(npx \*)|Bash(pnpm exec *)|" .claude/settings.json ;;
    yarn)  sedi "s|Bash(npx \*)|Bash(yarn dlx *)|" .claude/settings.json ;;
    bun)   sedi "s|Bash(npx \*)|Bash(bunx *)|" .claude/settings.json ;;
    *)     sedi "/Bash(npx \*)/d" .claude/settings.json ;;
  esac
fi

echo ""
echo "Setup complete! Project '$PROJECT_NAME' is ready."
echo ""
echo "Next steps:"
echo "  1. Review and customize CLAUDE.md for your project"
echo "  2. Review .claude/settings.json and adjust permissions"
echo "  3. Review .claude/rules/, .claude/agents/, .claude/skills/ and customize"
echo "  4. Update docs/plan.md with your project phases and tasks"
echo "  5. Copy CLAUDE.local.md.example -> CLAUDE.local.md for personal settings"
echo "  6. Copy .mcp.json.example -> .mcp.json if you use MCP servers"
echo "  7. (Optional) Run ./global-setup.sh to set up global Claude Code config"
echo "  8. Delete this setup.sh and global-setup.sh (no longer needed)"
echo "  9. git add -A && git commit -m 'chore: initialize project from template'"
