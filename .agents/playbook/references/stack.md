# Stack

## 1.x (engine + CLI/TUI)

- Bash scripts under `carcara/` and root helpers.
- Zenity + Yad for TUI; apt/dpkg + Flatpak + snap for packages.
- Config: `carcara/app/config/config.sh` + `install_backends.sh`.
- Entry: `cd carcara && sudo bash startApp.sh`
- Deps bootstrap: `dependences.sh` + `testConnection.sh`

## 2.0 (product UI)

- Electron + TypeScript + vanilla renderer under `carcara-electron/`
- **Bun** toolchain (`bun install`, `bun run`, [Shell `$`](https://bun.sh/docs/runtime/shell))
- Privilege: `scripts/run-helper.ts` (Bun.$) → `helper/carcara-helper.sh` + `pkexec`
- Entry: `cd carcara-electron && bun run dev`
- Plan: `.agents/idea/carcara-2.0-electron.md`

## Shared

- Dotfiles are static config, not generated.
- Optional: `cleanup-zone-identifiers.sh` for WSL ADS junk files.
