#!/bin/bash
. app/config/config.sh
. app/scripts/software/presets/_common.sh
#----------------------------------------------------------------------------------------------------#
# Script: Gaming light preset
# Descrição: Steam + Heroic + Lutris.
#----------------------------------------------------------------------------------------------------#

isRoot

failed=0
for rel in \
	games/steam.sh \
	games/heroic.sh \
	games/lutris.sh
do
	if ! carcara_preset_run "$rel"; then
		carcara_err "Gaming light step failed: $rel"
		failed=1
	fi
done

if [[ "$failed" -ne 0 ]]; then
	carcara_err "Gaming light finished with errors"
	exit 1
fi
carcara_log "Gaming light preset complete"
exit 0
# Fim
