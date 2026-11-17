# Dotfiles

Portable shell and git preferences under `dotfiles/`.

## Contents

- `.bash_aliases` + `.aliases/{git,github,npm,pnpm,yarn}_aliases`
- `Bash/cGm_.bashrc`, `Bash/DEFAULT_.bashrc`
- `.oh-my-zsh` theme notes (Powerlevel10k, Spaceship) + `themes/cgm.zsh-theme`
- `git/.gitconfig`, `git/.gitignore_global`
- `HyperTerminal/.hyper.js`

## Apply (helper)

Non-destructive installer with `*.bak` backups. **Do not run as root.**

```bash
cd dotfiles
./apply.sh --dry-run --all    # preview
./apply.sh --aliases          # default if no module flags
./apply.sh --all              # aliases + git + hyper + theme
./apply.sh --symlink --git    # symlink instead of copy
./apply.sh --bashrc           # opt-in: replaces ~/.bashrc after .bak
```

| Flag | What it installs |
|------|------------------|
| `--aliases` | `~/.bash_aliases`, `~/.aliases/*` |
| `--git` | `~/.gitconfig`, `~/.gitignore_global` |
| `--hyper` | `~/.hyper.js` |
| `--theme` | `~/.oh-my-zsh/themes/cgm.zsh-theme` (skips if oh-my-zsh missing) |
| `--bashrc` | `~/.bashrc` from `Bash/cGm_.bashrc` (not in `--all`) |
| `--all` | aliases + git + hyper + theme |
| `--symlink` | `ln -sfn` instead of `cp -a` |
| `--dry-run` | log only |

Existing targets become `path.bak` (or `path.bak.<timestamp>` if `.bak` already exists).  
Reload the shell after aliases change. Keep tokens empty in `git/.gitconfig`.
