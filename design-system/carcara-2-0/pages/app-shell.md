# App Shell — Carcará 2.0

> Overrides `MASTER.md` for the Electron desktop utility (not a marketing landing).

**Style:** Flat Design · **Light** shell · warm rail · dark Activity console  
**Skill:** `ui-ux-pro-max`  
**Runtime CSS:** `carcara-electron/src/renderer/styles.css` (tokens mirrored in `tokens.css` / `tokens.json`)  
**Agent ops:** `.agents/playbook/references/carcara-2.0.md`

## Layout

```
┌──────────────┬────────────────────────────────┐
│ LOGO | name  │  Section title + one lede       │
│      | ver   ├────────────────────────────────┤
│              │  Primary content (one job)     │
│  Sistema     │  action tiles / installers     │
│  Software    ├────────────────────────────────┤
│  Dotfiles    │  Activity log (dark terminal)  │
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
- Activity log is always visible (source of truth for apt/flatpak/snap) — **Dracula dark** console on the light shell.
- No marketing “Product Demo + Features” section order from MASTER.

## Interaction

- **License gate** first (same text as 1.x): checkbox Continuar → Aceitar; Sair quits.
- Visible focus ring (`--color-ring`); `cursor: pointer` on all controls.
- Min hit target 44×44px; 8px+ gaps.
- Confirm mutating actions in an accessible `<dialog>` (not hover-only).
- Tile hover: accent left inset + light teal wash (no permanent featured outline).
- Busy state: disable actions + status “Executando…”.
- Transitions 150–200ms; honor `prefers-reduced-motion`.
- SVG icons only (no emoji).

## Brand / header band

- Mark left of wordmark; version pill **under** the name
- Mark size = `--brand-mark-size` (`calc(--shell-head-h − 2×--shell-head-pad-y)`); soft drop-shadow
- Brand wash: warm gradient `#F8F2E9 → #FBFAF7`; rail surface `#FBFAF7`
- Brand band and `stage__head` share exact `--shell-head-h` so the divider is one continuous line
- `stage__head` translucent white wash on light background
- Wordmark Inter 700, tracking −0.03em
- Active nav: accent orange inset + secondary teal icon
- Footer: **PT | EN** lang switch + `MIT · 2010–YYYY · cogumm.net`
- Accent CTA `#C2410C`; primary/chrome teal `#0F766E` / `#0D9488`

## Palette (shell)

See `MASTER.md` / `tokens.css`. Do not reintroduce the old dark `#0F172A` / `#111827` shell without owner ask — console `--term-*` remains dark by design.
