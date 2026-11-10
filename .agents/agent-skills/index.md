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

From the project that should use the skill (Node.js 22.20+):

```bash
npx skills add mohamedmoanes/rubber-quack
```

Add `-g` to install for every project. Without Node, clone this repo and run `scripts/install.sh --target agents --project /path/to/your/app`.

## IDE mirrors

| Surface | Location |
|---------|----------|
| Cursor | `.cursor/skills/rubber-quack/` (synced from `.agents/skills/rubber-quack/`) |
| Portable skill export | `skill/SKILL.md` (synced from `.agents`) |
