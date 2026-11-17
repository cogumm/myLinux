# Stack

## 1.x (engine + CLI/TUI)

- Bash scripts under `carcara/` and root helpers.
- Zenity + Yad for TUI; apt/dpkg + Flatpak + snap for packages.
- Config: `carcara/app/config/config.sh` + `install_backends.sh` (`carcara_confirm`, backends).
- Entry: `cd carcara && sudo bash startApp.sh` (or `./start.sh --terminal`)
- Boot: `dependences` → Zenity **license** → `menuGeral` (incl. Dotfiles)
- Deps bootstrap: hardened `dependences.sh` + `testConnection.sh`

## 2.0 (product UI)

- Electron + TypeScript + vanilla renderer under `carcara-electron/`
- **Bun** toolchain (`bun install`, `bun run`, [Shell `$`](https://bun.sh/docs/runtime/shell))
- Env: Zod 4 + dotenv (`src/env.ts`, `.env.example`)
- Privilege: `scripts/run-helper.ts` (Bun.$) → `helper/carcara-helper.sh` + `pkexec` when needed
- Unprivileged: `ping`, `dotfiles-*` (as `$SUDO_USER`)
- License gate before shell (same `carcara/app/config/license` as 1.x)
- External links (WSL): `src/open-external.ts` → PowerShell `Start-Process`
- Design: `ui-ux-pro-max` → `design-system/carcara-2-0/`
- Entry: `sudo ./start.sh --electron` (root) or root + `bun run dev`
- Detail: `references/carcara-2.0.md` · Plan: `.agents/idea/carcara-2.0-electron.md`

## Shared

- **Chooser:** repo-root `./start.sh` — Electron 2.0 or terminal 1.x (`--electron` / `--terminal`).
- **Images:** `assets/img/` for 1.x and 2.0 (Electron build copies into `dist/renderer/assets/`).
- **Fonts (2.0 terminal):** `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`
- **Dotfiles:** `dotfiles/apply.sh` + menus in both UIs (`references/dotfiles.md`).
- Optional: `cleanup-zone-identifiers.sh` for WSL ADS junk files.
