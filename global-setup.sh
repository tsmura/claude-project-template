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

  read -rp "  Install $display_target? [y/N] " answer
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "  SKIP  $display_target (declined)"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if $DRY_RUN; then
    echo "  WOULD install $display_target"
  else
    mkdir -p "$(dirname "$target")"
    cp "$source" "$target"
    echo "  OK    $display_target"
  fi
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
install_file "$GLOBAL_DIR/skills/git-summary/SKILL.md.example" "$CLAUDE_HOME/skills/git-summary/SKILL.md"
echo ""

# User-scoped MCP servers
echo "User-scoped MCP servers:"
install_file "$GLOBAL_DIR/claude.json.example" "$HOME/.claude.json"
echo ""

# Parent directory CLAUDE.md
PROJECTS_DIR="$(dirname "$SCRIPT_DIR")"
echo "Parent directory instructions ($(echo "${PROJECTS_DIR/#$HOME/~}")/CLAUDE.md):"
install_file "$GLOBAL_DIR/parent-claude.md.example" "$PROJECTS_DIR/CLAUDE.md"
echo ""

# Summary
echo "======================================="
if $DRY_RUN; then
  echo "Dry run complete: $INSTALLED would be installed, $SKIPPED skipped."
else
  echo "Done: $INSTALLED installed, $SKIPPED skipped."
fi
echo ""
echo "Learn more: docs/global-config.md"
