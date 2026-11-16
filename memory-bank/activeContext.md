# Active context — myLinux

Last updated: 2026-11-16

## Current focus

Carcará **1.x = install engine** (not final UI). Plan: `.agents/idea/carcara-modern-install.md`. Step 1 done → **Step 2 `install_backends.sh` next**.  
**2.0** Electron: `.agents/idea/carcara-2.0-electron.md` — after backends; do not polish Yad for its own sake.

## Recent decisions

- 1.x focuses on backends + apt-correct system scripts + thin installers; Yad/Zenity are temporary.
- Wave 3 Yad/`gum` polish is low priority / skip if 2.0 starts.
- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Script header banner required on all Carcará `.sh` files.
- Skill: `shellcheck-configuration`.

## Next useful engineering work

1. Wave 1 Step 2 — `install_backends.sh` (critical for 2.0).
2. Wave 1 Step 3 — system scripts.
3. Wave 1 Step 4 — minimal menus + Step 5 ShellCheck.
4. Wave 2 lean installers → then Electron 2.0 when requested.

## Blockers

None for documentation. Live apt testing needs explicit owner request.
