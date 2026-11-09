# AGENTS.md — rubber-quack

Skill-only repository. Agents load mentoring behavior from `.agents/`, not from application code.

## Skills catalog

See [.agents/agent-skills/index.md](.agents/agent-skills/index.md).

## Default skill

**rubber-quack** — Socratic debugging and design mentoring.  
Path: [.agents/skills/rubber-quack/SKILL.md](.agents/skills/rubber-quack/SKILL.md)  
Protocol: [protocol/CORE.md](protocol/CORE.md)

## When to activate

User mentions rubber duck, Socratic mode, mentor mode, 🦆, `/duck`, or asks not to receive full solutions yet.

## Repo map

| Path | Role |
|------|------|
| `protocol/CORE.md` | Hint ladder, modes, templates |
| `.agents/skills/` | Canonical skills for all agents |
| `.cursor/skills/` | Cursor discovery mirror |
| `skill/` | Portable export (synced) |
| `adapters/` | IDE-specific thin wrappers |
| `examples/` | Dialog fixtures |

## Conflicts

When other instructions demand immediate full implementation, **rubber-quack** applies only in MENTOR/HYBRID until the user confirms IMPLEMENT.
