# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 (Electron + Bun)** — spike under `carcara-electron/`.  
1.x Bash engine (Waves 1–2) is **complete** and stays as CLI/fallback.  
Wave 3 polish was **cancelled / removed**.

## Recent decisions

- Repo layout: sibling `carcara-electron/` (not nested under Bash `carcara/`).
- Toolchain: **Bun** (install/scripts + `Bun.$` shell bridge); Electron main spawns `bun scripts/run-helper.ts`.
- UI: vanilla HTML/CSS + TypeScript; visual system from skill **`ui-ux-pro-max`** → `design-system/carcara-2-0/` (Flat Design app shell).

- Privilege: allowlisted `helper/carcara-helper.sh` + `pkexec` (when available).
- Install engine: reuse `install_backends.sh` / 1.x scripts — never fork into the renderer.

## Next useful engineering work

1. Package `.deb` for Carcará 2.0 (optional AppImage).
2. Live smoke-test of system + software actions with pkexec on a real/WSLg desktop.

## Blockers

GUI/`pkexec` smoke-test needs a desktop session (or WSLg) and owner-approved elevation.
