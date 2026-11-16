# Dotfiles

Portable shell and git preferences under `dotfiles/`.

## Contents

- `.bash_aliases` + `.aliases/{git,github,npm,pnpm,yarn}_aliases`
- `Bash/cGm_.bashrc`, `Bash/DEFAULT_.bashrc`
- `.oh-my-zsh` theme notes (Powerlevel10k, Spaceship) + `themes/cgm.zsh-theme`
- `git/.gitconfig`, `git/.gitignore_global`
- `HyperTerminal/.hyper.js`

## Apply (manual)

1. Backup existing `~/.bashrc`, `~/.zshrc`, `~/.gitconfig` if present.
2. Copy or symlink chosen files into `$HOME` (and `~/.aliases/` as needed).
3. Reload shell: `source ~/.bashrc` or open a new terminal.

Do not commit secrets into `git/.gitconfig`.
