#!/usr/bin/env bash
# Install rubber-quack skill + protocol (Cursor, .agents, or project).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CANONICAL_SKILL="$REPO_ROOT/.agents/skills/rubber-quack/SKILL.md"
TARGET=""
GLOBAL=false
DRY_RUN=false
PROJECT=""

usage() {
  cat <<EOF
Usage: $0 --target cursor|agents (--project PATH | --global) [--dry-run]

  --target agents  Install .agents/skills/rubber-quack + protocol (cross-agent)
  --target cursor  Install .cursor/skills/rubber-quack + protocol (Cursor)

  --project PATH   Install into consumer repo (creates .agents or .cursor tree)
  --global         Install into ~/.agents/skills or ~/.cursor/skills
  --dry-run        Print actions without copying
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --global) GLOBAL=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ "$TARGET" != "cursor" && "$TARGET" != "agents" ]]; then
  echo "--target cursor|agents is required" >&2
  usage
  exit 1
fi

if [[ ! -f "$CANONICAL_SKILL" ]]; then
  echo "Canonical skill missing: $CANONICAL_SKILL" >&2
  exit 1
fi

run() {
  if $DRY_RUN; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

install_bundle() {
  local skill_dest="$1"
  local include_cursor_rule="${2:-false}"
  local skill_src
  if [[ "$TARGET" == "cursor" ]]; then
    skill_src="$REPO_ROOT/skill"
  else
    skill_src="$REPO_ROOT/.agents/skills/rubber-quack"
  fi

  run mkdir -p "$skill_dest"
  run cp "$skill_src/SKILL.md" "$skill_dest/SKILL.md"
  if [[ -d "$skill_src/references" ]]; then
    run mkdir -p "$skill_dest/references"
    run cp -R "$skill_src/references/." "$skill_dest/references/"
  fi

  if [[ -n "$PROJECT" ]]; then
    run mkdir -p "$PROJECT/protocol"
    run cp "$REPO_ROOT/protocol/CORE.md" "$PROJECT/protocol/CORE.md"
    if [[ "$TARGET" == "agents" ]]; then
      run mkdir -p "$PROJECT/.agents/agent-skills"
      run cp "$REPO_ROOT/.agents/agent-skills/index.md" "$PROJECT/.agents/agent-skills/index.md"
      run cp "$REPO_ROOT/AGENTS.md" "$PROJECT/AGENTS.md.rubber-quack-snippet" 2>/dev/null || true
    fi
  fi

  if $include_cursor_rule; then
    local rule_src="$REPO_ROOT/adapters/cursor-rule.mdc"
    if [[ -f "$rule_src" && -n "$PROJECT" ]]; then
      run mkdir -p "$PROJECT/.cursor/rules"
      run cp "$rule_src" "$PROJECT/.cursor/rules/rubber-quack.mdc"
      echo "Optional rule: $PROJECT/.cursor/rules/rubber-quack.mdc"
    fi
  fi

  cat <<NOTE

Installed skill to: $skill_dest
  Protocol travels with the skill at references/CORE.md.
  Full protocol: protocol/CORE.md at repo root when using --project.
NOTE
}

if $GLOBAL; then
  if [[ "$TARGET" == "agents" ]]; then
    install_bundle "$HOME/.agents/skills/rubber-quack" false
  else
    install_bundle "$HOME/.cursor/skills/rubber-quack" false
  fi
  exit 0
fi

if [[ -z "$PROJECT" ]]; then
  echo "--project PATH or --global is required" >&2
  usage
  exit 1
fi

if [[ ! -d "$PROJECT" ]]; then
  echo "Project path does not exist: $PROJECT" >&2
  exit 1
fi

if [[ "$TARGET" == "agents" ]]; then
  install_bundle "$PROJECT/.agents/skills/rubber-quack" false
else
  install_bundle "$PROJECT/.cursor/skills/rubber-quack" true
fi

echo "Done. Triggers: rubber duck, mentor mode, /duck"
