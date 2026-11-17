import { createBrand } from "./brand.js";
import { createNavList } from "./nav-list.js";
import { icons } from "./icons.js";
import { t } from "../lib/i18n.js";
import type { ViewId } from "../lib/types.js";

export type RailItem = {
  id: ViewId;
  label: string;
  icon: keyof typeof icons;
};

export type RailHandle = {
  root: HTMLElement;
  setActive: (id: ViewId) => void;
};

export function createRail(
  onNavigate: (id: ViewId) => void,
): RailHandle {
  const items: RailItem[] = [
    { id: "sistema", label: t("rail.sistema"), icon: "sistema" },
    { id: "software", label: t("rail.software"), icon: "software" },
    { id: "dotfiles", label: t("rail.dotfiles"), icon: "dotfiles" },
    { id: "sobre", label: t("rail.sobre"), icon: "sobre" },
  ];

  const aside = document.createElement("aside");
  aside.className = "rail";
  aside.setAttribute("aria-label", "Navigation");

  const nav = createNavList(
    items.map((item) => ({
      id: item.id,
      label: item.label,
      iconHtml: icons[item.icon](),
    })),
    (id) => onNavigate(id as ViewId),
    { label: t("app.name"), className: "nav-list rail__nav" },
  );

  const foot = document.createElement("footer");
  foot.className = "rail__foot";
  const year = new Date().getFullYear();

  const license = document.createElement("span");
  license.className = "rail__foot-meta";
  license.textContent = `MIT · 2010–${year}`;

  const sep = document.createElement("span");
  sep.className = "rail__foot-sep";
  sep.setAttribute("aria-hidden", "true");
  sep.textContent = "·";

  const credit = document.createElement("span");
  credit.className = "rail__foot-credit";
  credit.textContent = "cogumm.net";

  foot.append(license, sep, credit);

  aside.append(createBrand(), nav.root, foot);

  return {
    root: aside,
    setActive: (id) => nav.setActive(id),
  };
}
