# Product context — myLinux

Last updated: 2026-11-16

## Users

Primary: Gabriel (CoGUMm) on Ubuntu/Debian-family machines and WSL2.  
Secondary: anyone who clones the MIT repo and accepts root risk.

## Journeys

### A — Maintain system (Carcará)

1. Clone repo, `cd carcara`, `sudo bash startApp.sh`
2. Deps script tries to ensure yad/curl/snap
3. Main menu: update, install software, fix, clean
4. Yad shows progress; terminal shows apt detail

### B — Install curated apps

1. Main menu → software categories
2. Social/Utilities menus call per-app scripts
3. Dev/Productivity menus historically stubbed — scripts already exist on disk

### C — Apply dotfiles

1. Copy or symlink from `dotfiles/` into `$HOME`
2. Source aliases from `.bash_aliases`
3. Optional oh-my-zsh theme setup per README in `.oh-my-zsh/`

### D — WSL cleanup

1. Run `./cleanup-zone-identifiers.sh [dir] [--force]`
2. Removes Windows ADS leftover `*:Zone.Identifier` files

## UX principles

- Clear Portuguese menu labels
- Root warning + disclaimer header
- Prefer confirmations before destructive clean/repair
- Incomplete features labeled honestly

## Non-goals

- Not a web product, not a payment platform, not multi-tenant SaaS
- Agents must not invent browser dashboards for this repo
