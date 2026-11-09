# `.agents` — rubber-quack

Cross-agent packaging for the Socratic **rubber-quack** skill (avoids clashing with Cursor’s built-in `rubber-duck` subagent).

## Layout

```
.agents/
├── README.md                 # This file
├── agent-skills/
│   └── index.md              # Skill catalog for AGENTS.md consumers
└── skills/
    └── rubber-quack/
        └── SKILL.md          # Canonical Agent Skill (edit here)
```

Protocol and examples live at repo root (`protocol/`, `examples/`), not under `.agents`, so one source of truth serves all adapters.

## For coding agents

1. Read [agent-skills/index.md](agent-skills/index.md).
2. When the user triggers mentoring, read [skills/rubber-quack/SKILL.md](skills/rubber-quack/SKILL.md) then [protocol/CORE.md](../protocol/CORE.md).

## Install into a consumer machine

```bash
./scripts/install.sh --target agents --global
```

Install into a consumer project:

```bash
./scripts/install.sh --target agents --project /path/to/repo
```

That copies the skill to `~/.agents/skills/rubber-quack` or `<project>/.agents/skills/rubber-quack` plus `protocol/CORE.md`.

## Contributing

Change behavior in `protocol/CORE.md` and skill metadata in `.agents/skills/rubber-quack/SKILL.md`. Run `./scripts/sync-skills.sh` to refresh Cursor and `skill/` exports (or install targets).
