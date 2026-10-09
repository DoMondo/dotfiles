#!/bin/bash
ACTION=$1
LOG_FILE="/tmp/waybar-vpn.log"

echo "[$(date)] Waybar VPN Action: $ACTION" >> "$LOG_FILE"

if [ "$ACTION" == "up" ]; then
    "$HOME/repo/dotfiles/scripts/load_forti.sh" >> "$LOG_FILE" 2>&1
    /usr/bin/nmcli connection up 'VPN' >> "$LOG_FILE" 2>&1
elif [ "$ACTION" == "down" ]; then
    /usr/bin/nmcli connection down 'VPN' >> "$LOG_FILE" 2>&1
fi

# Refresh Waybar module status
pkill -RTMIN+8 waybar
