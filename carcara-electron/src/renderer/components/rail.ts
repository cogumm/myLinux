import { createBrand } from "./brand.js";
import { createLangSwitch } from "./lang-switch.js";
import { createNavList } from "./nav-list.js";
import { icons } from "./icons.js";
import { openExternal } from "../lib/api.js";
import { t, type Lang } from "../lib/i18n.js";
import type { ViewId } from "../lib/types.js";

const SITE_URL = "https://cogumm.net/";

export type RailItem = {
  id: ViewId;
  label: string;
  icon: keyof typeof icons;
};

export type RailHandle = {
  root: HTMLElement;
  setActive: (id: ViewId) => void;
};

export type RailOptions = {
  onLangChange?: (lang: Lang) => void;
};

export function createRail(
  onNavigate: (id: ViewId) => void,
  options: RailOptions = {},
): RailHandle {
  const items: RailItem[] = [
    { id: "sistema", label: t("rail.sistema"), icon: "sistema" },
    { id: "software", label: t("rail.software"), icon: "software" },
    { id: "dotfiles", label: t("rail.dotfiles"), icon: "dotfiles" },
    { id: "sobre", label: t("rail.sobre"), icon: "sobre" },
  ];

  const aside = document.createElement("aside");
  aside.className = "rail";
  aside.setAttribute("aria-label", t("rail.navAria"));

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

  if (options.onLangChange) {
    const lang = createLangSwitch(options.onLangChange);
    foot.append(lang.root);
  }

  const meta = document.createElement("div");
  meta.className = "rail__foot-meta-row";
  const year = new Date().getFullYear();

  const license = document.createElement("span");
  license.className = "rail__foot-meta";
  license.textContent = `MIT · 2010–${year}`;

  const sep = document.createElement("span");
  sep.className = "rail__foot-sep";
  sep.setAttribute("aria-hidden", "true");
  sep.textContent = "·";

  const credit = document.createElement("button");
  credit.type = "button";
  credit.className = "rail__foot-credit";
  credit.textContent = "cogumm.net";
  credit.title = SITE_URL;
  credit.addEventListener("click", () => {
    void openExternal(SITE_URL);
  });

  meta.append(license, sep, credit);
  foot.append(meta);

  aside.append(createBrand(), nav.root, foot);

  return {
    root: aside,
    setActive: (id) => nav.setActive(id),
  };
}
