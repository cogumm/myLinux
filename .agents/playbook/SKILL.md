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
4. For 1.x TUI work, read `design-system/carcara/MASTER.md`.
5. For 2.0 Electron UI, read `design-system/carcara-2-0/pages/app-shell.md` (then `MASTER.md`) and `references/carcara-2.0.md`.

## References

| File | Topic |
|------|--------|
| `references/stack.md` | Runtime, tools, entrypoints |
| `references/product.md` | Scope and non-goals |
| `references/code-organization.md` | Where scripts live |
| `references/carcara.md` | 1.x menus, config, installers, `carcara_confirm` |
| `references/carcara-2.0.md` | Electron UI, Bun, helper, license, Zod env, Dotfiles, WSL |
| `references/dotfiles.md` | `apply.sh` + menus 1.x/2.0, aliases, zsh, git, Hyper |
| `references/legacy.md` | What `old/` means |

## Working style

- Edit `carcara/` or `dotfiles/` first.
- Keep root-only work behind `isRoot`.
- Prefer idempotent installs and `/etc/os-release` detection.
- Do not revive dead PPAs or PHP5-era stacks from `old/` without modernization.
- Do not commit/push unless asked.

## Closing a wave

Append `memory-bank/progress.md`, refresh `activeContext.md`, and update `TODO.md` if items remain.
