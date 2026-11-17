# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately):

## Planned ideas

- [x] Wave 1 Steps 1–5 — engine complete (17 de Novembro de 2026)
- [x] Wave 2 — thin installers on backends (17 de Novembro de 2026)
- [x] Cancel Wave 3 / start Electron 2.0 (17 de Novembro de 2026)
- [x] Carcará 2.0 alpha UI (modular renderer, helper wiring, Flat Design) (17 de Novembro de 2026)
- [ ] Continue [`.agents/idea/carcara-2.0-electron.md`](../.agents/idea/carcara-2.0-electron.md) — packaging `.deb` (+ software install smoke-test)

## Carcará / scripts (1.x)

- [x] Wave 1 + Wave 2 engine work
- [ ] Live smoke-test of Wave 2 installers (owner-requested machine)
- [ ] Dotfiles apply helper with `*.bak` backups
- [ ] Replace dead patterns from `old/` only when needed (docker helper refresh?)
- [ ] i18n optional (en) for menus — low priority

## Carcará 2.0

- [x] Plan + scaffold `carcara-electron/` spike (helper + apt dry-run UI)
- [x] Modular views/components + ui-ux-pro-max Flat shell
- [x] System + software helper actions wired
- [x] Dual entry via root `start.sh` + README
- [x] WSL openExternal + quieter `ping`
- [x] Smoke-test Sistema as root (sudo+Bun PATH): ping / update / fix / clean → exit 0 (17 de Novembro de 2026)
- [ ] Smoke-test Software installers (owner-requested)
- [ ] Package `.deb` for Carcará 2.0

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
