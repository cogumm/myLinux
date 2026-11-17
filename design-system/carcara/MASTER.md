# Design system — Carcará

Last updated: 2026-11-17

Two tracks:

| Track | Surface | Notes |
|-------|---------|--------|
| **1.x** | Zenity / Yad under `carcara/` | CLI/fallback; install engine |
| **2.0** | Electron under `carcara-electron/` | Product UI; design tokens in `design-system/carcara-2-0/` (`ui-ux-pro-max`) |

## Shared principles

1. **One job per screen**
2. **Familiar verbs** — Atualizar, Instalar, Corrigir, Limpar, Voltar, Sair
3. **Honest empty states** — no fake success
4. **Logs remain source of truth** for apt/flatpak/snap errors
5. **Portuguese labels** by default (match existing menus)

## 1.x TUI (Zenity / Yad)

1. Menus: Zenity `--list`
2. Short info / progress: Yad with `$configYad` / `$configYadB` from `config.sh`
3. Centered, modest dialogs (~330–500px)
4. Do not add Electron/HTML **inside** `carcara/` menus
5. Keyboard: arrows + Enter + Esc must suffice

Shared tokens in `carcara/app/config/config.sh`: `$configYad`, `$configYadB`, `$dirSof`, `$dirSys`, `$menuApp`, `$menuSof`.

## 2.0 Electron + Bun

- Plan: `.agents/idea/carcara-2.0-electron.md`
- Toolchain: Bun (`bun install`, `Bun.$` shell — https://bun.sh/docs/runtime/shell)
- Vanilla HTML/CSS + TypeScript renderer
- Privilege: `scripts/run-helper.ts` → allowlisted `helper/carcara-helper.sh` + `pkexec`
- Brand-forward shell; accent warm (see spike `styles.css`); avoid Yad clones
- Never reimplement package install logic in the renderer
