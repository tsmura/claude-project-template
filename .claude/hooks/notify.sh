#!/bin/bash
# Notification hook: sends a desktop notification when Claude needs attention
# Works on macOS (osascript) and Linux (notify-send)

MESSAGE="${1:-Claude Code needs your attention}"

if [[ "$OSTYPE" == "darwin"* ]]; then
  osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\"" 2>/dev/null || true
elif command -v notify-send &>/dev/null; then
  notify-send "Claude Code" "$MESSAGE" 2>/dev/null || true
fi

exit 0
