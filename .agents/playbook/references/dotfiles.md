# Dotfiles

| Path | Role |
|------|------|
| `.bash_aliases` | Sources `.aliases/*` (git, github, npm, pnpm, yarn) |
| `.aliases/` | Per-tool alias files |
| `Bash/cGm_.bashrc` | Custom bashrc (Ubuntu-era) |
| `Bash/DEFAULT_.bashrc` | Stock reference |
| `.oh-my-zsh/` | Powerlevel10k + Spaceship notes, `themes/cgm.zsh-theme` |
| `git/.gitconfig` | Aliases + color; keep tokens empty |
| `git/.gitignore_global` | Global ignore |
| `HyperTerminal/.hyper.js` | Hyper config |

Install guidance for agents: propose copy or symlink steps with backup of existing files; never overwrite silently.
