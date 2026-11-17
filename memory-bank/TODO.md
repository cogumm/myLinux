# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately).  
Canonical product ideas: `.agents/idea/mylinux.md`, `.agents/idea/carcara-2.0-electron.md`.  
Also mirrored under “Still open” in `.agents/playbook/references/carcara-2.0.md` and `references/carcara.md`.

## Still open (summary)

| Track | Open item | Notes |
|-------|-----------|--------|
| **2.0** | Smoke-test Software installers via UI | Owner-requested apt/flatpak/snap |
| **2.0** | Smoke-test privileged actions with **pkexec** | Real Linux desktop / WSLg (not already-root) |
| **2.0** | Package `.deb` (AppImage optional) | Packaging only |
| **1.x** | Live smoke-test Wave 2 installers | Same machine gate as 2.0 Software |
| **1.x** | i18n (en) menus | Low priority |
| Skills | `bash-scripting`, `debian-linux-triage` | Install when rewriting that area |

Wave 1–2 engine **done**. Wave 3 **cancelled** (UI is Electron 2.0).

## Planned ideas

- [x] Wave 1 Steps 1–5 — engine complete (17 de Novembro de 2026)
- [x] Wave 2 — thin installers on backends (17 de Novembro de 2026)
- [x] Cancel Wave 3 / start Electron 2.0 (17 de Novembro de 2026)
- [x] Carcará 2.0 alpha UI (modular renderer, helper wiring, Flat Design) (17 de Novembro de 2026)
- [x] Env Zod + `.env.example` in `carcara-electron/` (17 de Novembro de 2026)
- [x] Dotfiles menus (1.x + 2.0) + license gate 2.0 (17 de Novembro de 2026)
- [x] Session knowledge consolidated → memory-bank + playbook (17 de Novembro de 2026)
- [ ] Continue [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — Software/pkexec smoke-test + packaging `.deb`

## Carcará / scripts (1.x)

- [x] Wave 1 + Wave 2 engine work
- [ ] Live smoke-test of Wave 2 installers (owner-requested machine)
- [x] Harden / rewrite `dependences.sh` (apt-family, update, Flathub, NI) (17 de Novembro de 2026)
- [x] Dotfiles apply helper with `*.bak` backups (`dotfiles/apply.sh`) (17 de Novembro de 2026)
- [x] Menu 1.x **Dotfiles** → `applyDotfiles.sh` as `$SUDO_USER` (17 de Novembro de 2026)
- [x] Port Docker from `old/scripts/docker.sh` → modern `development/docker.sh` (+ 1.x/2.0 menus) (17 de Novembro de 2026)
- [ ] i18n optional (en) for menus — low priority

## Carcará 2.0

- [x] Plan + scaffold `carcara-electron/` spike (helper + apt dry-run UI)
- [x] Modular views/components + ui-ux-pro-max Flat shell
- [x] System + software helper actions wired
- [x] Dual entry via root `start.sh` + README
- [x] WSL openExternal + quieter `ping`
- [x] Env: `.env.example` + Zod/`dotenv` (`src/env.ts`)
- [x] Smoke-test Sistema as root (sudo+Bun PATH): ping / update / fix / clean → exit 0 (17 de Novembro de 2026)
- [x] Dotfiles rail + helper `dotfiles-*` (unprivileged / as `$SUDO_USER`) (17 de Novembro de 2026)
- [x] License gate (1.x parity; checkbox Continuar) (17 de Novembro de 2026)
- [ ] Smoke-test Software installers (owner-requested)
- [ ] Smoke-test with **pkexec** on real desktop / WSLg (unelevated user → elevates)
- [ ] Package `.deb` for Carcará 2.0 (AppImage optional)

## Future agent skills (skills.sh) — install when modernizing that area

Incremental modernization; do **not** install everything at once. Playbook stays canonical: `.agents/playbook/`.

| Priority | Skill | Install | When it helps |
|----------|--------|---------|----------------|
| Done | `shellcheck-configuration` (`wshobson/agents`) | installed → `.agents/skills/shellcheck-configuration` | Lint/harden Carcará Bash during script rewrites |
| Done | `ui-ux-pro-max` | installed → `.agents/skills/ui-ux-pro-max` | Carcará 2.0 design-system / Flat Design |
| Next | `bash-scripting` (`sickn33/agentic-awesome-skills`) | `npx skills add sickn33/agentic-awesome-skills@bash-scripting` | Defensive scripting patterns when rewriting installers / menus |
| Later | `debian-linux-triage` (`github/awesome-copilot`) | `npx skills add github/awesome-copilot@debian-linux-triage` | Safer apt/dpkg/systemd flows in `updateDistro` / `fixSystem` / `cleanDistro` |

Links:

- https://skills.sh/wshobson/agents/shellcheck-configuration
- https://skills.sh/sickn33/agentic-awesome-skills/bash-scripting
- https://skills.sh/github/awesome-copilot/debian-linux-triage
