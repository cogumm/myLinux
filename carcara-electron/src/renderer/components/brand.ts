import { t } from "../lib/i18n.js";
import { APP_VERSION } from "../lib/version.js";

/** Brand block for the app rail — hero-level mark + name (ui-ux-pro-max). */
export function createBrand(): HTMLElement {
  const brand = document.createElement("header");
  brand.className = "brand";
  brand.setAttribute("aria-label", `${t("app.name")} ${APP_VERSION}`);

  const mark = document.createElement("img");
  mark.className = "brand__mark";
  mark.src = "assets/logo_moderno_final.png";
  mark.width = 96;
  mark.height = 96;
  mark.alt = "";
  mark.decoding = "async";

  const text = document.createElement("div");
  text.className = "brand__text";

  const name = document.createElement("p");
  name.className = "brand__name";
  name.textContent = t("app.name");

  const ver = document.createElement("span");
  ver.className = "brand__ver";
  ver.textContent = APP_VERSION;

  text.append(name, ver);
  brand.append(mark, text);
  return brand;
}
