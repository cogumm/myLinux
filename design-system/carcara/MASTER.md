# Design system — Carcará (TUI)

Last updated: 2026-11-16

Carcará is a **desktop dialog** UI (Zenity / Yad), not a browser app.

## Principles

1. **One job per screen** — a Zenity list or a Yad progress/notice.
2. **Familiar verbs** — Atualizar, Instalar, Corrigir, Limpar, Voltar, Sair.
3. **Honest empty states** — “Ainda em desenvolvimento” only when truly unwired.
4. **Terminal remains source of truth** for apt errors; Yad is status chrome.
5. **Centered, modest dialogs** — width ~330–500px; avoid full-screen takeovers.
6. **No web installers** — no HTML/Electron wrappers for Carcará menus.

## Components (mapping)

| Pattern | Tool | Notes |
|---------|------|--------|
| Main/category menu | Zenity `--list` | Single column of actions |
| Short info | Yad `--text` + `$configYad` / `$configYadB` | Timeout OK for success toasts |
| Long-running apt | Yad `--progress --pulsate` | Check exit codes after pipe |
| License / essay | Zenity `--text-info` | Optional gate in `startApp.sh` |

## Shared tokens (behavioral)

Defined in `carcara/app/config/config.sh`:

- `$configYad` — no buttons, timeout 3s, centered
- `$configYadB` — OK/Cancel style, timeout 3s
- `$dirSof` / `$dirSys` / `$menuApp` / `$menuSof`

## Accessibility

- Keyboard: arrows + Enter + Esc must suffice.
- Do not rely on color alone for success/failure.
- Keep labels in plain language (PT default).
