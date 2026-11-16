# `.claude/` — Claude Code adapter

Root `CLAUDE.md` points at `AGENTS.md`.

## Rules

`.claude/rules/*.md` mirrors `.cursor/rules/*.mdc` (same policies, Claude Code format).

| File | Topic |
|------|--------|
| `stack.md` | Bash / apt / WSL stack |
| `product.md` | Product scope |
| `git.md` | Commit / push / tags |
| `memory.md` | memory-bank workflow |
| `code-organization.md` | Prefer edit-in-place |
| `ui.md` | Carcará Zenity/Yad TUI |
| `buttons.md` | Menu action verbs |
| `shell-safety.md` | Root / apt / destructive ops |

When changing a rule, update **both** `.cursor/rules/<name>.mdc` and `.claude/rules/<name>.md` (or sync from Cursor → Claude).

Canonical long-form docs stay in `.agents/` (`idea/`, `playbook/`) and `memory-bank/`.
