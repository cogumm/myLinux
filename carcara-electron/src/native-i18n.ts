import { readFileSync } from "node:fs";
import path from "node:path";
import { env } from "./env";
import { getLocalesDir } from "./paths";

type LocaleTree = { [key: string]: string | LocaleTree };

function flattenLocale(
  node: LocaleTree,
  prefix = "",
  out: Record<string, string> = {},
): Record<string, string> {
  for (const [key, value] of Object.entries(node)) {
    const dotted = prefix ? `${prefix}.${key}` : key;
    if (typeof value === "string") {
      out[dotted] = value;
    } else if (value && typeof value === "object") {
      flattenLocale(value, dotted, out);
    }
  }
  return out;
}

function interpolate(
  template: string,
  vars: Record<string, string>,
): string {
  return template.replace(/\{([a-zA-Z][a-zA-Z0-9_]*)\}/g, (full, name: string) =>
    Object.prototype.hasOwnProperty.call(vars, name) ? vars[name]! : full,
  );
}

/** Main-process `t` — nested `locales/{lang}.json` (dev repo or packaged resources). */
export function nativeT(key: string, vars?: Record<string, string>): string {
  try {
    const file = path.join(getLocalesDir(), `${env.CARCARA_LANG}.json`);
    const tree = JSON.parse(readFileSync(file, "utf8")) as LocaleTree;
    const dict = flattenLocale(tree);
    const raw = dict[key] ?? key;
    return vars ? interpolate(raw, vars) : raw;
  } catch {
    return key;
  }
}
