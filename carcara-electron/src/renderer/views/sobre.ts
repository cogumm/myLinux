import type { ViewMeta } from "../lib/types.js";

export const sobreMeta: ViewMeta = {
  eyebrow: "Identidade",
  title: "Sobre",
  lede: "Carcará 2.0 — painel Electron sobre o motor 1.x.",
};

const MARK_VARIANTS = [
  "logo_moderno_final.png",
  "logo_moderno.png",
  "logo_redesenhado.png",
  "logo.png",
] as const;

function code(text: string): HTMLElement {
  const el = document.createElement("code");
  el.textContent = text;
  return el;
}

export function renderSobre(): HTMLElement {
  const about = document.createElement("div");
  about.className = "about";

  const hero = document.createElement("img");
  hero.className = "about__hero";
  hero.src = "assets/logo_moderno_final.png";
  hero.width = 160;
  hero.height = 160;
  hero.alt = "Logo Carcará";

  const body = document.createElement("div");
  body.className = "about__body";

  const p1 = document.createElement("p");
  p1.append(
    "Painel Electron + Bun sobre o motor Bash 1.x. Design Flat (",
    code("ui-ux-pro-max"),
    " → ",
    code("design-system/carcara-2-0"),
    ").",
  );

  const p2 = document.createElement("p");
  p2.className = "muted";
  p2.append("Marca: ", code("assets/img/logo_moderno_final.png"));

  const marks = document.createElement("div");
  marks.className = "about__marks";
  marks.setAttribute("aria-label", "Variantes");
  for (const name of MARK_VARIANTS) {
    const img = document.createElement("img");
    img.src = `assets/${name}`;
    img.alt = "";
    img.width = 40;
    img.height = 40;
    marks.append(img);
  }

  body.append(p1, p2, marks);
  about.append(hero, body);
  return about;
}
