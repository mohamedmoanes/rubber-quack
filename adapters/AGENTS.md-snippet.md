# AGENTS.md integration

Add to your root `AGENTS.md` skills index or governance section:

```markdown
### rubber-quack (optional)

Socratic mentoring skill—vendor from [rubber-quack](https://github.com/you/rubber-quack) or submodule at `vendor/rubber-quack/`.

- **When:** User requests rubber duck / Socratic / mentor mode.
- **Skill:** `vendor/rubber-quack/.agents/skills/rubber-quack/SKILL.md`
- **Protocol:** `vendor/rubber-quack/protocol/CORE.md`
- **Conflicts:** Defer to user IMPLEMENT confirmation over default "fix everything" rules.
```

Submodule (example):

```bash
git submodule add <your-remote-url> vendor/rubber-quack
```
