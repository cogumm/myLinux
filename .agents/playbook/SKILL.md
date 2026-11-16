---
name: mylinux-playbook
description: >-
  Single myLinux project skill — Bash Carcará installer, apt/WSL maintenance,
  dotfiles. Use at the start of every task on this repo, when closing a
  milestone, or when the user mentions memory-bank, progress.md, playbook,
  stack, or Linux scripting rules.
---

# myLinux playbook

## Before any code

1. Read `AGENTS.md`.
2. Read all of `memory-bank/` (at least `activeContext.md` + `progress.md` + `projectbrief.md`).
3. Read `.agents/idea/mylinux.md` if scope is unclear.
4. For TUI work, read `design-system/carcara/MASTER.md`.

## References

| File | Topic |
|------|--------|
| `references/stack.md` | Runtime, tools, entrypoints |
| `references/product.md` | Scope and non-goals |
| `references/code-organization.md` | Where scripts live |
| `references/carcara.md` | Menus, config, installers |
| `references/dotfiles.md` | Aliases, zsh, git, Hyper |
| `references/legacy.md` | What `old/` means |

## Working style

- Edit `carcara/` or `dotfiles/` first.
- Keep root-only work behind `isRoot`.
- Prefer idempotent installs and `/etc/os-release` detection.
- Do not revive dead PPAs or PHP5-era stacks from `old/` without modernization.
- Do not commit/push unless asked.

## Closing a wave

Append `memory-bank/progress.md`, refresh `activeContext.md`, and update `TODO.md` if items remain.
