# Project brief — myLinux

Last updated: 2026-11-17

## Mission

Maintain a personal, scriptable **Linux workstation toolkit**: Carcará (interactive apt maintenance + app installs), portable **dotfiles**, and small helpers (WSL cleanup). Author: CoGUMm.

## In scope

- Bash + Zenity/Yad installer UX (`carcara/`) — **engine + CLI/fallback**
- Electron + Bun desktop UI (`carcara-electron/`) — **Carcará 2.0 product UI**
- System update / fix / clean scripts
- Curated software installers (dev, social, utilities, productivity)
- Dotfiles for Bash/Zsh/git/Hyper
- Documentation and agent guidance for safe evolution
- Archiving legacy `old/` without breaking history

## Out of scope

- Web applications, payment platforms, cloud multi-tenant apps
- Full distro image building
- Equal support for non-apt distros (may detect and warn)

## Phases (modernization)

1. **Agent docs** — AGENTS/memory-bank/rules describe myLinux — done.
2. **Carcará repair** — deps check, menu wiring, config source paths — Wave 1 done.
3. **Installer refresh** — backends + thin installers — Wave 2 done.
4. **Dotfiles install path** — documented, non-destructive apply — open.
5. **Dual entrypoint** — root `./start.sh` chooses Electron 2.0 or terminal 1.x — done.
6. **Carcará 2.0 alpha UI** — modular Electron shell + helper — done (packaging / pkexec smoke open).
