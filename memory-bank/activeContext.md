# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 UI is usable alpha** under `carcara-electron/` (Electron + Bun + modular vanilla renderer).  
1.x Bash engine (Waves 1–2) remains the install/maintenance **engine** and CLI/fallback.  
Wave 3 (1.x polish) stays **cancelled**.

Session knowledge dump (17 Nov 2026) lives in:

- `.agents/playbook/references/carcara-2.0.md` (operator + agent how-to)
- `.agents/idea/carcara-2.0-electron.md` (locked decisions + checklist)
- `design-system/carcara-2-0/` (tokens + app-shell)

## Recent decisions (session)

- **UI rebuild** via `ui-ux-pro-max` Flat Design; brand-first rail; logo `logo_moderno_final.png`.
- **Modular renderer:** `views/{sistema,software,sobre}.ts` + reusable `components/` (factories); Bun IIFE bundle.
- **Software** uses the same nav-link pattern as the main rail (`createNavList` / `.rail__link`) for categories.
- **Terminal (Atividade):** Dracula palette + JetBrains Mono (vendored woff2) + line numbers + highlight.
- **Sobre:** README facts + allowlisted external links; no logo variant gallery.
- **WSL:** `openExternal` → PowerShell `Start-Process`; `ping` does not warn about missing `pkexec`.
- **Root required for 2.0 UI** (same as 1.x): `sudo ./start.sh --electron` + `requireRoot()` in Electron main.
- **Images** only under repo `assets/img/` (shared 1.x/2.0).

## Next useful engineering work

1. Package `.deb` for Carcará 2.0 (optional AppImage).
2. Smoke-test **Software** installers via 2.0 UI (owner-requested).
3. Optional: polish remaining 1.x stubs (“Limpeza de memória”) only if still wanted.

## Validated

- Sistema as root (`sudo ./start.sh --electron`): update-distro / fix-system / clean-distro → exit 0 (17 Nov 2026). Noninteractive skips locks/lists as designed; empty trash path is OK.

## Blockers / notes

- App runs as root → helper skips `pkexec` (expected). GPU/`--no-sandbox` warnings under WSL are environmental.
