# Stack

- Bash scripts under `carcara/` and root helpers.
- Zenity + Yad for TUI; apt/dpkg/snap for packages.
- Dotfiles are static config, not generated.
- Entry: `cd carcara && sudo bash startApp.sh`
- Config: `carcara/app/config/config.sh` (`dirSof`, `dirSys`, `menuApp`, Yad presets, `head`, `isRoot`).
- Deps bootstrap: `dependences.sh` + `testConnection.sh` (needs repair).
- Optional: `cleanup-zone-identifiers.sh` for WSL ADS junk files.
