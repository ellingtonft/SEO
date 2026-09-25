#!/usr/bin/env bash
# Installs the seo-pass skill and seo-lane-auditor agent into ~/.claude (user scope).
# Existing copies are backed up with a timestamp suffix, never overwritten silently.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
dest="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
stamp="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$dest/skills" "$dest/agents"

backup() {
  if [ -e "$1" ]; then
    mv "$1" "$1.bak-$stamp"
    echo "backed up existing $1 → $1.bak-$stamp"
  fi
}

backup "$dest/skills/seo-pass"
cp -R "$here/.claude/skills/seo-pass" "$dest/skills/seo-pass"

backup "$dest/agents/seo-lane-auditor.md"
cp "$here/.claude/agents/seo-lane-auditor.md" "$dest/agents/seo-lane-auditor.md"

echo "installed: $dest/skills/seo-pass and $dest/agents/seo-lane-auditor.md"
echo "restart Claude Code, then run /seo-pass or paste templates/first-prompt.md"
