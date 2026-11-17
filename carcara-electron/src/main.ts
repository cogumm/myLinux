import { app, BrowserWindow, ipcMain } from "electron";
import { spawn } from "node:child_process";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { installAppMenu } from "./app-menu";
import { env } from "./env";
import { openExternalUrl } from "./open-external";

/** Same disclaimer file as Carcará 1.x Zenity license gate. */
const LICENSE_PATH = path.join(
  __dirname,
  "..",
  "..",
  "carcara",
  "app",
  "config",
  "license",
);

/** Bun Shell bridge — privilege allowlist runs under Bun, not Electron's Node. */
const HELPER_BRIDGE = path.join(__dirname, "..", "scripts", "run-helper.ts");

/** Same policy as Carcará 1.x `isRoot` — maintenance UI only as root. */
function requireRoot(): void {
  if (!env.CARCARA_REQUIRE_ROOT) return;
  const uid = typeof process.getuid === "function" ? process.getuid() : -1;
  if (uid === 0) return;
  console.error("");
  console.error("[carcara] Você precisa ter poderes administrativos (root)");
  console.error("[carcara] O aplicativo está sendo finalizado.");
  console.error("[carcara] Use: sudo ./start.sh --electron");
  console.error("");
  app.exit(1);
}

type RunResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

function runHelper(action: string): Promise<RunResult> {
  return new Promise((resolve) => {
    const child = spawn("bun", [HELPER_BRIDGE, action], {
      env: process.env,
    });

    // Merge stdout+stderr in arrival order so Atividade stays chronological
    // ([carcara] logs are stderr; apt is often stdout).
    let combined = "";
    const append = (chunk: Buffer): void => {
      combined += chunk.toString();
    };
    child.stdout.on("data", append);
    child.stderr.on("data", append);
    child.on("error", (err) => {
      combined += `${err.message}\n`;
      if (err.message.includes("ENOENT")) {
        combined += "Bun not found on PATH — install from https://bun.sh\n";
      }
      resolve({ code: 127, stdout: combined, stderr: "" });
    });
    child.on("close", (code) => {
      resolve({ code, stdout: combined, stderr: "" });
    });
  });
}

function createWindow(): void {
  const logoPath = path.join(
    __dirname,
    "renderer",
    "assets",
    "logo_moderno_final.png",
  );
  const win = new BrowserWindow({
    width: env.CARCARA_WINDOW_WIDTH,
    height: env.CARCARA_WINDOW_HEIGHT,
    minWidth: env.CARCARA_WINDOW_MIN_WIDTH,
    minHeight: env.CARCARA_WINDOW_MIN_HEIGHT,
    title: "Carcará 2.0",
    icon: logoPath,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
    },
  });

  void win.loadFile(path.join(__dirname, "renderer", "index.html"));
}

const ALLOWED_EXTERNAL = new Set([
  "https://ko-fi.com/cogumm",
  "https://t.me/CoGUMm",
  "https://cogumm.mit-license.org/",
  "https://github.com/cogumm/myLinux",
]);

app.whenReady().then(() => {
  requireRoot();
  installAppMenu();

  ipcMain.handle("helper:run", async (_event, action: string) => {
    if (typeof action !== "string" || !/^[a-z][a-z0-9-]*$/.test(action)) {
      return { code: 2, stdout: "", stderr: "invalid action\n" };
    }
    return runHelper(action);
  });

  ipcMain.handle("shell:openExternal", async (_event, url: string) => {
    if (typeof url !== "string" || !ALLOWED_EXTERNAL.has(url)) {
      return { ok: false as const, error: "URL não permitida" };
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
    return readFile(LICENSE_PATH, "utf8");
  });

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
