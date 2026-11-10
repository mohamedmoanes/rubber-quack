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

bundle_references() {
  local dest="$1"
  mkdir -p "$dest/references/examples"
  cp "$REPO_ROOT/protocol/CORE.md" "$dest/references/CORE.md"
  cp "$REPO_ROOT/examples/"*.md "$dest/references/examples/"
}

CANONICAL_DIR="$(dirname "$SRC")"
bundle_references "$CANONICAL_DIR"

mkdir -p "$REPO_ROOT/skill" "$REPO_ROOT/.cursor/skills/rubber-quack"
cp "$TMP" "$REPO_ROOT/skill/SKILL.md"
cp "$TMP" "$REPO_ROOT/.cursor/skills/rubber-quack/SKILL.md"
bundle_references "$REPO_ROOT/skill"
bundle_references "$REPO_ROOT/.cursor/skills/rubber-quack"
rm -f "$TMP"

echo "Synced: $CANONICAL_DIR/references/"
echo "Synced: $REPO_ROOT/skill/SKILL.md"
echo "Synced: $REPO_ROOT/.cursor/skills/rubber-quack/SKILL.md"
