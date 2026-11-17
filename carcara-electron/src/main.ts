import { app, BrowserWindow, ipcMain } from "electron";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { installAppMenu } from "./app-menu";
import { env } from "./env";
import { nativeT } from "./native-i18n";
import { openExternalUrl } from "./open-external";
import {
  getLicensePath,
  getRendererDir,
  getRepoRoot,
} from "./paths";
import { runHelperNode } from "./run-helper-node";

/** Same policy as Carcará 1.x `isRoot` — maintenance UI only as root. */
function requireRoot(): void {
  if (!env.CARCARA_REQUIRE_ROOT) return;
  const uid = typeof process.getuid === "function" ? process.getuid() : -1;
  if (uid === 0) return;
  console.error("");
  console.error(`[carcara] ${nativeT("main.requireRoot")}`);
  console.error(`[carcara] ${nativeT("main.exiting")}`);
  console.error(`[carcara] ${nativeT("main.useSudo")}`);
  console.error("");
  app.exit(1);
}

function createWindow(): void {
  const rendererDir = getRendererDir();
  const logoPath = path.join(rendererDir, "assets", "logo_moderno_final.png");
  const win = new BrowserWindow({
    width: env.CARCARA_WINDOW_WIDTH,
    height: env.CARCARA_WINDOW_HEIGHT,
    minWidth: env.CARCARA_WINDOW_MIN_WIDTH,
    minHeight: env.CARCARA_WINDOW_MIN_HEIGHT,
    title: nativeT("window.title"),
    icon: logoPath,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
    },
  });

  void win.loadFile(path.join(rendererDir, "index.html"));
}

const ALLOWED_EXTERNAL = new Set([
  "https://cogumm.net/",
  "https://ko-fi.com/cogumm",
  "https://t.me/CoGUMm",
  "https://cogumm.mit-license.org/",
  "https://github.com/cogumm/myLinux",
]);

app.whenReady().then(() => {
  requireRoot();
  installAppMenu();

  // Packaged helper resolves carcara/locales via resources/mylinux.
  process.env.CARCARA_REPO_ROOT = getRepoRoot();
  process.env.CARCARA_LANG = env.CARCARA_LANG;
  process.env.CARCARA_TEST_HOST = env.CARCARA_TEST_HOST;
  process.env.CARCARA_TEST_COUNT = String(env.CARCARA_TEST_COUNT);

  ipcMain.handle("helper:run", async (_event, action: string) => {
    if (typeof action !== "string" || !/^[a-z][a-z0-9-]*$/.test(action)) {
      return { code: 2, stdout: "", stderr: "invalid action\n" };
    }
    return runHelperNode(action, process.env);
  });

  ipcMain.handle("shell:openExternal", async (_event, url: string) => {
    if (typeof url !== "string" || !ALLOWED_EXTERNAL.has(url)) {
      return { ok: false as const, error: nativeT("main.urlDenied") };
    }
    try {
      await openExternalUrl(url);
      return { ok: true as const };
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      return { ok: false as const, error: message };
    }
  });

  ipcMain.handle("license:get", async () => {
    return readFile(getLicensePath(), "utf8");
  });

  ipcMain.handle("app:lang", () => env.CARCARA_LANG);

  ipcMain.handle("app:quit", () => {
    app.quit();
  });

  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
