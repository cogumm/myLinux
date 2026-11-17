import { app } from "electron";
import path from "node:path";

/**
 * Repo root containing `carcara/`, `locales/`, `dotfiles/`.
 * Packaged layout: `resources/mylinux/` (electron-builder extraResources).
 */
export function getRepoRoot(): string {
  if (app.isPackaged) {
    return path.join(process.resourcesPath, "mylinux");
  }
  return path.join(__dirname, "..", "..");
}

/** Allowlisted helper — same relative path in repo and in the .deb. */
export function getHelperScript(): string {
  return path.join(
    getRepoRoot(),
    "carcara-electron",
    "helper",
    "carcara-helper.sh",
  );
}

export function getLocalesDir(): string {
  return path.join(getRepoRoot(), "locales");
}

export function getLicensePath(): string {
  return path.join(getRepoRoot(), "carcara", "app", "config", "license");
}

export function getRendererDir(): string {
  if (app.isPackaged) {
    return path.join(app.getAppPath(), "dist", "renderer");
  }
  return path.join(__dirname, "renderer");
}
