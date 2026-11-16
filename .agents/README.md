# `.agents/` — agent-agnostic project guidance

Canonical guidance for **any** coding agent (Cursor, Claude Code, Codex, etc.).

| Path | Role |
|------|------|
| `idea/mylinux.md` | Product idea (source of truth for scope) |
| `playbook/` | How to work in this repo (`SKILL.md` + `references/`) |
| `skills/` | Optional installed skills (`npx skills`); usually empty |

Also read at repo root:

- `AGENTS.md` — short agent entry
- `CLAUDE.md` — points at `AGENTS.md`
- `memory-bank/` — session memory
- `docs/` — operator docs
- `design-system/carcara/` — TUI UX notes

## Tool adapters

| Path | Role |
|------|------|
| `.cursor/rules/` | Cursor-only rules (thin; point here) |
| `.claude/` | Claude Code adapter (optional) |

Do **not** duplicate long playbooks under `.cursor/` or `.claude/` — edit files in `.agents/` instead.
