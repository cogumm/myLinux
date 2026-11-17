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

## Carcará menus

| Track | Entry | How |
|-------|--------|-----|
| 1.x | `menuGeral` → **Dotfiles** | `applyDotfiles.sh` Zenity submenu → `sudo -u "$SUDO_USER" apply.sh …` |
| 2.0 | Rail **Dotfiles** | Helper `dotfiles-*` (unprivileged) → `_run_dotfiles_apply` as `$SUDO_USER` |

If `SUDO_USER` is missing while uid=0, fail clearly — do not write into `/root`.
