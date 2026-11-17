import type { StatusKind, ViewMeta } from "../lib/types.js";

export type StageHeaderHandle = {
  root: HTMLElement;
  setMeta: (meta: ViewMeta) => void;
  setStatus: (text: string, kind: StatusKind) => void;
};

export function createStageHeader(): StageHeaderHandle {
  const header = document.createElement("header");
  header.className = "stage__head";

  const copy = document.createElement("div");

  const eyebrow = document.createElement("p");
  eyebrow.className = "eyebrow";
  eyebrow.id = "view-eyebrow";

  const title = document.createElement("h1");
  title.id = "view-title";

  const lede = document.createElement("p");
  lede.className = "lede";
  lede.id = "view-lede";

  copy.append(eyebrow, title, lede);

  const status = document.createElement("p");
  status.id = "status";
  status.className = "pill";
  status.setAttribute("role", "status");
  status.setAttribute("aria-live", "polite");
  status.textContent = "Pronto";

  header.append(copy, status);

  return {
    root: header,
    setMeta(meta) {
      eyebrow.textContent = meta.eyebrow;
      title.textContent = meta.title;
      lede.textContent = meta.lede;
    },
    setStatus(text, kind) {
      status.textContent = text;
      status.classList.remove("is-busy", "is-ok", "is-err");
      if (kind === "busy") status.classList.add("is-busy");
      if (kind === "ok") status.classList.add("is-ok");
      if (kind === "err") status.classList.add("is-err");
    },
  };
}
