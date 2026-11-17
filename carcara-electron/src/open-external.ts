import { spawn } from "node:child_process";
import { readFileSync } from "node:fs";
import { shell } from "electron";

const POWERSHELL =
  "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe";
const CMD_EXE = "/mnt/c/Windows/System32/cmd.exe";

export function isWsl(): boolean {
  try {
    return /microsoft/i.test(readFileSync("/proc/version", "utf8"));
  } catch {
    return false;
  }
}

function runDetached(command: string, args: string[]): Promise<void> {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      detached: true,
      stdio: "ignore",
      windowsHide: true,
    });
    child.unref();
    child.on("error", reject);
    child.on("spawn", () => resolve());
    child.on("close", (code) => {
      if (code && code !== 0) reject(new Error(`${command} exited ${code}`));
      else resolve();
    });
  });
}

/** Open HTTPS URL in the host browser (WSL → Windows PowerShell / cmd). */
export async function openExternalUrl(url: string): Promise<void> {
  if (isWsl()) {
    try {
      await runDetached(POWERSHELL, [
        "-NoProfile",
        "-Command",
        `Start-Process '${url.replace(/'/g, "''")}'`,
      ]);
      return;
    } catch {
      try {
        await runDetached(CMD_EXE, ["/c", "start", url]);
        return;
      } catch {
        // fall through
      }
    }
  }

  await shell.openExternal(url);
}
