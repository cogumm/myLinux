export type NavListItem = {
  id: string;
  label: string;
  iconHtml?: string;
};

export type NavListHandle = {
  root: HTMLElement;
  setActive: (id: string) => void;
};

/** Vertical nav links — same visual language as the main rail. */
export function createNavList(
  items: NavListItem[],
  onSelect: (id: string) => void,
  options?: { label?: string; className?: string },
): NavListHandle {
  const nav = document.createElement("nav");
  nav.className = options?.className ?? "nav-list";
  if (options?.label) nav.setAttribute("aria-label", options.label);

  const buttons = new Map<string, HTMLButtonElement>();

  for (const item of items) {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "rail__link";
    btn.dataset.id = item.id;
    btn.innerHTML = `${item.iconHtml ?? ""}<span>${item.label}</span>`;
    btn.addEventListener("click", () => onSelect(item.id));
    buttons.set(item.id, btn);
    nav.append(btn);
  }

  function setActive(id: string): void {
    for (const [itemId, btn] of buttons) {
      const active = itemId === id;
      btn.classList.toggle("is-active", active);
      if (active) btn.setAttribute("aria-current", "page");
      else btn.removeAttribute("aria-current");
    }
  }

  return { root: nav, setActive };
}
