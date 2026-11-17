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
│  Sobre       │  Activity log + live status    │
└──────────────┴────────────────────────────────┘
```

- Brand (logo + name) is the strongest signal in the first viewport of the rail.
- One job per view: Sistema = maintenance; Software = installs; Sobre = identity.
- Activity log is always visible (source of truth for apt/flatpak/snap).
- No marketing “Product Demo + Features” section order from MASTER.

## Interaction

- Visible focus ring (`--color-ring`); `cursor: pointer` on all controls.
- Min hit target 44×44px; 8px+ gaps.
- Confirm mutating actions in an accessible `<dialog>` (not hover-only).
- Busy state: disable actions + status “Executando…”.
- Transitions 150–200ms; honor `prefers-reduced-motion`.
- SVG icons only (no emoji).

## Brand

- Primary mark: `assets/img/logo_moderno_final.png` (hero in rail, ~96px)
- Wordmark **Carcará** Inter 700, tracking −0.03em (Modern Dark Cinema)
- Version as teal nowrap pill (`2.0`) beside the wordmark — compact label, never wrap
- Active nav: accent orange inset + secondary teal icon
- Tile hover: teal left bar + primary border (no permanent featured outline)
- Footer microcopy one line: `MIT · 2010–YYYY · @CoGUMm`
- Accent CTA `#EA580C` (beak) for confirm dialogs; teal `#0D9488` / `#14B8A6` for chrome + featured tiles
