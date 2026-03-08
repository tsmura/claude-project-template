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

# Recommended plugins
PLUGINS=(
  # Integrations
  firebase playwright github slack figma
  # Language servers
  typescript-lsp pyright-lsp
  # Development tools
  agent-sdk-dev pr-review-toolkit commit-commands code-review code-simplifier
  feature-dev frontend-design playground ralph-loop plugin-dev
  claude-code-setup claude-md-management skill-creator
  # Security
  security-guidance semgrep sonatype-guide
  # AI/ML
  huggingface-skills
)
echo "Recommended plugins:"
if command -v claude &>/dev/null; then
  for plugin in "${PLUGINS[@]}"; do
    read -rp "  Install plugin '$plugin'? [y/N] " answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
      if $DRY_RUN; then
        echo "  WOULD install plugin: $plugin"
      else
        yes | claude plugin install "$plugin" 2>/dev/null && echo "  OK    $plugin" || echo "  FAIL  $plugin"
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
