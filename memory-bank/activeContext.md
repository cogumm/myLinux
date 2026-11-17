# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**v2.0.2 in progress** — Electron UI as desktop user (code landed; await yavin GUI confirm).

| Surface | State |
|---------|--------|
| **2.0** (`carcara-electron/`, package **`2.0.1`**) | Desktop-user Electron; light shell + aligned brand band; `CARCARA_REQUIRE_ROOT` default `0` |
| **1.x** (`carcara/`) | Install/maintenance **engine** + CLI/fallback (still root) |
| **Packaging** | `.deb` + AppImage; GHA `release-deb.yml` on Release / `workflow_dispatch` |
| **Default branch** | `main` |
| **Smoke** | `smoke:software` + `smoke:elevated` (after one-time `smoke:nopasswd-install`) |

**Next (inbox):** GUI smoke yavin; Software **Todas/All**; resizable activity console — see `memory-bank/TODO.md`. Tag when cutting: bump → `docs/releases/2.0.2.md` → `v2.0.2`.

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
| `docs/releases/2.0.2.md` | In-progress 2.0.2 (Electron as desktop user) |

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
- Electron GUI: desktop user only; `start.sh` drops root → `SUDO_USER` when needed.
- Bash i18n flatten needs **python3**.
- `electron-builder.yml` stays under `carcara-electron/` (not `.github/workflows/`).
- FPM: avoid `${LetterOnly}` macros in afterInstall scripts.
- Do not live-install `.deb` / mutate apt unless the owner asks in that message.
