# rubber-quack

Cross-IDE **Socratic rubber duck** protocol and agent skill: questions and graduated hints, not full solutions, until you explicitly bail out.

Registered skill id: **`rubber-quack`** (distinct from Cursor's built-in **rubber-duck** subagent).

## What's in the repo

| Path | Purpose |
|------|---------|
| [`protocol/CORE.md`](protocol/CORE.md) | Single source of truth (modes, hint ladder, templates) |
| [`.agents/skills/rubber-quack/`](.agents/skills/rubber-quack/) | **Canonical** skill for all coding agents (`name: rubber-quack`) |
| [`AGENTS.md`](AGENTS.md) | Root pointer for AGENTS.md-compatible tools |
| [`skill/SKILL.md`](skill/SKILL.md) | Cursor export (synced; opt-in invocation) |
| [`.cursor/skills/rubber-quack/`](.cursor/skills/rubber-quack/) | Cursor mirror (synced) |
| [`adapters/`](adapters/) | Thin snippets for Cursor rules, Copilot, Claude Code, AGENTS.md |
| [`examples/`](examples/) | Good turns and bail-out dialogs |
| [`scripts/install.sh`](scripts/install.sh) | Fallback copy when Node.js is not available |

## Install

You need [Node.js](https://nodejs.org/) 22.20 or later. The [skills CLI](https://github.com/vercel-labs/skills) installs this skill into Cursor, Claude Code, GitHub Copilot, Codex, and other agents. Run it from the project that should use the skill:

```bash
npx skills add mohamedmoanes/rubber-quack
```

The CLI asks which agents to install for. These flags skip the prompts:

```bash
# this project, Cursor only
npx skills add mohamedmoanes/rubber-quack -a cursor -y

# every project on this machine
npx skills add mohamedmoanes/rubber-quack -g -y

# every supported agent, this project
npx skills add mohamedmoanes/rubber-quack --all
```

The repository is private, so the command uses the GitHub login already on your machine (`gh` or git credentials). The same command works for anyone once the repository is public.

The installed skill includes the protocol at `references/CORE.md`. Mentoring stays opt-in (`disable-model-invocation: true`): say *“rubber quack”*, *“mentor mode”*, or `/duck`.

### Verify

In a new chat:

- *"rubber duck this: my tests pass locally but fail in CI"*

The assistant should reply with a question or a hint. Say *"bail out"* when you want the full solution.

### Update and remove

```bash
npx skills update
npx skills remove rubber-quack
```

### Without Node

Clone the repo and run [`scripts/install.sh`](scripts/install.sh):

```bash
git clone https://github.com/mohamedmoanes/rubber-quack.git
./rubber-quack/scripts/install.sh --target agents --project /path/to/your/app
```

Use `--target cursor` for Cursor’s `.cursor/skills/` tree, or `--global` instead of `--project`. Add `--dry-run` to print the copies without writing them.

## Protocol summary

**Modes:** MENTOR (default) · HYBRID (read together) · IMPLEMENT (after bail-out confirm)

**Hint ladder:** 0 Mirror → 1 Diagnose → 2 Nudge → 3 Contradiction → 4 Pattern → 5 Bail-out

Details: [`protocol/CORE.md`](protocol/CORE.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Edit `protocol/CORE.md` and `.agents/skills/rubber-quack/SKILL.md`, then run `./scripts/sync-skills.sh` to refresh the exports.

## License

MIT, see [LICENSE](LICENSE).
