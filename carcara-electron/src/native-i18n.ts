import { readFileSync } from "node:fs";
import path from "node:path";
import { env } from "./env";

/** Main-process `t` — loads shared repo `locales/{lang}.json`. */
export function nativeT(key: string): string {
  try {
    const file = path.join(
      __dirname,
      "..",
      "..",
      "locales",
      `${env.CARCARA_LANG}.json`,
    );
    const dict = JSON.parse(readFileSync(file, "utf8")) as Record<string, string>;
    return dict[key] ?? key;
  } catch {
    return key;
  }
}
