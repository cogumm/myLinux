import en from "../../../../locales/en.json";
import pt from "../../../../locales/pt.json";
import { flattenLocale, type LocaleTree } from "./flatten-locale.js";

export type Lang = "pt" | "en";

type Dict = Record<string, string>;

const catalogs: Record<Lang, Dict> = {
  pt: flattenLocale(pt as LocaleTree),
  en: flattenLocale(en as LocaleTree),
};

const STORAGE_KEY = "carcara.lang";

let current: Lang = "pt";

export function resolveLang(raw?: string | null): Lang {
  const v = (raw ?? "").trim().toLowerCase();
  if (v.startsWith("en")) return "en";
  return "pt";
}

/** Env (`CARCARA_LANG`) is the default; localStorage override wins when set. */
export function loadPreferredLang(envLang?: string | null): Lang {
  try {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored === "pt" || stored === "en") return stored;
  } catch {
    /* private mode / blocked storage */
  }
  return resolveLang(envLang);
}

export function persistLang(lang: Lang): void {
  try {
    localStorage.setItem(STORAGE_KEY, lang);
  } catch {
    /* ignore */
  }
  setLang(lang);
}

export function setLang(lang: Lang): void {
  current = lang;
}

export function getLang(): Lang {
  return current;
}

export function applyDocumentLang(lang: Lang = current): void {
  document.documentElement.lang = lang === "en" ? "en" : "pt-BR";
}

/** Replace `{name}` placeholders (e.g. `{version}` from `package.json`). */
export function interpolate(
  template: string,
  vars: Record<string, string>,
): string {
  return template.replace(/\{([a-zA-Z][a-zA-Z0-9_]*)\}/g, (full, name: string) =>
    Object.prototype.hasOwnProperty.call(vars, name) ? vars[name]! : full,
  );
}

export function t(key: string, vars?: Record<string, string>): string {
  const raw = catalogs[current][key] ?? catalogs.pt[key] ?? key;
  return vars ? interpolate(raw, vars) : raw;
}
