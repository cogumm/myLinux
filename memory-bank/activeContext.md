# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0.1 closed** — ready for **v2.0.2** work when scoped in `memory-bank/TODO.md`.

| Surface | State |
|---------|--------|
| **2.0** (`carcara-electron/`, package **`2.0.1`**) | Usable alpha: UI, helper, license, Dotfiles, i18n, Software catalog, smoke |
| **1.x** (`carcara/`) | Install/maintenance **engine** + CLI/fallback |
| **Packaging** | `.deb` + AppImage; GHA `release-deb.yml` on Release / `workflow_dispatch` |
| **Default branch** | `main` |
| **Smoke** | `smoke:software` + `smoke:elevated` (after one-time `smoke:nopasswd-install`) |

Next release: bump version → `docs/releases/2.0.2.md` → tag `v2.0.2` (see `systemPatterns` #16).

## Canonical agent how-to

| Doc | Role |
|------|------|
| `.agents/playbook/references/carcara-2.0.md` | 2.0 UI, helper, packaging, WSL, smoke |
| `.agents/playbook/references/carcara.md` | 1.x menus, backends, `carcara_confirm` |
| `.agents/playbook/references/dotfiles.md` | `apply.sh` + menus |
| `.agents/playbook/references/i18n.md` | Nested locales + `{version}` + rail PT\|EN |
| `.agents/playbook/references/legacy.md` | `old/` — port ideas only |
| `.agents/playbook/references/stack.md` | Entrypoints + toolchain |
| `design-system/carcara-2-0/pages/app-shell.md` | Rail / tiles / pager / lang |
| `memory-bank/TODO.md` | Inbox (**v2.0.2** empty) |
| `docs/releases/2.0.1.md` | What shipped in 2.0.1 |

## Shipped in 2.0.1 (do not re-open without cause)

- Waves A–C thin installers + helper allowlist + 2.0 tiles/locales
- Software: 19 Snap Store categories, search, backend badges, pagination 6/page, presets
- Sistema: update / fix / clean / sync-time; Dotfiles rail; license gate
- Packaging: `pack:deb` / `pack:appimage` / `pack:linux`; CI attaches both
- Smoke: wiring + `bash -n` + `--live-core` / `--live-extended` + passwordless elevated path
- Skills: shellcheck, ui-ux-pro-max, bash-scripting, debian-linux-triage

## Validated

- Sistema as root: update / fix / clean → exit 0
- `bun run typecheck` + `build` + `pack:deb` / `pack:appimage`
- Owner `--live-core` smoke (sudo + preserved `PATH`)
- Release `v2.0.1` + `.deb` on GitHub

## Standing notes (not backlog)

- Already-root → helper skips `pkexec` (expected). Prefer `smoke:elevated` on WSL.
- Never bare `sudo bun` — use `sudo env "PATH=$PATH" bun …` or `smoke:elevated`.
- Bash i18n flatten needs **python3**.
- `electron-builder.yml` stays under `carcara-electron/` (not `.github/workflows/`).
- FPM: avoid `${LetterOnly}` macros in afterInstall scripts.
- Do not live-install `.deb` / mutate apt unless the owner asks in that message.
