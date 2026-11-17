import { $ } from "bun";
import { mkdir } from "node:fs/promises";
import path from "node:path";

const root = path.join(import.meta.dir, "..");
const rendererDest = path.join(root, "dist", "renderer");

await $`tsc`.cwd(root);
await mkdir(rendererDest, { recursive: true });
await $`cp ${path.join(root, "src/renderer/index.html")} ${rendererDest}/`;
await $`cp ${path.join(root, "src/renderer/styles.css")} ${rendererDest}/`;

console.log("[carcara-electron] build ok");
