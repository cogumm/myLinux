import { createBrand } from "./brand.js";
import { icons } from "./icons.js";
import type { ViewId } from "../lib/types.js";

export type RailItem = {
  id: ViewId;
  label: string;
  icon: keyof typeof icons;
};

const DEFAULT_ITEMS: RailItem[] = [
  { id: "sistema", label: "Sistema", icon: "sistema" },
  { id: "software", label: "Software", icon: "software" },
  { id: "sobre", label: "Sobre", icon: "sobre" },
];

export type RailHandle = {
  root: HTMLElement;
  setActive: (id: ViewId) => void;
};

export function createRail(
  onNavigate: (id: ViewId) => void,
  items: RailItem[] = DEFAULT_ITEMS,
): RailHandle {
  const aside = document.createElement("aside");
  aside.className = "rail";
  aside.setAttribute("aria-label", "Navegação");

  const nav = document.createElement("nav");
  nav.className = "rail__nav";
  nav.setAttribute("aria-label", "Principal");

  const buttons = new Map<ViewId, HTMLButtonElement>();

  for (const item of items) {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "rail__link";
    btn.dataset.view = item.id;
    btn.innerHTML = `${icons[item.icon]()}<span>${item.label}</span>`;
    btn.addEventListener("click", () => onNavigate(item.id));
    buttons.set(item.id, btn);
    nav.append(btn);
  }

  const foot = document.createElement("p");
  foot.className = "rail__foot";
  foot.textContent = "Motor 1.x · UI Electron";

  aside.append(createBrand(), nav, foot);

  function setActive(id: ViewId): void {
    for (const [viewId, btn] of buttons) {
      const active = viewId === id;
      btn.classList.toggle("is-active", active);
      if (active) btn.setAttribute("aria-current", "page");
      else btn.removeAttribute("aria-current");
    }
  }

  return { root: aside, setActive };
}
