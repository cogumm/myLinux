import { readFileSync } from "node:fs";
import path from "node:path";
import { env } from "./env";

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

/** Main-process `t` — loads nested `locales/{lang}.json`, flattens to dotted keys. */
export function nativeT(key: string): string {
  try {
    const file = path.join(
      __dirname,
      "..",
      "..",
      "locales",
      `${env.CARCARA_LANG}.json`,
    );
    const tree = JSON.parse(readFileSync(file, "utf8")) as LocaleTree;
    const dict = flattenLocale(tree);
    return dict[key] ?? key;
  } catch {
    return key;
  }
}
