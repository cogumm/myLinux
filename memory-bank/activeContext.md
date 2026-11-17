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
- **Images** only under repo `assets/img/` (shared 1.x/2.0).

## Next useful engineering work

1. Package `.deb` for Carcará 2.0 (optional AppImage).
2. Live smoke-test of system + software actions with **pkexec** on a real Linux desktop (or WSLg + policykit).
3. Optional: polish remaining 1.x stubs (“Limpeza de memória”) only if still wanted.

## Blockers

- Privileged apt/flatpak/snap on this WSL host lacks `pkexec` → actions run unelevated and fail locks (expected).
- GPU/`viz_main` / `--no-sandbox` warnings under WSL are environmental, not product regressions.
