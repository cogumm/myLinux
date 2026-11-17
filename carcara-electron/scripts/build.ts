import { $ } from "bun";
import { mkdir, readdir } from "node:fs/promises";
import path from "node:path";

const root = path.join(import.meta.dir, "..");
const repoRoot = path.join(root, "..");
const rendererDest = path.join(root, "dist", "renderer");
const assetsDest = path.join(rendererDest, "assets");
const imgSrcDir = path.join(repoRoot, "assets/img");
const primaryLogo = "logo_moderno_final.png";

await $`tsc`.cwd(root);
await mkdir(assetsDest, { recursive: true });

const bundle = await Bun.build({
  entrypoints: [path.join(root, "src/renderer/main.ts")],
  outdir: rendererDest,
  target: "browser",
  format: "iife",
  naming: "renderer.js",
});

if (!bundle.success) {
  console.error("[carcara-electron] renderer bundle failed:");
  for (const log of bundle.logs) console.error(log);
  process.exit(1);
}

await $`cp ${path.join(root, "src/renderer/index.html")} ${rendererDest}/`;
await $`cp ${path.join(root, "src/renderer/styles.css")} ${rendererDest}/`;

const images = (await readdir(imgSrcDir)).filter((name) =>
  /\.(png|jpe?g|webp|svg)$/i.test(name),
);
for (const name of images) {
  await $`cp ${path.join(imgSrcDir, name)} ${path.join(assetsDest, name)}`;
}
await $`cp ${path.join(assetsDest, primaryLogo)} ${path.join(assetsDest, "logo.png")}`;

console.log(
  `[carcara-electron] build ok (renderer bundle + ${images.length} images)`,
);
