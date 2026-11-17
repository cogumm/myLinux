#!/bin/bash
#---------------------------------------------------------------------------#
# Script: i18n
# Descrição: Carrega locales/pt.json|en.json (repo) — t KEY; CARCARA_LANG=pt|en
#---------------------------------------------------------------------------#

# Idempotent when sourced multiple times.
if [[ -n "${CARCARA_I18N_LOADED:-}" ]]; then
	return 0 2>/dev/null || true
fi
CARCARA_I18N_LOADED=1

declare -A CARCARA_I18N=()

_carcara_i18n_root() {
	local here
	here="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
	printf '%s\n' "${here}/locales"
}

_carcara_resolve_lang() {
	local raw loc
	if [[ -n "${CARCARA_LANG:-}" ]]; then
		raw="$(printf '%s' "${CARCARA_LANG}" | tr '[:upper:]' '[:lower:]')"
		case "$raw" in
			en|en_*|en-*) echo "en" ;;
			*) echo "pt" ;;
		esac
		return 0
	fi
	loc="$(printf '%s' "${LANG:-${LC_MESSAGES:-${LC_ALL:-}}}" | tr '[:upper:]' '[:lower:]')"
	case "$loc" in
		en*) echo "en" ;;
		*) echo "pt" ;;
	esac
}

_carcara_load_locale_file() {
	local file="$1"
	local line key val
	[[ -f "$file" ]] || return 1
	while IFS= read -r line || [[ -n "$line" ]]; do
		# Flat JSON: "key": "value",
		if [[ "$line" =~ ^[[:space:]]*\"([^\"]+)\"[[:space:]]*:[[:space:]]*\"(.*)\"[[:space:]]*,?[[:space:]]*$ ]]; then
			key="${BASH_REMATCH[1]}"
			val="${BASH_REMATCH[2]}"
			# Unescape common JSON sequences we use
			val="${val//\\n/$'\n'}"
			val="${val//\\\"/\"}"
			CARCARA_I18N["$key"]="$val"
		fi
	done <"$file"
	return 0
}

carcara_i18n_init() {
	local lang root file
	lang="$(_carcara_resolve_lang)"
	export CARCARA_LANG="$lang"
	root="$(_carcara_i18n_root)"
	file="${root}/${lang}.json"
	CARCARA_I18N=()
	if ! _carcara_load_locale_file "$file"; then
		echo "[carcara:i18n] missing $file — falling back to pt" >&2
		export CARCARA_LANG="pt"
		_carcara_load_locale_file "${root}/pt.json" || true
	fi
}

# t KEY — prints translation or KEY if missing
t() {
	local key="${1:-}"
	if [[ -z "$key" ]]; then
		return 0
	fi
	if [[ -n "${CARCARA_I18N[$key]+x}" ]]; then
		printf '%s' "${CARCARA_I18N[$key]}"
	else
		printf '%s' "$key"
	fi
}

carcara_i18n_init
