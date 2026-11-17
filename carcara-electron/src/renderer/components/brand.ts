/** Brand block for the app rail — hero-level mark + name (ui-ux-pro-max). */
export function createBrand(): HTMLElement {
  const brand = document.createElement("header");
  brand.className = "brand";
  brand.setAttribute("aria-label", "Carcará 2.0");

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
  name.textContent = "Carcará";

  const ver = document.createElement("span");
  ver.className = "brand__ver";
  ver.textContent = "2.0";

  text.append(name, ver);
  brand.append(mark, text);
  return brand;
}
