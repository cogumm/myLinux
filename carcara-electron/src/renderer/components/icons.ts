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
  dotfiles: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M4 20h16M6 20V9l6-5 6 5v11M10 20v-6h4v6" />`,
    ),
  sobre: () =>
    svg(
      `<circle cx="12" cy="12" r="8" /><path stroke-linecap="round" d="M12 11v5M12 8h.01" />`,
    ),
  code: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M8 8l-4 4 4 4M16 8l4 4-4 4M13 6l-2 12" />`,
    ),
  gamepad: () =>
    svg(
      `<rect x="2" y="8" width="20" height="10" rx="3" /><path stroke-linecap="round" d="M8 13h0.01M11 13h0.01M16 11v4M14 13h4" />`,
    ),
  users: () =>
    svg(
      `<path stroke-linecap="round" d="M16 19v-1a3 3 0 00-3-3H7a3 3 0 00-3 3v1" /><circle cx="10" cy="8" r="3" /><path stroke-linecap="round" d="M20 19v-1a3 3 0 00-2-2.8M16 5.1a3 3 0 010 5.8" />`,
    ),
  briefcase: () =>
    svg(
      `<rect x="3" y="7" width="18" height="13" rx="2" /><path stroke-linecap="round" d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2M3 12h18" />`,
    ),
  wrench: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M14.7 6.3a4 4 0 00-5.6 5.6L4 17l3 3 5.1-5.1a4 4 0 005.6-5.6L15 12l-1.3-1.3 1-4.4z" />`,
    ),
  music: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M9 18V6l10-2v12" /><circle cx="7" cy="18" r="2.5" /><circle cx="17" cy="16" r="2.5" />`,
    ),
  palette: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M12 3a9 9 0 100 18h.5a2.5 2.5 0 000-5H14a2 2 0 01-2-2V9a2 2 0 012-2h1a2 2 0 100-4h-3z" /><circle cx="7.5" cy="10.5" r="1" fill="currentColor" stroke="none" /><circle cx="10.5" cy="7.5" r="1" fill="currentColor" stroke="none" />`,
    ),
  camera: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M4 8h3l2-2h6l2 2h3v11H4V8z" /><circle cx="12" cy="13" r="3.5" />`,
    ),
  cloud: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M7 18h10a4 4 0 00.5-8 5.5 5.5 0 00-10.7 1.5A3.5 3.5 0 007 18z" />`,
    ),
  book: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M5 5a2 2 0 012-2h11v16H7a2 2 0 00-2 2V5z" /><path stroke-linecap="round" d="M7 3v16" />`,
    ),
  chip: () =>
    svg(
      `<rect x="7" y="7" width="10" height="10" rx="1.5" /><path stroke-linecap="round" d="M9 3v4M12 3v4M15 3v4M9 17v4M12 17v4M15 17v4M3 9h4M3 12h4M3 15h4M17 9h4M17 12h4M17 15h4" />`,
    ),
  education: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M3 10l9-5 9 5-9 5-9-5z" /><path stroke-linecap="round" d="M7 12v4c0 1 2.5 2.5 5 2.5S17 17 17 16v-4" />`,
    ),
  film: () =>
    svg(
      `<rect x="3" y="5" width="18" height="14" rx="2" /><path stroke-linecap="round" d="M7 5v14M17 5v14M3 9h4M3 15h4M17 9h4M17 15h4" />`,
    ),
  finance: () =>
    svg(
      `<circle cx="12" cy="12" r="8" /><path stroke-linecap="round" d="M12 7v10M9.5 9.5c.5-1 1.5-1.5 2.5-1.5s2 .7 2 1.8c0 2.2-4 1.2-4 3.4 0 1.1 1 1.8 2 1.8s2-.5 2.5-1.5" />`,
    ),
  heart: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M12 20s-7-4.4-7-9.2A3.8 3.8 0 0112 8a3.8 3.8 0 017 2.8C19 15.6 12 20 12 20z" />`,
    ),
  news: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M5 5h11a2 2 0 012 2v12H7a2 2 0 01-2-2V5z" /><path stroke-linecap="round" d="M8 9h7M8 13h5M18 7v12a2 2 0 002-2V9" />`,
    ),
  sparkles: () =>
    svg(
      `<path stroke-linecap="round" d="M12 4v3M12 17v3M4 12h3M17 12h3M7 7l2 2M15 15l2 2M17 7l-2 2M9 15l-2 2" />`,
    ),
  flask: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M9 3h6M10 3v6L5 18a2 2 0 002 3h10a2 2 0 002-3l-5-9V3" />`,
    ),
  shield: () =>
    svg(
      `<path stroke-linecap="round" stroke-linejoin="round" d="M12 3l8 3v6c0 4.5-3.2 7.8-8 9-4.8-1.2-8-4.5-8-9V6l8-3z" />`,
    ),
} as const;
