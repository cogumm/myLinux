import pkg from "../../../package.json" with { type: "json" };

/** Same string as `package.json` `"version"` (bundled at build time). */
export const APP_VERSION: string = pkg.version;
