#!/bin/bash
. app/config/config.sh
. app/scripts/software/presets/_common.sh
#----------------------------------------------------------------------------------------------------#
# Script: Dev box preset
# Descrição: Git + VS Code + Fira Code + Node toolchain + Docker + Insomnia.
#----------------------------------------------------------------------------------------------------#

isRoot

failed=0
for rel in \
	development/git.sh \
	development/vscode.sh \
	development/firacode.sh \
	development/nodejs.sh \
	development/docker.sh \
	development/insomnia.sh
do
	if ! carcara_preset_run "$rel"; then
		carcara_err "Dev box step failed: $rel"
		failed=1
	fi
done

if [[ "$failed" -ne 0 ]]; then
	carcara_err "Dev box finished with errors"
	exit 1
fi
carcara_log "Dev box preset complete"
exit 0
# Fim
