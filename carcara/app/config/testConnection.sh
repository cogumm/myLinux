#!/bin/bash
#-------------------------------------------------------------------------------#
# Data criação: 05 de Dezembro de 2015
# Última alteração: 16 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: testConnection
# Descrição: Testa conectividade de rede antes de downloads/atualizações.
# Variáveis: $configYad : Configurações Yad (sem botões) — requer config.sh + yad
#-------------------------------------------------------------------------------#

testConnection() {
	if ! command -v yad >/dev/null 2>&1; then
		echo "testConnection: yad não encontrado. Instale as dependências antes."
		return 1
	fi

	# shellcheck disable=SC2086
	yad --title "Testando conexão" \
		--text "Testando a sua conexão com a internet antes de continuar." \
		$configYad

	if ! ping -c 3 www.google.com >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yad --title "Testando conexão" \
			--text "Favor, verifique a conexão de rede do seu computador." \
			$configYad
		sleep 2
		read -r -p "Refazer o teste de conexão? (y/n): " escolha
		case $escolha in
			y|Y)
				testConnection
				;;
			*)
				# shellcheck disable=SC2086
				yad --title "Testando conexão" \
					--text "Saindo do teste de conexão." \
					$configYad
				sleep 2
				return 1
				;;
		esac
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
fi
