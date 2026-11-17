# Active context — myLinux

Last updated: 2026-11-17

## Current focus

Carcará **1.x = install engine**. Plan: `.agents/idea/carcara-modern-install.md`.  
**Wave 1 + Wave 2 complete.** Next: optional **Wave 3** CLI polish, or **Electron 2.0** when requested.  
**2.0** vision: `.agents/idea/carcara-2.0-electron.md`.

## Recent decisions

- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Wave 2 installers are thin wrappers over `install_backends.sh` (idempotent).
- Yad/Zenity remain temporary; no Yad polish investment.
- Script header banner required on all Carcará `.sh` files.

## Next useful engineering work

1. Optional Wave 3 (init wrapper / dry-run) — low priority.
2. Owner smoke-test of installers on a real/apt machine.
3. Electron 2.0 when requested.

## Blockers

None for documentation. Live apt/snap/flatpak testing needs explicit owner request.
