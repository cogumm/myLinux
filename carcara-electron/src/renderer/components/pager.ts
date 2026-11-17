import { t } from "../lib/i18n.js";

export type PagerHandle = {
  root: HTMLElement;
  /** Update labels + disabled state for the current page. */
  setState: (page: number, pageCount: number) => void;
};

function fmt(key: string, vars: Record<string, string | number>): string {
  let out = t(key);
  for (const [k, v] of Object.entries(vars)) {
    out = out.replaceAll(`{${k}}`, String(v));
  }
  return out;
}

/** Compact prev / status / next — Flat Design, 44px hit targets. */
export function createPager(
  onPrev: () => void,
  onNext: () => void,
): PagerHandle {
  const root = document.createElement("nav");
  root.className = "pager";
  root.setAttribute("aria-label", t("pager.aria"));

  const prev = document.createElement("button");
  prev.type = "button";
  prev.className = "pager__btn";
  prev.textContent = t("pager.prev");
  prev.addEventListener("click", onPrev);

  const status = document.createElement("span");
  status.className = "pager__status";
  status.setAttribute("aria-live", "polite");

  const next = document.createElement("button");
  next.type = "button";
  next.className = "pager__btn";
  next.textContent = t("pager.next");
  next.addEventListener("click", onNext);

  root.append(prev, status, next);

  function setState(page: number, pageCount: number): void {
    const multi = pageCount > 1;
    root.hidden = !multi;
    status.textContent = fmt("pager.status", {
      current: page,
      total: Math.max(pageCount, 1),
    });
    prev.disabled = !multi || page <= 1;
    next.disabled = !multi || page >= pageCount;
  }

  setState(1, 1);
  return { root, setState };
}
