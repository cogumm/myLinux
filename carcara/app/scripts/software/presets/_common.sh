#!/bin/bash
# Shared helpers for Wave C presets (source from carcara/ cwd).
# Expects config.sh already sourced.

carcara_preset_run() {
	local rel="${1:-}"
	local script="app/scripts/software/${rel}"
	if [[ -z "$rel" || ! -f "$script" ]]; then
		carcara_err "preset: missing script $script"
		return 1
	fi
	carcara_log "preset → $rel"
	export CARCARA_NONINTERACTIVE=1
	bash "$script"
}
