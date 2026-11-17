export function createBrand(): HTMLDivElement {
  const brand = document.createElement("div");
  brand.className = "brand";

  const mark = document.createElement("img");
  mark.className = "brand__mark";
  mark.src = "assets/logo_moderno_final.png";
  mark.width = 72;
  mark.height = 72;
  mark.alt = "";

  const text = document.createElement("div");
  text.className = "brand__text";

  const name = document.createElement("p");
  name.className = "brand__name";
  name.textContent = "Carcará";

  const ver = document.createElement("p");
  ver.className = "brand__ver";
  ver.textContent = "2.0";

  text.append(name, ver);
  brand.append(mark, text);
  return brand;
}
