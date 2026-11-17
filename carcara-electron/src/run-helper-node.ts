import { spawn } from "node:child_process";
import { accessSync, constants } from "node:fs";
import path from "node:path";
import { getHelperScript } from "./paths";

export type HelperRunResult = {
  code: number | null;
  stdout: string;
  stderr: string;
};

const UNPRIVILEGED = new Set([
  "ping",
  "dotfiles-dry-run",
  "dotfiles-aliases",
  "dotfiles-all",
  "dotfiles-git",
  "dotfiles-hyper",
  "dotfiles-theme",
  "dotfiles-bashrc",
]);

function which(cmd: string): string | null {
  const dirs = (process.env.PATH ?? "").split(path.delimiter);
  for (const dir of dirs) {
    const candidate = path.join(dir, cmd);
    try {
      accessSync(candidate, constants.X_OK);
      return candidate;
    } catch {
      /* continue */
    }
  }
  return null;
}

/**
 * Privilege bridge without Bun — used by packaged Electron and as fallback.
 * Mirrors `scripts/run-helper.ts` (pkexec when needed).
 */
export function runHelperNode(
  action: string,
  env: NodeJS.ProcessEnv = process.env,
): Promise<HelperRunResult> {
  return new Promise((resolve) => {
    const helper = getHelperScript();
    const uid = typeof process.getuid === "function" ? process.getuid() : -1;
    const needsElevation = !UNPRIVILEGED.has(action);
    const pkexec = which("pkexec");
    const hasDisplay = Boolean(env.DISPLAY || env.WAYLAND_DISPLAY);
    const usePkexec = needsElevation && uid !== 0 && Boolean(pkexec) && hasDisplay;

    if (needsElevation && uid !== 0 && !pkexec) {
      console.error(
        "[carcara] pkexec ausente — ação privilegiada sem elevação. Instale policykit-1 ou rode como root.",
      );
    }

    // pkexec drops most env — pass Carcará vars explicitly (matches after-install launcher).
    const argv =
      usePkexec && pkexec
        ? [
            pkexec,
            "env",
            `PATH=${env.PATH ?? "/usr/bin:/bin"}`,
            `CARCARA_REPO_ROOT=${env.CARCARA_REPO_ROOT ?? ""}`,
            `CARCARA_LANG=${env.CARCARA_LANG ?? "pt"}`,
            `CARCARA_NONINTERACTIVE=1`,
            `CARCARA_TEST_HOST=${env.CARCARA_TEST_HOST ?? "8.8.8.8"}`,
            `CARCARA_TEST_COUNT=${env.CARCARA_TEST_COUNT ?? "2"}`,
            `DISPLAY=${env.DISPLAY ?? ""}`,
            `WAYLAND_DISPLAY=${env.WAYLAND_DISPLAY ?? ""}`,
            `XAUTHORITY=${env.XAUTHORITY ?? ""}`,
            helper,
            action,
          ]
        : [helper, action];
    const child = spawn(argv[0], argv.slice(1), {
      env,
      shell: false,
    });

    let combined = "";
    const append = (chunk: Buffer): void => {
      combined += chunk.toString();
    };
    child.stdout.on("data", append);
    child.stderr.on("data", append);
    child.on("error", (err) => {
      combined += `${err.message}\n`;
      if (err.message.includes("ENOENT")) {
        combined += `Helper missing or not executable: ${helper}\n`;
      }
      resolve({ code: 127, stdout: combined, stderr: "" });
    });
    child.on("close", (code) => {
      resolve({ code, stdout: combined, stderr: "" });
    });
  });
}
