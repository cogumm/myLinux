# Releases

Per-version notes live here as `X.Y.Z.md`.

| Version | Notes |
|---------|--------|
| [2.0.2](2.0.2.md) | Electron as desktop user (not root); helper/pkexec only — **in progress** |
| [2.0.1](2.0.1.md) | Catalog A–C, `.deb`+AppImage CI, smoke |

**Process** (also `memory-bank/systemPatterns.md` #16):

1. Bump `carcara-electron/package.json` `"version"`.
2. Write `docs/releases/X.Y.Z.md`.
3. Commit → annotated tag `vX.Y.Z` on that commit.
4. Publish GitHub Release (CI attaches `.deb` + AppImage).

Inbox: `memory-bank/TODO.md`.