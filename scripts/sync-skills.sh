#!/usr/bin/env bash
# Sync canonical .agents skill to Cursor and skill/ export paths.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/.agents/skills/rubber-quack/SKILL.md"
TMP="$(mktemp)"

if [[ ! -f "$SRC" ]]; then
  echo "Missing canonical skill: $SRC" >&2
  exit 1
fi

# Cursor export: opt-in invocation (not required for .agents consumers).
if grep -q '^disable-model-invocation:' "$SRC"; then
  cp "$SRC" "$TMP"
else
  awk '
    /^metadata:/ && !done { print "disable-model-invocation: true"; done=1 }
    { print }
  ' "$SRC" > "$TMP"
fi

mkdir -p "$REPO_ROOT/skill" "$REPO_ROOT/.cursor/skills/rubber-quack"
cp "$TMP" "$REPO_ROOT/skill/SKILL.md"
cp "$TMP" "$REPO_ROOT/.cursor/skills/rubber-quack/SKILL.md"
rm -f "$TMP"

echo "Synced: $REPO_ROOT/skill/SKILL.md"
echo "Synced: $REPO_ROOT/.cursor/skills/rubber-quack/SKILL.md"
