# Carcará 2.0 (Electron + Bun)

Desktop UI for myLinux. Install **engine** stays in Bash 1.x (`../carcara/`).  
Toolchain and privilege bridge use **[Bun](https://bun.sh/docs)** (including [`Bun` Shell](https://bun.sh/docs/runtime/shell)).

Electron’s main process runs Chromium’s Node and calls `helper/carcara-helper.sh` via `src/run-helper-node.ts` (pkexec when needed). Dev also has `bun run helper` (`scripts/run-helper.ts` + Bun Shell). Packaged `.deb` does **not** require Bun at runtime.

Logo: **`assets/img/logo_moderno_final.png`** (build copies all `assets/img/*` into `dist/renderer/assets/`).  
UI: Flat Design from **`ui-ux-pro-max`** → `design-system/carcara-2-0/` (rail + tiles + activity console).  
Structure: `src/renderer/views/` (Sistema / Software / Sobre) + `src/renderer/components/` (tiles, rail, dialog, …); build bundles to `dist/renderer/renderer.js`.

## Requirements

- **Desktop user** — run the UI without sudo (`./start.sh --electron`). Privilege for apt/install goes through the helper/`pkexec`.
- **License gate** — same `carcara/app/config/license` text as 1.x; checkbox **Continuar** before the shell opens.
- [Bun](https://bun.sh) ≥ 1.1 (usually `~/.bun/bin`; `start.sh` restores it on `PATH` when needed)
- Linux desktop (or WSLg) for the window
- Already-root helper sessions skip `pkexec` (elevated smoke / accidental root)

## Environment

```bash
cd carcara-electron
cp .env.example .env   # edit as needed
```

Validated with **Zod** in `src/env.ts` (loads `.env` via `dotenv`). Notable keys: `CARCARA_LANG` (`pt`|`en`), `CARCARA_TEST_HOST` / `CARCARA_TEST_COUNT`, window size, `CARCARA_REQUIRE_ROOT`, `LIBGL_ALWAYS_SOFTWARE`. Shared strings: repo `locales/*.json` (see playbook `references/i18n.md`).

## Dev

```bash
# From repo root (recommended — no sudo):
./start.sh --electron

# Or directly:
cd carcara-electron
bun install
bun run dev
```

Default: UI as desktop user (`CARCARA_REQUIRE_ROOT=0`). If you start with `sudo`, `start.sh` re-execs as `SUDO_USER`.

| Script | What it does |
|--------|----------------|
| `bun run build` | `tsc` + copy renderer + logo (via `Bun.$`) |
| `bun run dev` | build + local `electron . --no-sandbox` |
| `bun run start` | last build |
| `bun run helper -- ping` | `testConnection.sh` → ping Google DNS IP (−c 3) |
| `bun run smoke:software` | Software wiring + bash -n + ping + pkexec probe (safe default) |
| `bun run smoke:nopasswd-install` | one-time sudoers for passwordless smoke (prompts sudo once) |
| `bun run smoke:elevated -- --live-safe` | live smoke via `sudo -n` (no password after install) |
| `bun run smoke:elevated -- --live-core` | baseline live set, passwordless after install |
| `bun run smoke:elevated -- --live-extended` | baseline + catalog sample, passwordless after install |
| `bun run smoke:software -- --pkexec --live-safe` | live via **pkexec** (unelevated user; needs `policykit-1`) |
| `bun run typecheck` | `tsc --noEmit` |
| `bun run pack:deb` | build + **electron-builder** → `release/*.deb` |
| `bun run pack:appimage` | build → `release/*.AppImage` (portable; no postinst wrapper) |
| `bun run pack:linux` | `.deb` + AppImage in one pass (CI) |
| `bun run pack:dir` | unpacked dir under `release/` (debug packaging) |

### Smoke (Software / pkexec)

Default mode does **not** install packages: it checks UI tiles ↔ helper allowlist ↔ 1.x scripts, unknown-action exit 2, unprivileged `ping`, and whether `pkexec`+display exist.

```bash
cd carcara-electron

# Safe (non-mutating) wiring check
bun run smoke:software

# --- Recommended on WSL: passwordless elevated smoke (no polkit hang) ---
bun run smoke:nopasswd-install                 # one-time (prompts sudo password once)
bun run smoke:elevated -- --live-safe          # install-git
bun run smoke:elevated -- --live-core          # baseline set
bun run smoke:elevated -- --live-extended      # baseline + catalog sample

# --- pkexec path (needs policykit; prefer a real TTY / GUI agent) ---
sudo apt install policykit-1
cd carcara-electron
# Keep Bun on PATH under sudo (bare `sudo bun` → "command not found"):
sudo env "PATH=$PATH" bun run smoke:software -- --pkexec --live-safe
# Or unelevated so polkit can prompt (NOT already-root):
bun run smoke:software -- --pkexec --live-safe
```

`smoke:elevated` uses `sudo -n` + `/etc/sudoers.d/carcara-smoke` (scoped to `smoke-software.sh` only). Prefer it over pkexec on WSL. Never bare `sudo bun …` — sudo’s `secure_path` drops `~/.bun/bin`. One harness: `smoke:software` (+ flags) — do not add `smoke:waveN`.

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
| 2.0 UI | `./start.sh --electron` (or `bun run dev` as user) |

Plan: `.agents/idea/carcara-2.0-electron.md`  
Agent how-to: `.agents/playbook/references/carcara-2.0.md`
