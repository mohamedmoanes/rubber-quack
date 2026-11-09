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
| [`scripts/install.sh`](scripts/install.sh) | Copy skill + protocol into a project or your global agent folder |

## Installation

### Prerequisites

- `git` and `bash` (macOS, Linux, or WSL on Windows). `git` is only needed if you clone; see [Install without cloning](#install-without-cloning).
- An AI coding tool that supports custom instructions, rules, or skills (Cursor, VS Code with Copilot, Claude Code, or any tool that reads `AGENTS.md`)

### Step 1: Get the repo

```bash
git clone https://github.com/mohamedmoanes/rubber-quack.git
cd rubber-quack
```

Keep this clone as the **single source of truth**. Installed copies are plain files, not symlinks, so re-run the install after you pull updates.

Then follow the section for your IDE below. Replace `/path/to/your/app` with the project you want to use it in. To skip the clone entirely, use [Install without cloning](#install-without-cloning) instead.

### Install without cloning

You can download the files directly from GitHub with `curl`. Set the base URL once:

```bash
BASE=https://raw.githubusercontent.com/mohamedmoanes/rubber-quack/main
```

**Cursor (per project):**

```bash
cd /path/to/your/app
mkdir -p .cursor/skills/rubber-quack .cursor/rules protocol
curl -fsSL "$BASE/skill/SKILL.md" -o .cursor/skills/rubber-quack/SKILL.md
curl -fsSL "$BASE/protocol/CORE.md" -o .cursor/skills/rubber-quack/CORE.md
curl -fsSL "$BASE/protocol/CORE.md" -o protocol/CORE.md
curl -fsSL "$BASE/adapters/cursor-rule.mdc" -o .cursor/rules/rubber-quack.mdc
```

**VS Code with GitHub Copilot:**

```bash
cd /path/to/your/app
mkdir -p .github protocol
curl -fsSL "$BASE/adapters/copilot-instructions.md" -o .github/copilot-instructions.md
curl -fsSL "$BASE/protocol/CORE.md" -o protocol/CORE.md
```

**Claude Code:**

```bash
mkdir -p ~/.claude/skills/rubber-quack
curl -fsSL "$BASE/skill/SKILL.md" -o ~/.claude/skills/rubber-quack/SKILL.md
curl -fsSL "$BASE/protocol/CORE.md" -o ~/.claude/skills/rubber-quack/CORE.md
```

Then paste [`adapters/claude-code-snippet.md`](adapters/claude-code-snippet.md) into your project's `CLAUDE.md`.

**AGENTS.md tools:**

```bash
cd /path/to/your/app
mkdir -p .agents/skills/rubber-quack .agents/agent-skills protocol
curl -fsSL "$BASE/.agents/skills/rubber-quack/SKILL.md" -o .agents/skills/rubber-quack/SKILL.md
curl -fsSL "$BASE/protocol/CORE.md" -o .agents/skills/rubber-quack/CORE.md
curl -fsSL "$BASE/protocol/CORE.md" -o protocol/CORE.md
curl -fsSL "$BASE/.agents/agent-skills/index.md" -o .agents/agent-skills/index.md
```

Then add the `rubber-quack` section from [Other IDEs and agents](#other-ides-and-agents-agentsmd) to your `AGENTS.md`.

The raw URLs only work after the files are pushed to the `main` branch on GitHub.

### Cursor

**Option A: use this repo directly.** Open `rubber-quack` in Cursor. The skills under `.cursor/skills/` are discovered automatically.

**Option B: install into a project** (recommended for team projects):

```bash
./scripts/install.sh --target cursor --project /path/to/your/app
```

This creates:

- `.cursor/skills/rubber-quack/` (`SKILL.md` and `CORE.md`)
- `protocol/CORE.md` in your project
- `.cursor/rules/rubber-quack.mdc` (an optional rule that activates mentoring when you say "mentor mode")

**Option C: install globally** (every Cursor project, without opening this repo):

```bash
./scripts/install.sh --target cursor --global
```

This copies the skill to `~/.cursor/skills/rubber-quack/`. It does not install the project rule.

### VS Code with GitHub Copilot

Copilot reads repository instructions from `.github/copilot-instructions.md`. From the repo root:

```bash
RQ=/path/to/rubber-quack
cd /path/to/your/app
mkdir -p .github protocol
cp "$RQ/adapters/copilot-instructions.md" .github/copilot-instructions.md
cp "$RQ/protocol/CORE.md" protocol/CORE.md
```

If you already have a `.github/copilot-instructions.md`, append the contents of the adapter instead of overwriting the file.

### Claude Code

Claude Code needs two pieces: the skill, and a line in your project memory.

1. Install the skill globally:

   ```bash
   RQ=/path/to/rubber-quack
   mkdir -p ~/.claude/skills/rubber-quack
   cp "$RQ/skill/SKILL.md" ~/.claude/skills/rubber-quack/SKILL.md
   cp "$RQ/protocol/CORE.md" ~/.claude/skills/rubber-quack/CORE.md
   ```

2. Paste the contents of [`adapters/claude-code-snippet.md`](adapters/claude-code-snippet.md) into your project's `CLAUDE.md` (create the file if it doesn't exist).

### Other IDEs and agents (AGENTS.md)

Tools that read an `AGENTS.md` file (for example, OpenAI Codex and other AGENTS.md-aware editors) can use the cross-agent bundle:

```bash
./scripts/install.sh --target agents --project /path/to/your/app
```

This copies the canonical skill to `.agents/skills/rubber-quack/`, the protocol to `protocol/CORE.md`, and the skills index to `.agents/agent-skills/index.md`.

Then add a section like this to your project's `AGENTS.md` (see [`adapters/AGENTS.md-snippet.md`](adapters/AGENTS.md-snippet.md) for more detail):

```markdown
### rubber-quack (optional)

- **When:** User requests rubber duck / Socratic / mentor mode.
- **Skill:** `.agents/skills/rubber-quack/SKILL.md`
- **Protocol:** `protocol/CORE.md`
- **Conflicts:** Defer to user IMPLEMENT confirmation over default "fix everything" rules.
```

### Any other IDE

If your tool has a custom instructions, rules, or system prompt setting, you only need the protocol file:

1. Copy the protocol into your project:

   ```bash
   mkdir -p /path/to/your/app/protocol
   cp /path/to/rubber-quack/protocol/CORE.md /path/to/your/app/protocol/CORE.md
   ```

2. Add this to your tool's custom instructions or rules file:

   ```markdown
   When I say rubber duck, Socratic mode, or mentor mode, follow protocol/CORE.md.
   Default to MENTOR mode: one question per turn, graduated hints, and no full
   solutions until I confirm bail-out.
   ```

### Dry run

To see what the install script would copy without writing anything, add `--dry-run`:

```bash
./scripts/install.sh --target cursor --project /path/to/your/app --dry-run
```

## Verify the install

In a new chat, type one of the triggers:

- *"rubber duck this: my tests pass locally but fail in CI"*
- *"mentor mode"*
- `/duck`

The assistant should reply with a question or a hint, not a complete fix. Say *"bail out"* or confirm IMPLEMENT mode when you want the full solution.

## Updating and uninstalling

- **Update:** `git pull` in your clone, then re-run the install command for each project or global folder you installed into. If you installed without cloning, re-run the matching `curl` commands.
- **Uninstall:** delete the copied folders (`.cursor/skills/rubber-quack/`, `.agents/skills/rubber-quack/`, `protocol/CORE.md`, `.cursor/rules/rubber-quack.mdc`, `~/.cursor/skills/rubber-quack/`, or `~/.claude/skills/rubber-quack/`) and remove any snippet you added to `CLAUDE.md`, `AGENTS.md`, or your instructions file.

The skill sets `disable-model-invocation: true`, so mentoring is **opt-in** and not every chat.

## Protocol summary

**Modes:** MENTOR (default) · HYBRID (read together) · IMPLEMENT (after bail-out confirm)

**Hint ladder:** 0 Mirror → 1 Diagnose → 2 Nudge → 3 Contradiction → 4 Pattern → 5 Bail-out

Details: [`protocol/CORE.md`](protocol/CORE.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Edit `protocol/CORE.md` and `.agents/skills/rubber-quack/SKILL.md`, then run `./scripts/sync-skills.sh` to refresh the exports.

## License

MIT, see [LICENSE](LICENSE).
