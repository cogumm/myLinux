# TODO — myLinux inbox

Last updated: 2026-11-17

Unscheduled ideas (promote into active work deliberately).  
Canonical product ideas: `.agents/idea/mylinux.md`, `.agents/idea/carcara-2.0-electron.md`.  
Session dump: `memory-bank/activeContext.md`.

## Still open (summary)

| Track | Open item | Notes |
|-------|-----------|--------|
| **2.0.2** | Electron UI must not run as root | `sudo ./start.sh --electron` breaks X11/Wayland on real desktops (yavin report) |

**v2.0.1 shipped** (catalog A–C, `.deb`+AppImage+CI, smoke/`smoke:elevated`, i18n, Dotfiles, license).  
Default branch: **`main`**. Release pattern: `docs/releases/X.Y.Z.md` → commit → tag `vX.Y.Z`.  
When work starts: bump `carcara-electron/package.json` → `2.0.2`; add `docs/releases/2.0.2.md` before tag.

## v2.0.2 — inbox

### Electron as desktop user (not root) — host report yavin

**Symptom** (`sudo ./start.sh --electron` on a normal Linux GUI session):

- `Authorization required, but no authorization protocol specified`
- D-Bus: `Could not parse server address: Unknown address type`
- GPU: `libGLESv2.so` → *Permissão negada*; `XGetWindowAttributes failed`

**Cause:** `start.sh` `run_electron` elevates the whole Electron/`bun run dev` process to root (1.x-style). Root lacks the user’s X cookie / session bus; GPU libs under the user’s `node_modules` are not readable/executable as expected. WSL XAUTHORITY salvage in `start.sh` does not cover native Linux desktops.

**Target design (v2.0.2):**

- [ ] Run Electron / `bun run dev` as the **invoking desktop user** (`SUDO_USER` or plain user) — never as UID 0 for the GUI
- [ ] Keep privilege only on the **helper** path (`pkexec` / allowlisted `run-helper`) for apt/install/fix/clean — same model as packaged `.deb`
- [ ] Change `start.sh`: drop `require_root_or_sudo` for `--electron`; if started with `sudo`, re-exec as `SUDO_USER` with `DISPLAY` / `XAUTHORITY` / `WAYLAND_DISPLAY` / `DBUS_SESSION_BUS_ADDRESS` / `XDG_RUNTIME_DIR` from the user session
- [ ] Docs/UX: `./start.sh --electron` (no sudo); warn if already root; update README / playbook `carcara-2.0.md` / idea status
- [ ] Smoke: GUI launch check (or documented manual) on native Linux + keep `smoke:elevated` for backends only

**Workaround until fixed:** run without sudo — `cd carcara-electron && bun run dev` (privileged actions still via helper/pkexec when the UI requests them).

### Other

- _(none yet — add as scoped)_

## Planned ideas (historical — done)

- [x] Wave 1–2 engine + cancel Wave 3 / Electron 2.0 (17 de Novembro de 2026)
- [x] Carcará 2.0 alpha UI + Zod + Dotfiles + license + i18n + sync-time (17 de Novembro de 2026)
- [x] Package `.deb` + AppImage + Release CI; `{version}` in locales (17 de Novembro de 2026)
- [x] **v2.0.1** Waves A–C catalog + Software UX (search/badges/pager/Sobre health) (17 de Novembro de 2026)
- [x] Software smoke harness + `--live-core` / `--live-extended` + `smoke:elevated` (17 de Novembro de 2026)

## Carcará 1.x / 2.0 (v2.0.1 closed)

All checklist items for 1.x engine + 2.0 alpha through v2.0.1 packaging/smoke are **done**.  
Detail: `memory-bank/progress.md`, `docs/releases/2.0.1.md`, playbook `carcara-2.0.md`.

### Smoke (operator)

```bash
cd carcara-electron
bun run smoke:software
bun run smoke:nopasswd-install          # one-time
bun run smoke:elevated -- --live-safe
bun run smoke:elevated -- --live-extended
```

### Explicitly out of v2.0.1 (still not goals unless re-opened)

- Snap Store mirror / install-everything
- LAMP PHP5 / RVM / Atom / dead PPAs from `old/`
- Popcorn, Skype i386, Docky, Ubuntu-Tweak, tutum Docker helpers
- Archive tools / GIMP / Slack / Signal / `gh` — only if promoted into a future TODO section

## Agent skills (skills.sh)

| Status | Skill | Path |
|--------|--------|------|
| Done | `shellcheck-configuration` | `.agents/skills/shellcheck-configuration` |
| Done | `ui-ux-pro-max` | `.agents/skills/ui-ux-pro-max` |
| Done | `bash-scripting` | `.agents/skills/bash-scripting` |
| Done | `debian-linux-triage` | `.agents/skills/debian-linux-triage` |

Playbook stays canonical: `.agents/playbook/`. Usage: `.agents/skills/README.md`.
