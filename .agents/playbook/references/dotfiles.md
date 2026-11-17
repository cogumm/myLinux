# Dotfiles

| Path | Role |
|------|------|
| `apply.sh` | Non-root apply helper — `*.bak` backups, `--dry-run` / `--symlink` / modules |
| `.bash_aliases` | Sources `.aliases/*` (git, github, npm, pnpm, yarn) |
| `.aliases/` | Per-tool alias files |
| `Bash/cGm_.bashrc` | Custom bashrc (Ubuntu-era); only via `./apply.sh --bashrc` |
| `Bash/DEFAULT_.bashrc` | Stock reference |
| `.oh-my-zsh/` | Powerlevel10k + Spaceship notes, `themes/cgm.zsh-theme` |
| `git/.gitconfig` | Aliases + color; keep tokens empty |
| `git/.gitignore_global` | Global ignore |
| `HyperTerminal/.hyper.js` | Hyper config |

## Apply rules

- Entry: `dotfiles/apply.sh` (never `sudo`).
- Default module: `--aliases`. `--all` = aliases + git + hyper + theme (not bashrc).
- Always backup before overwrite (`*.bak` / `*.bak.<timestamp>`).
- Skip when destination already matches source (copy or symlink).
- Theme skipped if `~/.oh-my-zsh/themes` is absent.
- Operator docs: `docs/dotfiles.md`.
