#!/bin/bash
# Post-edit hook: auto-format changed file with Prettier
# Receives JSON on stdin with tool_input.file_path

FILE_PATH=$(cat | node -e "
  let d='';
  process.stdin.on('data',c=>d+=c);
  process.stdin.on('end',()=>{
    try {
      const j=JSON.parse(d);
      const p=j.tool_input?.file_path || j.tool_input?.path || '';
      process.stdout.write(p);
    } catch(e) { process.exit(0); }
  });
")

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.md)
    npx prettier --write "$FILE_PATH" 2>/dev/null
    ;;
esac

exit 0
