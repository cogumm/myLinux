#!/bin/bash
. app/config/config.sh
. app/scripts/software/presets/_common.sh
#----------------------------------------------------------------------------------------------------#
# Script: Social box preset
# Descrição: Discord + Telegram + WhatsApp + Spotify.
#----------------------------------------------------------------------------------------------------#

isRoot

failed=0
for rel in \
	social/discord.sh \
	social/telegram.sh \
	social/whatsapp.sh \
	social/spotify.sh
do
	if ! carcara_preset_run "$rel"; then
		carcara_err "Social box step failed: $rel"
		failed=1
	fi
done

if [[ "$failed" -ne 0 ]]; then
	carcara_err "Social box finished with errors"
	exit 1
fi
carcara_log "Social box preset complete"
exit 0
# Fim
