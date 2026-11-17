import type { ViewId } from "../lib/types.js";

export function createPanel(
  id: ViewId,
  content: HTMLElement,
  visible = false,
): HTMLElement {
  const section = document.createElement("section");
  section.id = `view-${id}`;
  section.className = visible ? "panel is-visible" : "panel";
  section.hidden = !visible;
  section.setAttribute("aria-labelledby", "view-title");
  section.append(content);
  return section;
}

export function showPanel(panels: Map<ViewId, HTMLElement>, id: ViewId): void {
  for (const [viewId, panel] of panels) {
    const match = viewId === id;
    panel.classList.toggle("is-visible", match);
    if (match) {
      panel.hidden = false;
      panel.removeAttribute("hidden");
    } else {
      panel.hidden = true;
    }
  }
}
