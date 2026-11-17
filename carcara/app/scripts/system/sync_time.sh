#!/bin/bash
[[ -n "${CARCARA_NONINTERACTIVE:-}" ]] || clear
. app/config/config.sh
#-------------------------------------------------------------------------------#
# Data criação: 19 de Agosto de 2025
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: https://t.me/CoGUMm
# Script: sync_time
# Descrição: Sincroniza o relógio (timedatectl NTP ou ntpdate).
# Variáveis: $configYad ; CARCARA_NTP_HOST ; root / CARCARA_NONINTERACTIVE → auto-yes
#-------------------------------------------------------------------------------#
# shellcheck disable=SC2154

TIME_SERVER="${CARCARA_NTP_HOST:-ntp.ubuntu.com}"

_sync_notify() {
	local title="$1"
	local text="$2"
	if [[ -z "${CARCARA_NONINTERACTIVE:-}" ]] && command -v yad >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "$title" --text "$text" $configYad
	else
		echo "[$title] $text"
	fi
}

_sync_via_timedatectl() {
	command -v timedatectl >/dev/null 2>&1 || return 1
	# WSL / containers often lack a real systemd manager.
	if ! timedatectl set-ntp true 2>/dev/null; then
		return 1
	fi
	carcara_log "sync_time: timedatectl set-ntp true"
	timedatectl status || true
	_sync_notify "Sincronizar horário" "NTP do systemd ativado (timedatectl)."
	return 0
}

_ensure_ntpdate() {
	if command -v ntpdate >/dev/null 2>&1; then
		return 0
	fi
	carcara_log "sync_time: installing ntpdate"
	if ! apt_install ntpdate; then
		carcara_err "ntpdate ausente e apt_install falhou"
		return 1
	fi
	command -v ntpdate >/dev/null 2>&1
}

_sync_via_ntpdate() {
	local current_date offset_line server_guess time_diff current_epoch server_epoch

	if ! _ensure_ntpdate; then
		return 1
	fi

	current_date="$(date '+%Y-%m-%d %H:%M:%S')"
	carcara_log "sync_time: querying ${TIME_SERVER}"
	offset_line="$(ntpdate -q "$TIME_SERVER" 2>/dev/null | head -1 || true)"
	if [[ -z "$offset_line" ]]; then
		carcara_err "ntpdate -q ${TIME_SERVER} falhou (rede?)"
		_sync_notify "Sincronizar horário" "Não foi possível consultar ${TIME_SERVER}."
		return 1
	fi

	echo "[carcara] ntpdate -q: $offset_line"
	echo "[carcara] system now: $current_date"

	# Best-effort delta from query line ("offset X.XXX sec"); fall back to force sync.
	if [[ "$offset_line" =~ offset[[:space:]]+(-?[0-9.]+) ]]; then
		server_guess="$(date -d "${current_date} ${BASH_REMATCH[1]} sec" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || true)"
		if [[ -n "$server_guess" ]]; then
			current_epoch="$(date -d "$current_date" +%s)"
			server_epoch="$(date -d "$server_guess" +%s)"
			time_diff=$((server_epoch - current_epoch))
			time_diff="${time_diff#-}"
			echo "[carcara] estimated server time: $server_guess (Δ ${time_diff}s)"
			if ((time_diff <= 60)); then
				_sync_notify "Sincronizar horário" "Relógio já dentro de 1 minuto (Δ ${time_diff}s)."
				return 0
			fi
		fi
	fi

	if ! carcara_confirm "Sincronizar relógio com ${TIME_SERVER} (ntpdate)?"; then
		_sync_notify "Sincronizar horário" "Sincronização ignorada."
		return 0
	fi

	# Already root under Carcará helper / startApp — no nested sudo.
	if ! ntpdate "$TIME_SERVER"; then
		carcara_err "ntpdate ${TIME_SERVER} failed"
		_sync_notify "Sincronizar horário" "Falha ao sincronizar. Veja o log."
		return 1
	fi

	_sync_notify "Sincronizar horário" "Relógio sincronizado via ntpdate."
	return 0
}

sync_time() {
	isRoot
	carcara_log "sync_time: starting (server=${TIME_SERVER})"
	_sync_notify "Sincronizar horário" "Verificando e sincronizando o relógio do sistema."

	if _sync_via_timedatectl; then
		return 0
	fi
	carcara_log "sync_time: timedatectl indisponível — tentando ntpdate"
	_sync_via_ntpdate
}

sync_time
