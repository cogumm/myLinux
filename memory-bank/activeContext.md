# Active context — myLinux

Last updated: 2026-11-16

## Current focus

Carcará **1.x = install engine**. Plan: `.agents/idea/carcara-modern-install.md`. Steps 1–4 done → **Step 5 ShellCheck** or **Wave 2** next.  
**2.0** Electron: `.agents/idea/carcara-2.0-electron.md` — backends ready to consume later.

## Recent decisions

- 1.x focuses on backends + apt-correct system scripts + thin installers; Yad/Zenity are temporary.
- Wave 3 Yad/`gum` polish is low priority / skip if 2.0 starts.
- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Script header banner required on all Carcará `.sh` files.
- Skill: `shellcheck-configuration`.

## Next useful engineering work

1. Wave 1 Step 5 — ShellCheck on touched Wave 1 scripts.
2. Wave 2 lean installers onto backends.
3. Optional: align Social/Utilities Voltar with break-only pattern.
4. Electron 2.0 when requested.

## Blockers

None for documentation. Live apt testing needs explicit owner request.
