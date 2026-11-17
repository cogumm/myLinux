# Carcará 2.0 (Electron + Bun)

Desktop UI for myLinux. Install **engine** stays in Bash 1.x (`../carcara/`).  
Toolchain and privilege bridge use **[Bun](https://bun.sh/docs)** (including [`Bun` Shell](https://bun.sh/docs/runtime/shell)).

Electron’s main process still runs Chromium’s Node; it spawns `bun scripts/run-helper.ts`, which uses `$` to call the allowlisted `helper/carcara-helper.sh` (via `pkexec` when needed).

## Requirements

- [Bun](https://bun.sh) ≥ 1.1 (`curl -fsSL https://bun.sh/install | bash`)
- Linux desktop (or WSLg) for the window
- `pkexec` for elevation when not already root (apt dry-run)

## Dev

```bash
cd carcara-electron
bun install
bun run dev
```

| Script | What it does |
|--------|----------------|
| `bun run build` | `tsc` + copy renderer assets (via `Bun.$`) |
| `bun run dev` | build + local `electron . --no-sandbox` |
| `bun run start` | last build |

`--no-sandbox` is required on many WSL/Linux setups where `chrome-sandbox` is not root-owned (SUID). Prefer fixing sandbox ownership on a real desktop install when packaging.
| `bun run helper -- ping` | test Bun bridge without UI |
| `bun run typecheck` | `tsc --noEmit` |

## Spike

Window with **Ping helper** and **Apt dry-run** (`apt-get update` + `apt-get -s upgrade`). No package changes on dry-run.

## Dual entry

| Track | Entry |
|-------|--------|
| 1.x CLI/TUI | `cd carcara && sudo bash startApp.sh` |
| 2.0 UI | `cd carcara-electron && bun run dev` |

Plan: `.agents/idea/carcara-2.0-electron.md`
