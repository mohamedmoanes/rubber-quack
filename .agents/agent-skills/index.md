# Agent skills index — rubber-quack

This repository is a **skill distribution** repo. Agents should load skills from `.agents/skills/`.

## Skills

| Skill | Path | Domain |
|-------|------|--------|
| rubber-quack | [skills/rubber-quack/SKILL.md](../skills/rubber-quack/SKILL.md) | coaching / docs |

## Protocol (shared)

| Asset | Path |
|-------|------|
| Core protocol | [protocol/CORE.md](../../protocol/CORE.md) |

## Consume from another repo

1. Submodule or copy this repo under `vendor/rubber-quack/`.
2. Point your root `AGENTS.md` at `vendor/rubber-quack/.agents/agent-skills/index.md`.
3. Or install only the skill:

```bash
vendor/rubber-quack/scripts/install.sh --target agents --global
```

## IDE mirrors

| Surface | Location |
|---------|----------|
| Cursor | `.cursor/skills/rubber-quack/` (synced from `.agents/skills/rubber-quack/`) |
| Portable skill export | `skill/SKILL.md` (synced from `.agents`) |
