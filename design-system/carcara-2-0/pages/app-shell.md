# App Shell Page Overrides

> **PROJECT:** Carcara 2.0  
> **Page Type:** Desktop utility shell (Electron)  
> Overrides `design-system/carcara-2-0/MASTER.md`. Source: skill `ui-ux-pro-max`.

---

## Layout (desktop app — not a marketing landing)

Do **not** use the MASTER “Product Demo + Features” section order for the running app.

```
┌─────────────┬──────────────────────────────┐
│ Brand       │ Top bar: section title       │
│ (Carcará)   ├──────────────────────────────┤
│             │ Primary pane                 │
│ Nav:        │  (actions / installers)      │
│  Sistema    │                              │
│  Software   ├──────────────────────────────┤
│  Sobre      │ Activity log (stdout/stderr) │
└─────────────┴──────────────────────────────┘
```

- **Sidebar** (~220px): brand + primary nav; one job per selection.
- **Primary pane**: verbs from 1.x — Atualizar, Corrigir, Limpar, Instalar…
- **Log pane**: monospace; status via border color + text (not color alone).
- **Max content width:** fluid inside window; no artificial 1200px marketing cap.

## Interaction

- Visible focus ring (`--color-ring`); `cursor: pointer` on all controls.
- Min hit target ~44×44px; 8px+ gaps.
- Transitions 150–200ms; honor `prefers-reduced-motion`.
- Loading: disable primary actions + status text while helper runs.
- No emoji icons — inline SVG only.

## Typography / color

- Follow MASTER tokens (teal primary, orange accent CTA, slate dark).
- Fonts: Inter if bundled later; until then system stack `Inter, "Segoe UI", system-ui, sans-serif` (Electron CSP: no remote Google Fonts by default).

## Flat Design constraints

- No heavy gradients or deep shadows on chrome.
- Hover = color/opacity/border shift, not layout-shifting scale.
