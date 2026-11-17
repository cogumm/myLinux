import { $ } from "bun";
import { mkdir } from "node:fs/promises";
import path from "node:path";

const root = path.join(import.meta.dir, "..");
const repoRoot = path.join(root, "..");
const rendererDest = path.join(root, "dist", "renderer");
const assetsDest = path.join(rendererDest, "assets");
const logoSrc = path.join(repoRoot, "assets/img/logo.png");

await $`tsc`.cwd(root);
await mkdir(assetsDest, { recursive: true });
await $`cp ${path.join(root, "src/renderer/index.html")} ${rendererDest}/`;
await $`cp ${path.join(root, "src/renderer/styles.css")} ${rendererDest}/`;
await $`cp ${logoSrc} ${path.join(assetsDest, "logo.png")}`;

console.log("[carcara-electron] build ok");
