import { app, BrowserWindow, ipcMain } from "electron";
import { spawn } from "node:child_process";
import path from "node:path";

/** Bun Shell bridge — privilege allowlist runs under Bun, not Electron's Node. */
const HELPER_BRIDGE = path.join(__dirname, "..", "scripts", "run-helper.ts");

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

app.whenReady().then(() => {
  ipcMain.handle("helper:run", async (_event, action: string) => {
    if (typeof action !== "string" || !/^[a-z][a-z0-9-]*$/.test(action)) {
      return { code: 2, stdout: "", stderr: "invalid action\n" };
    }
    return runHelper(action);
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
