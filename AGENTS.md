# myLinux — Agent Notes

## What this repo is

Personal **Linux workstation toolkit** for Gabriel F. Vilar (CoGUMm): interactive installers, system maintenance scripts, and portable **dotfiles**.

Canonical product idea: `.agents/idea/mylinux.md`  
Playbook: `.agents/playbook/SKILL.md`

## Layout

| Path | Role |
|------|------|
| `carcara/` | Active installer UI (Bash + Zenity/Yad). Entry: `sudo bash startApp.sh` from `carcara/` |
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

Root `README.md` still mentions `init.sh` / remote pipe install — **that entrypoint is missing**. Real entry today is Carcará.

## Target environment

- **Family:** Debian/Ubuntu apt-based (Ubuntu, Debian, Linux Mint); scripts assume `apt-get` / `dpkg` / optional `snap`
- **Arch:** primarily `x86_64`
- **UI deps (Carcará):** `yad`, `zenity`, `curl`, `snap` (see `carcara/app/config/dependences.sh` — checker is buggy; treat as debt)
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
- i18n of menus: Portuguese is historical default; new user-facing strings may stay PT unless asked otherwise.
- Read `memory-bank/activeContext.md` + `memory-bank/progress.md` before coding.

## Known debt (do not paper over)

- `dependences.sh` condition is broken (`dpkg | grep -c` piped incorrectly; `which -a dependencias`)
- Several Carcará menus still say “Ainda em desenvolvimento”
- Dev installers source `. app/config.sh` in some scripts vs `. app/config/config.sh` elsewhere
- Legacy `old/scripts/*.sh` install obsolete stacks and unsafe defaults (`chmod 777 www`, hardcoded passwords)
- README `init.sh` gap vs Carcará entry

## Project guidance

| Doc | When |
|------|------|
| `.agents/playbook/` | **Default** for every task in this repo |
| `.agents/skills/shellcheck-configuration/` | When linting or hardening Bash under `carcara/` |
| `.agents/skills/` (other) | Only if installed and relevant; backlog in `memory-bank/TODO.md` |

`skills-lock.json` tracks installed optional skills.
