/**
 * Bun bridge for Carcará 2.0 privilege actions.
 * Electron main spawns: `bun run scripts/run-helper.ts <action>`
 * Uses Bun Shell ($`) for safe argv interpolation — see https://bun.sh/docs/runtime/shell
 */
import { $ } from "bun";
import path from "node:path";
import { env } from "../src/env.ts";

// Ensure validated ping defaults reach the Bash helper / testConnection.sh
process.env.CARCARA_TEST_HOST = env.CARCARA_TEST_HOST;
process.env.CARCARA_TEST_COUNT = String(env.CARCARA_TEST_COUNT);

const action = process.argv[2] ?? "";

if (!/^[a-z][a-z0-9-]*$/.test(action)) {
  console.error("[carcara-helper-bridge] invalid action");
  process.exit(2);
}

/** Actions that do not need root / pkexec. */
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

const helper = path.join(import.meta.dir, "..", "helper", "carcara-helper.sh");
const uid = typeof process.getuid === "function" ? process.getuid() : -1;
const needsElevation = !UNPRIVILEGED.has(action);
const hasPkexec = Boolean(Bun.which("pkexec"));
const hasDisplay = Boolean(process.env.DISPLAY || process.env.WAYLAND_DISPLAY);
const usePkexec = needsElevation && uid !== 0 && hasPkexec && hasDisplay;

if (needsElevation && uid !== 0 && !hasPkexec) {
  console.error(
    "[carcara-helper-bridge] pkexec ausente — ação privilegiada sem elevação (comum no WSL). Em desktop Linux instale policykit-1; ou rode já como root.",
  );
}

$.nothrow();

const result = usePkexec
  ? await $`pkexec ${helper} ${action}`.quiet()
  : await $`${helper} ${action}`.quiet();

process.stdout.write(result.stdout);
process.stderr.write(result.stderr);
process.exit(result.exitCode);
