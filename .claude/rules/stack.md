---
description: Stack and runtime assumptions for myLinux (Bash / apt / WSL)
---

# Stack — myLinux

Do not swap this stack without a strong technical reason and owner approval.

- **Language:** Bash (`#!/bin/bash`). Prefer POSIX-friendly patterns when sharing logic; document Bashisms.
- **Package managers:** `apt-get` / `dpkg` primary; `snap` only where Carcará already uses it (e.g. VS Code).
- **UI:** Zenity (menus) + Yad (progress / short dialogs). No web UI, no Electron installer.
- **Config hub:** `carcara/app/config/config.sh` — source this; do not duplicate `isRoot` / Yad flags in every script.
- **Dotfiles:** plain files under `dotfiles/` (aliases, bashrc, oh-my-zsh themes, git, Hyper). No Ansible/Nix requirement unless the owner asks.
- **Legacy:** `old/` is archive (dialog + ancient Ubuntu). New work lands in `carcara/` or `dotfiles/`.
- **WSL:** supported for maintenance helpers (`cleanup-zone-identifiers.sh`); do not assume systemd or full desktop on every host.
- **Shellcheck** mindset: quote expansions, check commands with `command -v`, avoid `eval`.

Playbook: `.agents/playbook/references/stack.md`
