#!/bin/bash
#-----------------------------------------------------------#
# Data: 19 de Agosto de 2025
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: sync_time
# Descrição: Script de sincronização de horário.
#-----------------------------------------------------------#

YELLOW='\033[0;33m'
NC='\033[0m'
RED='\033[0;31m'

TIME_SERVER=ntp.ubuntu.com

for cmd in ntpdate; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}$cmd is not installed.${NC}"
        read -p "Do you want to install $cmd? (Y/N) [Y]: " install_choice
        install_choice=${install_choice:-Y}
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Installing $cmd...${NC}"
            sudo apt-get update
            sudo apt-get install -y $cmd
        else
            echo -e "${RED}The script cannot continue without $cmd.${NC}"
            exit 1
        fi
    fi
done

get_offset_from_server() {
    ntpdate -q $TIME_SERVER
}

get_current_date() {
    date "+%Y-%m-%d %H:%M:%S"
}

to_epoch() {
    date -d "$1" +%s
}

sync_date() {
    echo -e "${RED}sudo ntpdate $TIME_SERVER ${NC}"
    echo
    sudo ntpdate $TIME_SERVER
    echo -e "${YELLOW}System clock synchronized.${NC}"
}

echo -e "${YELLOW}Checking system time...${NC}"

current_date=$(get_current_date)
offset=$(get_offset_from_server | head -1)

server_date=$(date -d "$current_date $offset sec" "+%Y-%m-%d %H:%M:%S")

current_epoch=$(to_epoch "$current_date")
server_epoch=$(to_epoch "$server_date")

echo -e "${YELLOW}Current system date and time: ${NC}$current_date"
echo -e "${YELLOW}Date and time from time server: ${NC}$server_date"

time_diff=$((server_epoch - current_epoch))
time_diff=${time_diff#-}

if [ "$time_diff" -gt 60 ]; then
    read -p "There is a difference of more than one minute. Do you want to synchronize? (Y/N) [Y]: " choice
    choice=${choice:-Y}
    case "$choice" in 
        Y|y ) sync_date;;
        N|n ) echo -e "${YELLOW}Synchronization skipped.${NC}";;
        * ) echo -e "${RED}Invalid option.${NC}";;
    esac
else
    echo -e "${YELLOW}The time is synchronized within one minute.${NC}"
fi
