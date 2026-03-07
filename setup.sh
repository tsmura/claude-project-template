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
read -rp "Package manager (e.g., npm, uv, cargo): " PKG_MANAGER

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

# Update settings.json permissions for the chosen package manager
if [[ "${PKG_MANAGER:-npm}" != "npm" ]]; then
  sedi "s/Bash(npm run \*)/Bash($PKG_MANAGER_ESC run *)/" .claude/settings.json
  sedi "s/Bash(npx \*)/Bash($PKG_MANAGER_ESC exec *)/" .claude/settings.json
fi

echo ""
echo "Setup complete! Project '$PROJECT_NAME' is ready."
echo ""
echo "Next steps:"
echo "  1. Review CLAUDE.md and customize for your project"
echo "  2. Review .claude/settings.json and adjust permissions"
echo "  3. Copy CLAUDE.local.md.example -> CLAUDE.local.md for personal settings"
echo "  4. Copy .mcp.json.example -> .mcp.json if you use MCP servers"
echo "  5. (Optional) Run ./global-setup.sh to set up global Claude Code config"
echo "  6. Delete this setup.sh (no longer needed)"
echo "  7. git add -A && git commit -m 'chore: initialize project from template'"
