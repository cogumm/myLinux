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
- **Bun** toolchain for **dev/build** (`bun install`, `bun run`, [Shell `$`](https://bun.sh/docs/runtime/shell))
- **Packaged runtime:** Node `run-helper-node.ts` → Bash helper — **no Bun on target**
- Env: Zod 4 + dotenv (`src/env.ts`, `.env.example`) incl. `CARCARA_LANG`
- Privilege: helper allowlist + `pkexec` when needed; `.deb` launcher also uses pkexec
- Unprivileged: `ping`, `dotfiles-*` (as `$SUDO_USER`); privileged incl. `sync-time`
- License gate before shell (same `carcara/app/config/license` as 1.x)
- Brand version ← `package.json` (pill + `{version}` in locales); Software pagination 6/page; rail PT\|EN
- Packaging: `electron-builder.yml` in `carcara-electron/`; CI `.github/workflows/release-deb.yml`
- External links (WSL): `src/open-external.ts` → PowerShell `Start-Process`
- Design: `ui-ux-pro-max` → `design-system/carcara-2-0/`
- Entry: `sudo ./start.sh --electron` (dev) · or installed `carcara` from `.deb`
- Detail: `references/carcara-2.0.md` · Plan: `.agents/idea/carcara-2.0-electron.md`

## Shared

- **Default branch:** `main` (bootstrap `MYLINUX_REPO_BRANCH` / raw.githubusercontent.com paths use `main`).
- **Chooser:** repo-root `./start.sh` — Electron 2.0 or terminal 1.x (`--electron` / `--terminal`).
- **i18n:** nested `locales/{pt,en}.json` + `CARCARA_LANG` (`references/i18n.md`); 1.x needs python3 to flatten.
- **Images:** `assets/img/` for 1.x and 2.0 (Electron build copies into `dist/renderer/assets/`).
- **Fonts (2.0 terminal):** `carcara-electron/assets/fonts/JetBrainsMono-Regular.woff2`
- **Dotfiles:** `dotfiles/apply.sh` + menus in both UIs (`references/dotfiles.md`).
- Optional: `cleanup-zone-identifiers.sh` for WSL ADS junk files.
- **Catalog backlog:** `memory-bank/TODO.md` v2.0.1 waves.
- **Releases:** write `docs/releases/X.Y.Z.md` → commit → annotated tag `vX.Y.Z` on that commit → GitHub Release → CI attaches `carcara_*_amd64.deb` (see memory-bank `systemPatterns` #16).
