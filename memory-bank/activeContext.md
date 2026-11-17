# Active context — myLinux

Last updated: 2026-11-16

## Current focus

Carcará **1.x = install engine**. Plan: `.agents/idea/carcara-modern-install.md`. Steps 1–3 done → **Step 4 minimal menus next**.  
**2.0** Electron: `.agents/idea/carcara-2.0-electron.md` — backends ready to consume later.

## Recent decisions

- 1.x focuses on backends + apt-correct system scripts + thin installers; Yad/Zenity are temporary.
- Wave 3 Yad/`gum` polish is low priority / skip if 2.0 starts.
- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Script header banner required on all Carcará `.sh` files.
- Skill: `shellcheck-configuration`.

## Next useful engineering work

1. Wave 1 Step 4 — wire Desenvolvimento / Produção menus.
2. Wave 1 Step 5 — ShellCheck on touched tree.
3. Wave 2 lean installers onto backends.
4. Electron 2.0 when requested.

## Blockers

None for documentation. Live apt testing needs explicit owner request.
