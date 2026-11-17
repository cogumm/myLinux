import en from "../../../../locales/en.json";
import pt from "../../../../locales/pt.json";

export type Lang = "pt" | "en";

type Dict = Record<string, string>;

const catalogs: Record<Lang, Dict> = {
  pt: pt as Dict,
  en: en as Dict,
};

let current: Lang = "pt";

export function resolveLang(raw?: string | null): Lang {
  const v = (raw ?? "").trim().toLowerCase();
  if (v.startsWith("en")) return "en";
  return "pt";
}

export function setLang(lang: Lang): void {
  current = lang;
}

export function getLang(): Lang {
  return current;
}

export function t(key: string): string {
  return catalogs[current][key] ?? catalogs.pt[key] ?? key;
}
