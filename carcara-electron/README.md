# Carcará 2.0 (Electron + Bun)

Desktop UI for myLinux. Install **engine** stays in Bash 1.x (`../carcara/`).  
Toolchain and privilege bridge use **[Bun](https://bun.sh/docs)** (including [`Bun` Shell](https://bun.sh/docs/runtime/shell)).

Electron’s main process still runs Chromium’s Node; it spawns `bun scripts/run-helper.ts`, which uses `$` to call the allowlisted `helper/carcara-helper.sh` (via `pkexec` when needed).

Logo: **`assets/img/logo_moderno_final.png`** (build copies all `assets/img/*` into `dist/renderer/assets/`).  
UI: Flat Design from **`ui-ux-pro-max`** → `design-system/carcara-2-0/` (rail + tiles + activity console).  
Structure: `src/renderer/views/` (Sistema / Software / Sobre) + `src/renderer/components/` (tiles, rail, dialog, …); build bundles to `dist/renderer/renderer.js`.

## Requirements

- **Root / sudo** — same policy as Carcará 1.x (`isRoot`). Prefer `sudo ./start.sh --electron` from the repo root.
- [Bun](https://bun.sh) ≥ 1.1 (`curl -fsSL https://bun.sh/install | bash`)
- Linux desktop (or WSLg) for the window
- Already-root sessions skip `pkexec` for helper actions

## Dev

```bash
# From repo root (recommended — elevates like 1.x):
sudo ./start.sh --electron

# Or already as root:
cd carcara-electron
bun install
bun run dev
```

`electron` / `bun run start` exit if uid ≠ 0.

| Script | What it does |
|--------|----------------|
| `bun run build` | `tsc` + copy renderer + logo (via `Bun.$`) |
| `bun run dev` | build + local `electron . --no-sandbox` |
| `bun run start` | last build |
| `bun run helper -- ping` | `testConnection.sh` → ping Google DNS IP (−c 3) |
| `bun run typecheck` | `tsc --noEmit` |

`--no-sandbox` is required on many WSL/Linux setups where `chrome-sandbox` is not root-owned (SUID). Prefer fixing sandbox ownership on a real desktop install when packaging.

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
