import { getLang, t, type Lang } from "../lib/i18n.js";

export type LangSwitchHandle = {
  root: HTMLElement;
};

const OPTIONS: { id: Lang; label: string }[] = [
  { id: "pt", label: "PT" },
  { id: "en", label: "EN" },
];

/** Compact PT | EN control for the rail footer. */
export function createLangSwitch(onChange: (lang: Lang) => void): LangSwitchHandle {
  const root = document.createElement("div");
  root.className = "lang-switch";
  root.setAttribute("role", "group");
  root.setAttribute("aria-label", t("lang.switchAria"));

  const active = getLang();
  for (const opt of OPTIONS) {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "lang-switch__btn";
    btn.textContent = opt.label;
    btn.dataset.lang = opt.id;
    btn.setAttribute("aria-pressed", opt.id === active ? "true" : "false");
    if (opt.id === active) btn.classList.add("is-active");
    btn.addEventListener("click", () => {
      if (opt.id === getLang()) return;
      onChange(opt.id);
    });
    root.append(btn);
  }

  return { root };
}
