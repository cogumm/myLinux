<h1 align="center">myLinux</h1>

<p align="center">
  Personal 🐧 Linux workstation toolkit — installers, maintenance scripts, and dotfiles.
</p>

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/cogumm/mylinux?color=%2304D361">
  <img alt="Repository size" src="https://img.shields.io/github/repo-size/cogumm/mylinux">
  <a href="https://github.com/cogumm/mylinux/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/cogumm/mylinux">
  </a>
  <a href="#memo-license">
    <img alt="License" src="https://img.shields.io/badge/license-MIT-brightgreen">
  </a>
  <a href="https://github.com/cogumm/mylinux/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/cogumm/mylinux?style=social">
  </a>
</p>

<p align="center">
  <a href="#what-is-this">What is this</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#requirements">Requirements</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#quick-start">Quick start</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#repository-layout">Layout</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#docs">Docs</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#how-to-contribute">Contribute</a>&nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="#memo-license">License</a>
</p>

---

## What is this

**myLinux** is a personal toolkit for Debian/Ubuntu-family machines (and WSL2 helpers):

| Piece | Role |
|-------|------|
| **[Carcará](carcara/README.md)** | Interactive installer / maintenance UI (Bash + Zenity/Yad) |
| **`dotfiles/`** | Shell aliases, Bash/Zsh themes, git template, Hyper |
| **`old/`** | Frozen legacy scripts — archive only |
| **`cleanup-zone-identifiers.sh`** | Remove Windows `*:Zone.Identifier` junk on WSL |

Target: **apt-based** distros (Ubuntu, Debian, Linux Mint), primarily `x86_64`.

> **Disclaimer:** many scripts need **root** and can change your system. Review them before running. Use only if you understand what they do. The author is not responsible for damage from misuse.

## Requirements

- Git
- `sudo` / root for Carcará system menus
- UI deps (Carcará tries to install these): `yad`, `zenity`, `curl`, optional `snap`

```bash
sudo apt install git
```

Optional: configure your Git identity before cloning.

```bash
git config --global user.name 'Your name'
git config --global user.email 'you@example.com'
```

## Quick start

### Carcará (installer / maintenance)

```bash
git clone https://github.com/cogumm/myLinux.git
cd myLinux/carcara
sudo bash startApp.sh
```

Main menu covers system update, software install, repair, and cleanup. See [carcara/README.md](carcara/README.md) for the tree and menu map.

### Dotfiles

Copy or symlink files from [`dotfiles/`](dotfiles/) into `$HOME` after backing up what you already have. Details: [docs/dotfiles.md](docs/dotfiles.md).

### WSL cleanup

```bash
./cleanup-zone-identifiers.sh              # current directory
./cleanup-zone-identifiers.sh /path/to/dir
./cleanup-zone-identifiers.sh /path -f     # non-interactive
```

See [docs/wsl-cleanup.md](docs/wsl-cleanup.md).

## Repository layout

```
.
├── carcara/                      # Active TUI installer (entry: startApp.sh)
├── dotfiles/                     # Aliases, bashrc, oh-my-zsh, git, Hyper
├── old/                          # Legacy archive (do not extend)
├── cleanup-zone-identifiers.sh   # WSL helper
├── docs/                         # Operator docs
├── design-system/carcara/        # TUI UX notes
├── AGENTS.md                     # Agent entry
├── .agents/                      # Agent-agnostic idea + playbook + skills
├── .cursor/rules/                # Cursor adapter
└── .claude/rules/                # Claude Code adapter (same policies)
```

## Docs

- [Overview](docs/overview.md)
- [Carcará](docs/carcara.md)
- [Dotfiles](docs/dotfiles.md)
- [Legacy `old/`](docs/legacy.md)
- [WSL cleanup](docs/wsl-cleanup.md)
- [AGENTS.md](AGENTS.md) — for coding agents

## How to contribute

- Fork this project
- Create a branch: `git checkout -b my-feature`
- Commit: `git commit -m 'feat: My new feature'`
- Push: `git push origin my-feature`
- Open a pull request

Prefer improving `carcara/` or `dotfiles/` over adding new top-level trees. Leave `old/` as archive.

## :memo: License

This project is under the MIT license (Copyright (c) 2010 CoGUMm). See [LICENSE][license].

Made with ♥ by Gabriel F. Vilar :wave: [Ko-fi][kofi]

[license]: https://cogumm.mit-license.org/
[telegram]: https://t.me/CoGUMm
[kofi]: https://ko-fi.com/cogumm
