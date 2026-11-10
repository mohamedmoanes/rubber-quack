# Contributing

## Changing behavior

1. Edit **only** `protocol/CORE.md` for protocol changes.
2. Edit skill metadata and structure in **`.agents/skills/rubber-quack/SKILL.md`** (canonical).
3. Run `./scripts/sync-skills.sh` to refresh `skill/`, `.cursor/skills/`, and each skill's `references/` bundle (`CORE.md` plus the examples).
4. Add or update dialogs in `examples/` when you change the ladder or modes, then run the sync script again.

## PR checklist

- [ ] Tier numbering and mode names match across CORE, skill, and adapters
- [ ] At least one example turn added or updated if user-visible behavior changed
- [ ] `scripts/install.sh` still copies `SKILL.md` and `references/CORE.md`
- [ ] No stealth-solution examples in `good-turns.md`

## Versioning

Bump `metadata.version` in `skill/SKILL.md` for notable protocol changes. Tag releases in git when publishing.
