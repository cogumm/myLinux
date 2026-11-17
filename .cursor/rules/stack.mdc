---
description: Stack and runtime assumptions for myLinux (Bash / apt / WSL / Electron 2.0)
alwaysApply: true
---

# Stack — myLinux

Do not swap this stack without a strong technical reason and owner approval.

- **1.x language:** Bash (`#!/bin/bash`). Prefer POSIX-friendly patterns when sharing logic; document Bashisms.
- **Package managers:** `apt-get` / `dpkg` primary; Flatpak/Flathub preferred for many GUIs; `snap` as fallback / classic when needed.
- **1.x UI:** Zenity (menus) + Yad (progress / short dialogs) under `carcara/` only.
- **2.0 UI:** Electron + TypeScript + vanilla renderer under `carcara-electron/`; toolchain is **Bun** (`bun install` / `bun run` / `Bun.$` shell bridge). Do not nest Electron inside Bash `carcara/`.
- **Config hub (1.x):** `carcara/app/config/config.sh` — source this; do not duplicate `isRoot` / Yad flags in every script. Install API: `install_backends.sh`.
- **Dotfiles:** plain files under `dotfiles/` (aliases, bashrc, oh-my-zsh themes, git, Hyper). No Ansible/Nix requirement unless the owner asks.
- **Legacy:** `old/` is archive (dialog + ancient Ubuntu). New 1.x work lands in `carcara/` or `dotfiles/`; 2.0 UI in `carcara-electron/`.
- **WSL:** supported for maintenance helpers (`cleanup-zone-identifiers.sh`); do not assume systemd or full desktop on every host.
- **Shellcheck** mindset: quote expansions, check commands with `command -v`, avoid `eval`.

Playbook: `.agents/playbook/references/stack.md`
