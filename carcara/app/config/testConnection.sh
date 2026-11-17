#!/bin/bash
#-------------------------------------------------------------------------------#
# Data criação: 05 de Dezembro de 2015
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: testConnection
# Descrição: Testa conectividade de rede (ICMP) antes de downloads/atualizações.
#            Alvo padrão: IP do Google Public DNS (8.8.8.8).
# Variáveis: $configYad (Yad, 1.x) ; CARCARA_NONINTERACTIVE (2.0 / CLI)
#            CARCARA_TEST_HOST CARCARA_TEST_COUNT
#-------------------------------------------------------------------------------#
# shellcheck disable=SC2154 # configYad exported by config.sh when sourced

# Google Public DNS — probe canônico do Carcará (não usar hostname aqui).
: "${CARCARA_TEST_HOST:=8.8.8.8}"
: "${CARCARA_TEST_COUNT:=3}"

# quiet=1 → silencioso (1.x Yad); quiet=0 → imprime saída do ping (2.0 / CLI)
_carcara_ping_google() {
	local quiet="${1:-0}"

	if ! command -v ping >/dev/null 2>&1; then
		echo "[carcara:error] comando ping não encontrado (instale iputils-ping)" >&2
		return 127
	fi

	if [[ "${quiet}" == "1" ]]; then
		ping -c "${CARCARA_TEST_COUNT}" -W 2 "${CARCARA_TEST_HOST}" >/dev/null 2>&1
		return $?
	fi

	echo "[carcara] Testando conexão — ping -c ${CARCARA_TEST_COUNT} ${CARCARA_TEST_HOST} (Google)"
	ping -c "${CARCARA_TEST_COUNT}" -W 2 "${CARCARA_TEST_HOST}"
	return $?
}

testConnection() {
	# Electron / helper: sem Yad, saída completa no log.
	if [[ -n "${CARCARA_NONINTERACTIVE:-}" ]]; then
		_carcara_ping_google 0
		return $?
	fi

	if ! command -v yad >/dev/null 2>&1; then
		echo "testConnection: yad não encontrado. Instale as dependências antes."
		return 1
	fi

	# shellcheck disable=SC2086
	yad --title "Testando conexão" \
		--text "Testando a sua conexão com a internet (Google ${CARCARA_TEST_HOST}) antes de continuar." \
		$configYad

	if ! _carcara_ping_google 1; then
		# shellcheck disable=SC2086
		yad --title "Testando conexão" \
			--text "Favor, verifique a conexão de rede do seu computador." \
			$configYad
		sleep 2
		# No terminal y/N under sudo — use Yad; Cancel/No exits once.
		# shellcheck disable=SC2086
		if yad --title "Testando conexão" \
			--text "Refazer o teste de conexão?" \
			--button=gtk-yes:0 --button=gtk-no:1 \
			--center; then
			testConnection
		else
			# shellcheck disable=SC2086
			yad --title "Testando conexão" \
				--text "Saindo do teste de conexão." \
				$configYad
			sleep 2
			return 1
		fi
	else
		# shellcheck disable=SC2086
		yad --title "Testando conexão" \
			--text "Tudo ok com a sua conexão.\nContinuando com o programa." \
			$configYad
		sleep 1
	fi
	return 0
}

# Run only when executed directly (not when sourced by dependences.sh).
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	testConnection
	exit $?
fi
