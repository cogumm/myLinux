import { openExternal } from "../lib/api.js";
import type { ViewMeta } from "../lib/types.js";

export const sobreMeta: ViewMeta = {
  eyebrow: "myLinux",
  title: "Sobre",
  lede: "Toolkit pessoal para Debian/Ubuntu e WSL2.",
};

type Fact = { label: string; value: string };

const FACTS: Fact[] = [
  { label: "Produto", value: "Carcará 2.0 — Electron + Bun sobre o motor Bash 1.x" },
  { label: "Alvo",    value: "Ubuntu, Debian, Linux Mint (apt), x86_64" },
  { label: "Entrada", value: "./start.sh  ·  --electron | --terminal" },
  { label: "Autor",   value: "Gabriel F. Vilar (CoGUMm)" },
  { label: "Licença", value: "MIT · Copyright (c) 2010 CoGUMm" },
  { label: "Repo",    value: "github.com/cogumm/myLinux" },
];

type LinkItem = { label: string; href: string };

const LINKS: LinkItem[] = [
  { label: "Ko-fi",       href: "https://ko-fi.com/cogumm" },
  { label: "Telegram",    href: "https://t.me/CoGUMm" },
  { label: "Licença MIT", href: "https://cogumm.mit-license.org/" },
  { label: "GitHub",      href: "https://github.com/cogumm/myLinux" },
];

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
  hero.alt = "Carcará";

  const body = el("div", "about__body");

  const lead = el(
    "p",
    "about__lead",
    "Personal Linux workstation toolkit — instaladores, manutenção e dotfiles. A UI 2.0 reutiliza os backends 1.x (apt → Flatpak → Snap).",
  );

  const list = el("dl", "about__facts");
  for (const fact of FACTS) {
    list.append(el("dt", undefined, fact.label), el("dd", undefined, fact.value));
  }

  const note = el(
    "p",
    "muted",
    "Muitos scripts precisam de root e alteram o sistema. Revise antes de executar. O autor não se responsabiliza por mau uso.",
  );

  const links = el("div", "about__links");
  links.setAttribute("role", "list");
  for (const item of LINKS) {
    const btn = el("button", "about__link") as HTMLButtonElement;
    btn.type = "button";
    btn.setAttribute("role", "listitem");
    btn.textContent = item.label;
    btn.title = item.href;
    btn.addEventListener("click", () => {
      void openExternal(item.href);
    });
    links.append(btn);
  }

  body.append(lead, list, note, links);
  about.append(hero, body);
  return about;
}
