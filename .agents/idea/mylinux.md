# myLinux — product idea

## What it is

Personal **Linux environment** toolkit (Debian/Ubuntu family + WSL): interactive **Carcará** installer, **dotfiles** (shell/git/terminal), and maintenance helpers.

Author: Gabriel F. Vilar (CoGUMm) · repo: `github.com/cogumm/myLinux` · MIT license · Ko-fi support.

## Problem

Reinstalling or standardizing a workstation takes time: updates, package repair, cleanup, curated dev/social/utility apps, and shell/git setup. Legacy code in `old/` solved this with `dialog` and outdated stacks; **Carcará** is the active line with Zenity/Yad.

## Proposal

1. **Carcará** — root menu to update, install software, repair, and clean.
2. **Dotfiles** — aliases (git/npm/pnpm/yarn/github), bashrc, oh-my-zsh themes (Powerlevel10k / Spaceship / cgm), Hyper, gitconfig template.
3. **Helpers** — focused scripts (e.g. remove `*:Zone.Identifier` on WSL).
4. **Archive** — `old/` stays as historical reference.

## Audience

Personal use by the author, plus anyone who clones the repo **at their own risk**, aware of the root disclaimer.

## Out of scope

Web application, payments, multi-user SaaS, equal support for every distro.

## Modernization direction

- Single documented entrypoint (today: `carcara/startApp.sh`; README still mentions missing `init.sh`).
- Incomplete menus wired to existing installers (`development/`, `social/`, `utilities/`).
- Correct, idempotent dependency detection.
- Packages and PPAs brought up to date (no PHP5 / MySQL 5.6 / dead links).
- Dotfiles installable without overwriting `$HOME` without confirmation.
