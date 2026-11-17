# Carcará 2.0 (Electron + Bun)

Desktop UI for myLinux. Install **engine** stays in Bash 1.x (`../carcara/`).  
Toolchain and privilege bridge use **[Bun](https://bun.sh/docs)** (including [`Bun` Shell](https://bun.sh/docs/runtime/shell)).

Electron’s main process runs Chromium’s Node and calls `helper/carcara-helper.sh` via `src/run-helper-node.ts` (pkexec when needed). Dev also has `bun run helper` (`scripts/run-helper.ts` + Bun Shell). Packaged `.deb` does **not** require Bun at runtime.

Logo: **`assets/img/logo_moderno_final.png`** (build copies all `assets/img/*` into `dist/renderer/assets/`).  
UI: Flat Design from **`ui-ux-pro-max`** → `design-system/carcara-2-0/` (rail + tiles + activity console).  
Structure: `src/renderer/views/` (Sistema / Software / Sobre) + `src/renderer/components/` (tiles, rail, dialog, …); build bundles to `dist/renderer/renderer.js`.

## Requirements

- **Root / sudo** — same policy as Carcará 1.x (`isRoot`). Prefer `sudo ./start.sh --electron` from the repo root.
- **License gate** — same `carcara/app/config/license` text as 1.x; checkbox **Continuar** before the shell opens.
- [Bun](https://bun.sh) ≥ 1.1 (usually `~/.bun/bin`; `start.sh` restores it under sudo’s `secure_path`)
- Linux desktop (or WSLg) for the window
- Already-root sessions skip `pkexec` for helper actions

## Environment

```bash
cd carcara-electron
cp .env.example .env   # edit as needed
```

Validated with **Zod** in `src/env.ts` (loads `.env` via `dotenv`). Notable keys: `CARCARA_LANG` (`pt`|`en`), `CARCARA_TEST_HOST` / `CARCARA_TEST_COUNT`, window size, `CARCARA_REQUIRE_ROOT`, `LIBGL_ALWAYS_SOFTWARE`. Shared strings: repo `locales/*.json` (see playbook `references/i18n.md`).

## Dev

```bash
# From repo root (recommended — elevates like 1.x):
sudo ./start.sh --electron

# Or already as root:
cd carcara-electron
bun install
bun run dev
```

`electron` / `bun run start` exit if uid ≠ 0 (unless `CARCARA_REQUIRE_ROOT=0`).

| Script | What it does |
|--------|----------------|
| `bun run build` | `tsc` + copy renderer + logo (via `Bun.$`) |
| `bun run dev` | build + local `electron . --no-sandbox` |
| `bun run start` | last build |
| `bun run helper -- ping` | `testConnection.sh` → ping Google DNS IP (−c 3) |
| `bun run smoke:software` | Software wiring + ping + pkexec probe (safe default) |
| `bun run smoke:software -- --pkexec` | also `apt-dry-run` via helper (root or pkexec) |
| `bun run smoke:software -- --live install-git …` | mutating installs (owner machine) |
| `bun run typecheck` | `tsc --noEmit` |
| `bun run pack:deb` | build + **electron-builder** → `release/*.deb` |
| `bun run pack:appimage` | build → `release/*.AppImage` (portable; no postinst wrapper) |
| `bun run pack:linux` | `.deb` + AppImage in one pass (CI) |
| `bun run pack:dir` | unpacked dir under `release/` (debug packaging) |

### Smoke (Software / pkexec)

Default mode does **not** install packages: it checks UI tiles ↔ helper allowlist ↔ 1.x scripts, unknown-action exit 2, unprivileged `ping`, and whether `pkexec`+display exist.

```bash
cd carcara-electron
bun run smoke:software
# On a real desktop with policykit (or already-root):
bun run smoke:software -- --pkexec
sudo bun run smoke:software -- --live install-git install-vlc
```

On **WSL** without `policykit-1`, pkexec probes **SKIP** — use root (`sudo ./start.sh --electron`) or a native desktop for elevation.

## Packaging (`.deb` + AppImage)

- Config: `electron-builder.yml` — Linux `deb` + `AppImage` + `extraResources` → `resources/mylinux/{carcara,locales,dotfiles,assets,carcara-electron/helper}`.
- Postinst (`.deb` only): `build/deb/after-install.sh` wraps `/usr/bin/carcara` with **pkexec** (1.x root parity) and `--no-sandbox`.
- AppImage: portable; **no** afterInstall — run as root or `pkexec ./carcara_*.AppImage` (helper still elevates privileged actions when pkexec exists).
- CI: `.github/workflows/release-deb.yml` — on **Release published** (or `workflow_dispatch`), builds amd64 `.deb` + AppImage and attaches both.

```bash
cd carcara-electron
bun run pack:deb
# → release/carcara_<version>_amd64.deb
sudo apt install ./release/carcara_*.deb
carcara   # elevates via pkexec when not root

bun run pack:appimage
# → release/carcara_<version>_amd64.AppImage
chmod +x release/carcara_*.AppImage
pkexec ./release/carcara_*.AppImage   # or sudo
```

`--no-sandbox` is required on many WSL/Linux setups where `chrome-sandbox` is not root-owned (SUID).  
On **WSL**, `--disable-gpu` / `--disable-dev-shm-usage` (and `LIBGL_ALWAYS_SOFTWARE=1` from `start.sh`) reduce `libEGL` / `MESA` / DRI3 noise when running as root under WSLg. Prefer a real desktop for packaging.

## Dual entry

From the **repo root**:

```bash
./start.sh              # menu: Electron ou terminal
./start.sh --electron   # este app
./start.sh --terminal   # Carcará 1.x
```

| Track | Entry |
|-------|--------|
| Chooser | `./start.sh` |
| 1.x CLI/TUI | `cd carcara && sudo bash startApp.sh` |
| 2.0 UI | `sudo ./start.sh --electron` (or root + `bun run dev`) |

Plan: `.agents/idea/carcara-2.0-electron.md`  
Agent how-to: `.agents/playbook/references/carcara-2.0.md`
