/** Flatten nested locale JSON into dotted keys (`menu.choose`, `tile.update.title`, …). */
export type LocaleTree = { [key: string]: string | LocaleTree };

export function flattenLocale(
  node: LocaleTree,
  prefix = "",
  out: Record<string, string> = {},
): Record<string, string> {
  for (const [key, value] of Object.entries(node)) {
    const path = prefix ? `${prefix}.${key}` : key;
    if (typeof value === "string") {
      out[path] = value;
    } else if (value && typeof value === "object") {
      flattenLocale(value, path, out);
    }
  }
  return out;
}
