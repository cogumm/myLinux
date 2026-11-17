# Active context — myLinux

Last updated: 2026-11-17

## Current focus

Carcará **1.x = install engine**. Plan: `.agents/idea/carcara-modern-install.md`.  
**Wave 1 complete** (Steps 1–5). Next: **Wave 2** thin installers onto backends.  
**2.0** Electron: `.agents/idea/carcara-2.0-electron.md` — backends ready to consume later.

## Recent decisions

- 1.x focuses on backends + apt-correct system scripts + thin installers; Yad/Zenity are temporary.
- Wave 3 Yad/`gum` polish is low priority / skip if 2.0 starts.
- Install backend policy: apt keyrings → Flatpak/Flathub → Snap fallback.
- Script header banner required on all Carcará `.sh` files.
- Skill: `shellcheck-configuration`; project `.shellcheckrc`; optional binary in `.tools/` (gitignored).

## Next useful engineering work

1. Wave 2 lean installers onto backends (utilities → social → development → productivity).
2. Optional: align Social/Utilities Voltar with break-only pattern.
3. Electron 2.0 when requested.

## Blockers

None for documentation. Live apt testing needs explicit owner request.
