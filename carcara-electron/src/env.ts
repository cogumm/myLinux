import { config as loadDotenv } from "dotenv";
import path from "node:path";
import { z } from "zod";

const rootDir = path.join(__dirname, "..");
// Dev: carcara-electron/.env. Packaged: optional beside resources (defaults via Zod).
loadDotenv({ path: path.join(rootDir, ".env") });
if (process.resourcesPath) {
  loadDotenv({ path: path.join(process.resourcesPath, "mylinux", ".env") });
}

const flag01 = z
  .union([z.literal("0"), z.literal("1")])
  .default("0")
  .transform((v) => v === "1");

const envSchema = z.object({
  CARCARA_LANG: z
    .string()
    .trim()
    .toLowerCase()
    .default("pt")
    .transform((v) => (v.startsWith("en") ? "en" : "pt")),
  CARCARA_TEST_HOST: z.string().trim().min(1).default("8.8.8.8"),
  CARCARA_TEST_COUNT: z.coerce.number().int().min(1).max(20).default(3),
  /** Default 0: GUI runs as desktop user; privilege via helper/pkexec. */
  CARCARA_REQUIRE_ROOT: flag01,
  CARCARA_WINDOW_WIDTH: z.coerce.number().int().min(640).max(3840).default(1080),
  CARCARA_WINDOW_HEIGHT: z.coerce.number().int().min(480).max(2160).default(760),
  CARCARA_WINDOW_MIN_WIDTH: z.coerce.number().int().min(480).max(3840).default(780),
  CARCARA_WINDOW_MIN_HEIGHT: z.coerce.number().int().min(360).max(2160).default(560),
  LIBGL_ALWAYS_SOFTWARE: z
    .union([z.literal("0"), z.literal("1")])
    .optional()
    .transform((v) => (v === undefined ? undefined : v === "1")),
});

export type CarcaraEnv = z.infer<typeof envSchema>;

function parseEnv(): CarcaraEnv {
  const parsed = envSchema.safeParse(process.env);
  if (!parsed.success) {
    console.error("[carcara] Invalid environment (.env):");
    console.error(z.prettifyError(parsed.error));
    throw new Error("Invalid Carcará environment variables");
  }

  // Keep shell/helper consumers in sync with validated values.
  process.env.CARCARA_LANG = parsed.data.CARCARA_LANG;
  process.env.CARCARA_TEST_HOST = parsed.data.CARCARA_TEST_HOST;
  process.env.CARCARA_TEST_COUNT = String(parsed.data.CARCARA_TEST_COUNT);
  if (parsed.data.LIBGL_ALWAYS_SOFTWARE === true) {
    process.env.LIBGL_ALWAYS_SOFTWARE = "1";
  }

  return parsed.data;
}

export const env: CarcaraEnv = parseEnv();
