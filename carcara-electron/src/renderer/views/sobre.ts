import { openExternal } from "../lib/api.js";
import { t } from "../lib/i18n.js";
import type { ViewMeta } from "../lib/types.js";

export function getSobreMeta(): ViewMeta {
  return {
    eyebrow: "myLinux",
    title: t("view.sobre.title"),
    lede: t("view.sobre.lede"),
  };
}

type Fact = { label: string; value: string };

function facts(): Fact[] {
  return [
    { label: t("sobre.fact.product.label"), value: t("sobre.fact.product.value") },
    { label: t("sobre.fact.target.label"), value: t("sobre.fact.target.value") },
    { label: t("sobre.fact.entry.label"), value: t("sobre.fact.entry.value") },
    { label: t("sobre.fact.author.label"), value: t("sobre.fact.author.value") },
    { label: t("sobre.fact.license.label"), value: t("sobre.fact.license.value") },
    { label: t("sobre.fact.repo.label"), value: t("sobre.fact.repo.value") },
  ];
}

type LinkItem = { label: string; href: string };

function links(): LinkItem[] {
  return [
    { label: "Ko-fi", href: "https://ko-fi.com/cogumm" },
    { label: "Telegram", href: "https://t.me/CoGUMm" },
    { label: t("sobre.link.mit"), href: "https://cogumm.mit-license.org/" },
    { label: "GitHub", href: "https://github.com/cogumm/myLinux" },
  ];
}

function el<K extends keyof HTMLElementTagNameMap>(
  tag: K,
  className?: string,
  text?: string,
): HTMLElementTagNameMap[K] {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (text !== undefined) node.textContent = text;
  return node;
}

export function renderSobre(): HTMLElement {
  const about = el("div", "about");

  const hero = el("img", "about__hero") as HTMLImageElement;
  hero.src = "assets/logo_moderno_final.png";
  hero.width = 128;
  hero.height = 128;
  hero.alt = t("app.name");

  const body = el("div", "about__body");

  const lead = el("p", "about__lead", t("sobre.lead"));
  const list = el("dl", "about__facts");
  for (const fact of facts()) {
    list.append(el("dt", undefined, fact.label), el("dd", undefined, fact.value));
  }

  const note = el("p", "muted", t("sobre.note"));

  const linkRow = el("div", "about__links");
  linkRow.setAttribute("role", "list");
  for (const item of links()) {
    const btn = el("button", "about__link") as HTMLButtonElement;
    btn.type = "button";
    btn.setAttribute("role", "listitem");
    btn.textContent = item.label;
    btn.title = item.href;
    btn.addEventListener("click", () => {
      void openExternal(item.href).then((result) => {
        if (!result.ok) {
          const detail = result.error ?? t("sobre.link.noBrowser");
          btn.title = `${item.href} — ${t("sobre.link.failed")}: ${detail}`;
          try {
            void navigator.clipboard.writeText(item.href);
            btn.textContent = `${item.label} ${t("sobre.link.copied")}`;
            window.setTimeout(() => {
              btn.textContent = item.label;
            }, 1800);
          } catch {
            /* ignore */
          }
        }
      });
    });
    linkRow.append(btn);
  }

  body.append(lead, list, note, linkRow);
  about.append(hero, body);
  return about;
}
