# Tech context — myLinux

Last updated: 2026-11-16

## Runtime

| Layer | Choice |
|-------|--------|
| Shell | Bash |
| UI | Zenity lists, Yad progress/dialogs |
| Packages | apt-get, dpkg, snap (selected apps) |
| VCS | Git |
| Host | Linux apt-family; WSL2 for helper script |

## Key paths

- `carcara/startApp.sh`
- `carcara/app/config/{config,dependences,menuGeral,testConnection,license}.sh`
- `carcara/app/scripts/system/*`
- `carcara/app/scripts/software/**`
- `dotfiles/**`
- `old/**` (archive)
- `cleanup-zone-identifiers.sh`

## Commands agents use for validation

```bash
# Syntax check a script
bash -n carcara/app/config/config.sh

# List menus / installers
find carcara -name '*.sh' | sort

# Optional if shellcheck installed
shellcheck -x carcara/startApp.sh
```

Do **not** run live `sudo bash startApp.sh` or apt mutations unless the owner asks.

## Constraints

- No application web stack in this product — Bash/TUI only
- No npm-based app toolchain required for Carcará
- `skills-lock.json` may be empty
- Funding: `.github/FUNDING.yml` → ko_fi cogumm
