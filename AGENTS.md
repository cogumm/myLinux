# myLinux — Agent Notes

## What this repo is

Personal **Linux workstation toolkit** for Gabriel F. Vilar (CoGUMm): interactive installers, system maintenance scripts, and portable **dotfiles**.

Canonical product idea: `.agents/idea/mylinux.md`  
Playbook: `.agents/playbook/SKILL.md`

## Layout

| Path | Role |
|------|------|
| `start.sh` | Dual entry: choose Electron 2.0 or terminal 1.x (`--electron` / `--terminal`) |
| `assets/` | Images for 1.x + 2.0 (`img/logo_moderno_final.png` + variants) |
| `carcara/` | 1.x install engine + CLI/TUI (Bash + Zenity/Yad). Entry: `sudo bash startApp.sh` from `carcara/` |
| `carcara-electron/` | 2.0 desktop UI (Electron + Bun). Entry: `cd carcara-electron && bun run dev` |
| `dotfiles/` | Shell aliases, Bash/Zsh themes, git config, Hyper |
| `old/` | Frozen legacy (dialog Ubuntu packagers, Docker helper). **Archive** — migrate useful bits into `carcara/`, do not grow this tree |
| `cleanup-zone-identifiers.sh` | WSL/Windows `:Zone.Identifier` cleanup |
| `.github/FUNDING.yml` | Ko-fi (`cogumm`) |
| `docs/` | Operator docs for this repo |
| `memory-bank/` | Agent memory (read at task start) |
| `design-system/carcara/` | TUI/CLI UX notes for Yad/Zenity menus |
| `.agents/` | **Agent-agnostic** idea + playbook (+ optional skills) |
| `.cursor/rules/` | Cursor rules adapter (points at `.agents/`) |
| `.claude/rules/` | Claude Code rules (same policies as `.cursor/rules/`) |

Root entry: `./start.sh` (choose Electron vs terminal). Optional bootstrap: `curl …/master/start.sh | bash` (clones then re-execs; owner-requested UX). Direct: `cd carcara && sudo bash startApp.sh` or `cd carcara-electron && bun run dev`.

## Target environment

- **Family:** Debian/Ubuntu apt-based (Ubuntu, Debian, Linux Mint); scripts assume `apt-get` / `dpkg` / optional `snap`
- **Arch:** primarily `x86_64`
- **UI deps (Carcará):** `yad`, `zenity`, `curl`, `iputils-ping`; optional `snap` / `flatpak`+Flathub via hardened `dependences.sh`
- **WSL2:** relevant for Zone.Identifier cleanup and mixed Windows/Linux paths
- **Privilege:** system install/clean/fix scripts require **root** (`isRoot` in `config.sh`)

## Agent role

Act as a **Linux systems analysis & development** specialist:

- Bash scripting, apt/dpkg/snap, systemd basics, WSL quirks
- Safe packaging and idempotent installers
- Dotfiles that are portable and non-destructive
- Clear TUI flows (Zenity lists / Yad progress)

## Hard rules

- Prefer **editing existing scripts** under `carcara/` and `dotfiles/`. New files need a one-line justification.
- **`old/` is read-mostly.** Port patterns forward; do not add new features there.
- Never run `sudo`, destructive apt, `rm -rf` on system paths, or Carcará against the live machine unless the owner **explicitly** asks in that message.
- Destructive or credential-touching scripts must be **opt-in** (flags / confirmations), not silent.
- Prefer `set -euo pipefail` (or documented exceptions), quoted variables, and `command -v` over brittle `which` / `grep -c` chains.
- Detect distro via `/etc/os-release` (improve on `old/scripts/checkDistro.sh`); do not hardcode Ubuntu 14.04-era packages (PHP5, MySQL 5.6, dead PPAs).
- **Never `git commit` or `git push` unless the owner asks in that message.** Do not change `git config`.
- No secrets in the repo. `dotfiles/git/.gitconfig` may contain empty github token placeholders — keep them empty; never fill real tokens.
- i18n: Portuguese default; English via `CARCARA_LANG=en` — shared `locales/*.json` (see playbook `references/i18n.md`).
- Read `memory-bank/activeContext.md` + `memory-bank/progress.md` before coding.

## Known debt (do not paper over)

- Legacy `old/scripts/*.sh` install obsolete stacks and unsafe defaults (`chmod 777 www`, hardcoded passwords)
- Wave 1 + Wave 2 done (1.x engine). Wave 3 cancelled — product UI is Electron 2.0
- Active: Carcará 2.0 **usable alpha** (`carcara-electron/`) — license gate, Dotfiles rail, Zod env, Sistema smoke OK; see playbook `references/carcara-2.0.md` + `memory-bank/activeContext.md`
- 1.x `menuGeral`: Atualizar / Instalar / Correção / Limpeza / **Dotfiles** / Sair
- `dependences.sh` hardened 17 Nov 2026 (apt-family detect, apt update, Flathub, NI-safe notify)
- Wave 2 installers / 2.0 privileged actions not fully smoke-tested live (needs owner-requested apt/flatpak/snap + pkexec)
- WSL: no `pkexec` → privileged helper runs unelevated (apt locks fail); use real desktop for elevation tests
- Packaging `.deb` still open

## Project guidance

| Doc | When |
|------|------|
| `.agents/playbook/` | **Default** for every task in this repo |
| `.agents/playbook/references/carcara-2.0.md` | Electron 2.0 UI, Bun, helper, WSL |
| `.agents/skills/ui-ux-pro-max/` | 2.0 visual direction / design-system |
| `.agents/skills/shellcheck-configuration/` | When linting or hardening Bash under `carcara/` |
| `.agents/skills/` (other) | Only if installed and relevant; backlog in `memory-bank/TODO.md` |

`skills-lock.json` tracks installed optional skills.
