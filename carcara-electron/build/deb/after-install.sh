#!/bin/bash
# electron-builder deb afterInstall — wrap binary so GUI launches elevated (1.x parity).
# Do not use brace expansion like $ { LetterOnly } — FPM treats those as macros.
set -euo pipefail

OPT_DIR=""
for d in /opt/Carcara /opt/carcara /opt/Carcará; do
	if [[ -d "$d" ]]; then
		OPT_DIR="$d"
		break
	fi
done

if [[ -z "$OPT_DIR" ]]; then
	OPT_DIR="$(find /opt -maxdepth 1 -type d \( -iname 'carcara*' \) 2>/dev/null | head -n1 || true)"
fi

if [[ -z "$OPT_DIR" || ! -d "$OPT_DIR" ]]; then
	echo "[carcara] after-install: /opt/Carcara* not found — skip wrapper" >&2
	exit 0
fi

REAL_BIN="$OPT_DIR/carcara"
if [[ -f "$REAL_BIN" && ! -f "$OPT_DIR/carcara.bin" ]]; then
	mv "$REAL_BIN" "$OPT_DIR/carcara.bin"
fi
REAL_BIN="$OPT_DIR/carcara.bin"
if [[ ! -x "$REAL_BIN" ]]; then
	echo "[carcara] after-install: binary missing at $REAL_BIN" >&2
	exit 0
fi

install -d /usr/bin
cat > /usr/bin/carcara <<'WRAPPER'
#!/bin/bash
# Carcará 2.0 launcher — elevates like 1.x when not root.
set -euo pipefail
APP="__CARCARA_BIN__"
ARGS=(--no-sandbox)
if [[ "${LIBGL_ALWAYS_SOFTWARE:-}" == "1" ]]; then
	export LIBGL_ALWAYS_SOFTWARE=1
fi
if [[ "$(id -u)" -ne 0 ]]; then
	if command -v pkexec >/dev/null 2>&1; then
		exec pkexec env DISPLAY="${DISPLAY:-}" WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-}" \
			XAUTHORITY="${XAUTHORITY:-}" XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-}" \
			DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-}" \
			LIBGL_ALWAYS_SOFTWARE="${LIBGL_ALWAYS_SOFTWARE:-}" \
			"$APP" "${ARGS[@]}" "$@"
	fi
	echo "[carcara] Precisa de root. Use: sudo carcara" >&2
	exit 1
fi
exec "$APP" "${ARGS[@]}" "$@"
WRAPPER

# Inject binary path without brace macros in this maintainer script.
sed -i "s|__CARCARA_BIN__|$REAL_BIN|g" /usr/bin/carcara
chmod 755 /usr/bin/carcara

if [[ -d /usr/share/applications ]]; then
	for desk in /usr/share/applications/*[Cc]arcara*.desktop; do
		[[ -f "$desk" ]] || continue
		sed -i 's|^Exec=.*|Exec=carcara %U|' "$desk" || true
	done
fi

echo "[carcara] Installed wrapper: /usr/bin/carcara → $REAL_BIN"
