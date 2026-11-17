/**
 * Bun bridge for Carcará 2.0 privilege actions.
 * Electron main spawns: `bun run scripts/run-helper.ts <action>`
 * Uses Bun Shell ($`) for safe argv interpolation — see https://bun.sh/docs/runtime/shell
 */
import { $ } from "bun";
import path from "node:path";

const action = process.argv[2] ?? "";

if (!/^[a-z][a-z0-9-]*$/.test(action)) {
  console.error("[carcara-helper-bridge] invalid action");
  process.exit(2);
}

const helper = path.join(import.meta.dir, "..", "helper", "carcara-helper.sh");
const uid = typeof process.getuid === "function" ? process.getuid() : -1;
const hasPkexec = Boolean(Bun.which("pkexec"));
const hasDisplay = Boolean(process.env.DISPLAY || process.env.WAYLAND_DISPLAY);
const usePkexec = uid !== 0 && hasPkexec && hasDisplay;

if (uid !== 0 && !hasPkexec && hasDisplay) {
  console.error(
    "[carcara-helper-bridge] pkexec not found — running helper without elevation",
  );
}

$.nothrow();

const result = usePkexec
  ? await $`pkexec ${helper} ${action}`.quiet()
  : await $`${helper} ${action}`.quiet();

process.stdout.write(result.stdout);
process.stderr.write(result.stderr);
process.exit(result.exitCode);
