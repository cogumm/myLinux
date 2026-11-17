import { app, BrowserWindow, ipcMain } from "electron";
import { spawn } from "node:child_process";
import path from "node:path";
import { installAppMenu } from "./app-menu";
import { openExternalUrl } from "./open-external";

/** Bun Shell bridge — privilege allowlist runs under Bun, not Electron's Node. */
const HELPER_BRIDGE = path.join(__dirname, "..", "scripts", "run-helper.ts");

/** Same policy as Carcará 1.x `isRoot` — maintenance UI only as root. */
function requireRoot(): void {
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

    let stdout = "";
    let stderr = "";
    child.stdout.on("data", (chunk: Buffer) => {
      stdout += chunk.toString();
    });
    child.stderr.on("data", (chunk: Buffer) => {
      stderr += chunk.toString();
    });
    child.on("error", (err) => {
      stderr += `${err.message}\n`;
      if (err.message.includes("ENOENT")) {
        stderr += "Bun not found on PATH — install from https://bun.sh\n";
      }
      resolve({ code: 127, stdout, stderr });
    });
    child.on("close", (code) => {
      resolve({ code, stdout, stderr });
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
    width: 1080,
    height: 760,
    minWidth: 780,
    minHeight: 560,
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
