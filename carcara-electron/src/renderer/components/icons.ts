/** Inline SVG icons (no emoji). */

function svg(paths: string): string {
  return `<svg class="ico" viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="1.75">${paths}</svg>`;
}

export const icons = {
  sistema: () =>
    svg(`<path stroke-linecap="round" d="M4 7h16M4 12h16M4 17h10" />`),
  software: () =>
    svg(
      `<rect x="4" y="5" width="16" height="14" rx="2" /><path stroke-linecap="round" d="M8 9h8M8 13h5" />`,
    ),
  sobre: () =>
    svg(
      `<circle cx="12" cy="12" r="8" /><path stroke-linecap="round" d="M12 11v5M12 8h.01" />`,
    ),
  code: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M8 8l-4 4 4 4M16 8l4 4-4 4M13 6l-2 12" />`,
    ),
  briefcase: () =>
    svg(
      `<rect x="3" y="7" width="18" height="13" rx="2" /><path stroke-linecap="round" d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2M3 12h18" />`,
    ),
  users: () =>
    svg(
      `<path stroke-linecap="round" d="M16 19v-1a3 3 0 00-3-3H7a3 3 0 00-3 3v1" /><circle cx="10" cy="8" r="3" /><path stroke-linecap="round" d="M20 19v-1a3 3 0 00-2-2.8M16 5.1a3 3 0 010 5.8" />`,
    ),
  wrench: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M14.7 6.3a4 4 0 00-5.6 5.6L4 17l3 3 5.1-5.1a4 4 0 005.6-5.6L15 12l-1.3-1.3 1-4.4z" />`,
    ),
} as const;
