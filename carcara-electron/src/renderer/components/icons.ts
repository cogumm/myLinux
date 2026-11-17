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
} as const;
