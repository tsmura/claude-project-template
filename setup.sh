#!/bin/bash

echo "🚀 Claude Project Template Setup"
echo "---------------------------------"

read -p "Project name: " PROJECT_NAME
read -p "Project description: " PROJECT_DESCRIPTION
read -p "Tech stack (e.g. Python, Firebase, TypeScript): " STACK
read -p "Your name: " OWNER_NAME
read -p "Team member 2 name (or leave blank): " MEMBER_2
read -p "Team member 3 name (or leave blank): " MEMBER_3
DATE=$(date +%Y-%m-%d)

sed -i "" "s/PROJECT_NAME/$PROJECT_NAME/g" .claude/project-metadata.json
sed -i "" "s/OWNER_NAME/$OWNER_NAME/g" .claude/project-metadata.json
sed -i "" "s/MEMBER_1/$OWNER_NAME/g" .claude/project-metadata.json
sed -i "" "s/MEMBER_2/${MEMBER_2:-TBD}/g" .claude/project-metadata.json
sed -i "" "s/MEMBER_3/${MEMBER_3:-TBD}/g" .claude/project-metadata.json
sed -i "" "s/YYYY-MM-DD/$DATE/g" .claude/project-metadata.json

sed -i "" "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" .claude/instructions.md
sed -i "" "s/\[PROJECT_DESCRIPTION\]/$PROJECT_DESCRIPTION/g" .claude/instructions.md
sed -i "" "s/\[TEAM_MEMBERS\]/$OWNER_NAME, ${MEMBER_2:-}, ${MEMBER_3:-}/g" .claude/instructions.md

sed -i "" "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" README.md
sed -i "" "s/\[PROJECT_DESCRIPTION\]/$PROJECT_DESCRIPTION/g" README.md

echo ""
echo "✅ Setup complete! Project '$PROJECT_NAME' is ready."
echo "Open in VS Code and start Claude Code to begin."
