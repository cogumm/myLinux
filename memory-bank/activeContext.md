# Active context — myLinux

Last updated: 2026-11-17

## Current focus

**Carcará 2.0 is usable alpha** (`carcara-electron/`: Electron + Bun + modular vanilla renderer).  
**1.x** (`carcara/`) remains the install/maintenance **engine** and CLI/fallback (Waves 1–2 done; Wave 3 cancelled).

Canonical agent how-to for this state:

| Doc | Role |
|-----|------|
| `.agents/playbook/references/carcara-2.0.md` | 2.0 operator + agent how-to (full) |
| `.agents/playbook/references/carcara.md` | 1.x menus, backends, `carcara_confirm` |
| `.agents/playbook/references/dotfiles.md` | `apply.sh` + menu wiring |
| `.agents/playbook/references/i18n.md` | Shared `locales` + `CARCARA_LANG` |
| `.agents/idea/carcara-2.0-electron.md` | Locked decisions + checklist |
| `design-system/carcara-2-0/pages/app-shell.md` | Rail / tiles / license / hover rules |
| `memory-bank/TODO.md` | Still-open inbox |

## Session knowledge dump (17 Nov 2026) — late session

### Env (Zod)

- `carcara-electron/.env.example` → copy to `.env` (gitignored; `!.env.example` kept).
- Schema: `src/env.ts` (`dotenv` + **Zod 4**). Use `z.prettifyError()` — **not** deprecated `error.flatten()`.
- Wired: `main.ts` (window size, `CARCARA_REQUIRE_ROOT`, lang), `scripts/run-helper.ts` (lang + ping → Bash).
- Keys: `CARCARA_LANG` (`pt`|`en`), `CARCARA_TEST_HOST` / `CARCARA_TEST_COUNT`, window dims, `CARCARA_REQUIRE_ROOT`, `LIBGL_ALWAYS_SOFTWARE`.

### UI polish (tiles)

- Featured/orange permanent tile borders removed.
- Extra teal left bar + stronger border = **hover only** (`.tile:hover`).
- Accent orange `#EA580C` reserved for **confirm CTA** buttons (`btn--accent`), not tile chrome.
- Rail order: Sistema · Software · **Dotfiles** · Sobre.

### License gate (2.0 = 1.x parity)

- Same file: `carcara/app/config/license`.
- Gate before shell: checkbox **Continuar** → **Aceitar e continuar**; **Sair** → IPC `app:quit`.
- Component: `src/renderer/components/license-gate.ts`; boot in `main.ts` (renderer).
- IPC: `license:get`, `app:quit`; build also copies `license.txt` into `dist/renderer/`.

### Confirms as root (`carcara_confirm`)

- Shared in `install_backends.sh`: **root** or `CARCARA_NONINTERACTIVE=1` → auto-yes (log `auto-yes:`); no terminal `[y/N]`.
- Used by `updateDistro.sh` / `cleanDistro.sh` (incl. locks + apt lists when root/NI).
- UI/menu choice is the user confirmation; 2.0 still uses `<dialog>` before mutating helper actions.
- `testConnection.sh` retry uses Yad buttons (no terminal `read` under sudo).

### Dotfiles

- CLI: `dotfiles/apply.sh` — **never root**; `*.bak` / `*.bak.<timestamp>`; `--dry-run` / `--symlink` / modules.
- `--all` = aliases + git + hyper + theme (**not** bashrc). `--bashrc` opt-in.
- **1.x:** `menuGeral` → Dotfiles → `applyDotfiles.sh` (Zenity submenu) → `sudo -u "$SUDO_USER" apply.sh …`.
- **2.0:** rail Dotfiles → tiles → helper `dotfiles-*` (unprivileged set in `run-helper.ts`) → `_run_dotfiles_apply` as `$SUDO_USER`.
- Docs: `docs/dotfiles.md` + playbook `references/dotfiles.md`.

### Earlier same-day decisions (still in force)

- Root required for 2.0 UI (`start.sh` sudo + `requireRoot()`); Bun PATH recovered under sudo `secure_path`.
- WSL: PowerShell `openExternal`; GPU flags + `LIBGL_ALWAYS_SOFTWARE`; `ping` unprivileged.
- Atividade: merge stdout+stderr chronologically; Dracula + JetBrains Mono.
- Images only under repo `assets/img/`.
- Modular renderer: `views/` + `components/` factories; Bun IIFE bundle.

## Validated

- Sistema as root: update / fix / clean → exit 0 (17 Nov 2026).
- `bun run helper -- dotfiles-dry-run` OK (as user).
- `bun run typecheck` + `bun run build` OK after license/env/dotfiles work.

## Still open (see `TODO.md`)

1. Package `.deb` (AppImage optional).
2. Smoke-test Software installers + pkexec on real desktop (owner-requested).

### i18n (done)

- Shared `locales/{pt,en}.json`; `CARCARA_LANG=pt|en` (1.x `i18n.sh` / 2.0 Zod + renderer).
- Zenity menus use stable IDs; Electron rail/views/license/native menu use `t()`.

### Docker port (done)

- Modern `carcara/.../development/docker.sh` replaces useful part of `old/scripts/docker.sh`.
- Official Docker apt → fallback `docker.io`; adds `$SUDO_USER` to `docker` group.
- Not ported: curl|bash, mass clean, tutum/apache-php helpers.

### dependences.sh (done this session)

- Apt-family check (`/etc/os-release` + apt-get fallback).
- Required: yad, zenity, curl, iputils-ping — `apt-get update` only when installing.
- Optional: snapd (+ systemd socket best-effort), `ensure_flatpak_flathub`.
- Notify via `$configYad` / `carcara_log` under NI (no blocking YadB).

## Blockers / notes

- Running as root → helper skips `pkexec` (expected). Test elevation on a real desktop, not already-root WSL sessions.
- GPU / `--no-sandbox` noise under WSLg is environmental.
