#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$SCRIPT_DIR/global"
CLAUDE_HOME="$HOME/.claude"
DRY_RUN=false
INSTALLED=0
SKIPPED=0

# Parse flags
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -h|--help)
      echo "Usage: global-setup.sh [--dry-run]"
      echo ""
      echo "Install global Claude Code configuration files to ~/.claude/"
      echo "Never overwrites existing files."
      echo ""
      echo "Options:"
      echo "  --dry-run  Preview actions without writing files"
      exit 0
      ;;
  esac
done

echo "Claude Code Global Configuration Setup"
echo "======================================="
echo ""
if $DRY_RUN; then
  echo "(dry run — no files will be written)"
  echo ""
fi

# Install a single file: install_file <source> <target>
install_file() {
  local source="$1"
  local target="$2"
  local display_target="${target/#$HOME/~}"

  if [[ -f "$target" ]]; then
    echo "  SKIP  $display_target (already exists)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if $DRY_RUN; then
    echo "  WOULD install $display_target"
    INSTALLED=$((INSTALLED + 1))
    return
  fi

  { read -rp "  Install $display_target? [y/N] " answer </dev/tty; } 2>/dev/null || answer="n"
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "  SKIP  $display_target (declined)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  {
    mkdir -p "$(dirname "$target")"
    cp "$source" "$target"
    echo "  OK    $display_target"
  }
  INSTALLED=$((INSTALLED + 1))
}

# Global instructions
echo "Global instructions:"
install_file "$GLOBAL_DIR/CLAUDE.md.example" "$CLAUDE_HOME/CLAUDE.md"
echo ""

# Global settings
echo "Global settings:"
install_file "$GLOBAL_DIR/settings.json.example" "$CLAUDE_HOME/settings.json"
echo ""

# Keybindings
echo "Keyboard shortcuts:"
install_file "$GLOBAL_DIR/keybindings.json.example" "$CLAUDE_HOME/keybindings.json"
echo ""

# Global rules
echo "Global rules:"
install_file "$GLOBAL_DIR/rules/coding-style.md.example" "$CLAUDE_HOME/rules/coding-style.md"
echo ""

# Global skills
echo "Global skills:"
install_file "$GLOBAL_DIR/skills/start/SKILL.md.example" "$CLAUDE_HOME/skills/start/SKILL.md"
install_file "$GLOBAL_DIR/skills/ship/SKILL.md.example" "$CLAUDE_HOME/skills/ship/SKILL.md"
install_file "$GLOBAL_DIR/skills/test/SKILL.md.example" "$CLAUDE_HOME/skills/test/SKILL.md"
install_file "$GLOBAL_DIR/skills/docs/SKILL.md.example" "$CLAUDE_HOME/skills/docs/SKILL.md"
install_file "$GLOBAL_DIR/skills/deps/SKILL.md.example" "$CLAUDE_HOME/skills/deps/SKILL.md"
install_file "$GLOBAL_DIR/skills/perf/SKILL.md.example" "$CLAUDE_HOME/skills/perf/SKILL.md"
echo ""

# Global agents
echo "Global agents:"
install_file "$GLOBAL_DIR/agents/researcher.md.example" "$CLAUDE_HOME/agents/researcher.md"
echo ""

# Global plugins — tools useful across all projects regardless of stack.
# Project-specific plugins (LSPs, firebase, playwright, etc.) should be
# installed per-project with --scope project. See docs/recommended-plugins.md.
GLOBAL_PLUGINS=(
  commit-commands
  code-review
  code-simplifier
  pr-review-toolkit
  claude-code-setup
  claude-md-management
  skill-creator
  plugin-dev
  context7
)
echo "Global plugins (user scope):"
echo "  (Stack-specific plugins are installed per-project via setup.sh)"
echo ""
if command -v claude &>/dev/null; then
  for plugin in "${GLOBAL_PLUGINS[@]}"; do
    if $DRY_RUN; then
      echo "  WOULD install plugin: $plugin"
      INSTALLED=$((INSTALLED + 1))
      continue
    fi
    { read -rp "  Install plugin '$plugin'? [y/N] " answer </dev/tty; } 2>/dev/null || answer="n"
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
      if claude plugin install "$plugin" --yes 2>&1 | tail -1; then
        echo "  OK    $plugin"
      else
        echo "  FAIL  $plugin"
      fi
      INSTALLED=$((INSTALLED + 1))
    else
      echo "  SKIP  $plugin (declined)"
      SKIPPED=$((SKIPPED + 1))
    fi
  done
else
  echo "  SKIP  (claude CLI not found — install plugins manually)"
fi
echo ""

# User-scoped MCP servers
echo "User-scoped MCP servers:"
install_file "$GLOBAL_DIR/claude.json.example" "$HOME/.claude.json"
echo ""

# Parent directory CLAUDE.md
PROJECTS_DIR="$(dirname "$SCRIPT_DIR")"
if [[ "$PROJECTS_DIR" != "$HOME"* ]]; then
  echo "  SKIP  Parent CLAUDE.md (install path $PROJECTS_DIR is outside \$HOME)"
  echo ""
else
echo "Parent directory instructions ($(echo "${PROJECTS_DIR/#$HOME/~}")/CLAUDE.md):"
install_file "$GLOBAL_DIR/parent-claude.md.example" "$PROJECTS_DIR/CLAUDE.md"
echo ""
fi

# Summary
echo "======================================="
if $DRY_RUN; then
  echo "Dry run complete: $INSTALLED would be installed, $SKIPPED skipped."
else
  echo "Done: $INSTALLED installed, $SKIPPED skipped."
fi
