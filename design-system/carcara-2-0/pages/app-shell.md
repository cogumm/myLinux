# App Shell — Carcará 2.0

> Overrides `MASTER.md` for the Electron desktop utility (not a marketing landing).

**Style:** Flat Design · Dark · Tokens in `tokens.css`  
**Skill:** `ui-ux-pro-max` (regenerated 17 de Novembro de 2026)  
**Agent ops:** `.agents/playbook/references/carcara-2.0.md`

## Layout

```
┌──────────────┬────────────────────────────────┐
│   LOGO       │  Section title + one lede       │
│   Carcará    ├────────────────────────────────┤
│              │  Primary content (one job)     │
│  Sistema     │  action tiles / installers     │
│  Software    ├────────────────────────────────┤
│  Dotfiles    │  Activity log + live status    │
│  Sobre       │                                │
│  [PT] [EN]   │                                │
└──────────────┴────────────────────────────────┘
```

- Brand (logo + name) is the strongest signal in the first viewport of the rail.
- Rail footer: compact **PT | EN** language switch (`CARCARA_LANG` default; `localStorage` override) + MIT meta.
- Brand version pill = `package.json` version (not hardcoded `2.0`).
- One job per view: Sistema = maintenance (incl. sync clock); Software = installs; Dotfiles = `$HOME` apply; Sobre = identity.
- Software catalog: Snap Store **19 categories**; **6 tiles per page** + Anterior/Próxima; empty cats show muted placeholder.
- Software layout: category column fills stage height (scroll inside); tiles use **`auto-fit`** so few cards expand across the pane (not tiny left-aligned stubs).
- Activity log is always visible (source of truth for apt/flatpak/snap).
- No marketing “Product Demo + Features” section order from MASTER.

## Interaction

- **License gate** first (same text as 1.x): checkbox Continuar → Aceitar; Sair quits.
- Visible focus ring (`--color-ring`); `cursor: pointer` on all controls.
- Min hit target 44×44px; 8px+ gaps.
- Confirm mutating actions in an accessible `<dialog>` (not hover-only).
- Tile hover: teal left bar + primary border (no permanent featured outline).
- Busy state: disable actions + status “Executando…”.
- Transitions 150–200ms; honor `prefers-reduced-motion`.
- SVG icons only (no emoji).

## Brand

- Primary mark: `assets/img/logo_moderno_final.png` sized to band (`--brand-mark-size`) **left of** wordmark; version pill **under** the name
- Wordmark **Carcará** Inter 700, tracking −0.03em (Modern Dark Cinema)
- Brand band and `stage__head` share exact `--shell-head-h` (tight pad) so the divider is one continuous line
- Version pill from `package.json`; never wrap
- Active nav: accent orange inset + secondary teal icon
- Tile hover: teal left bar + primary border (no permanent featured outline)
- Footer: **PT | EN** lang switch + `MIT · 2010–YYYY · cogumm.net`
- Accent CTA `#EA580C` (beak) for confirm dialogs; teal `#0D9488` / `#14B8A6` for chrome + featured tiles
