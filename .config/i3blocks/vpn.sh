#!/bin/bash

if nmcli connection show | grep -q vpn; then
  if nmcli -f GENERAL.STATE con show 'VPN' | grep 'activated' &>/dev/null; then
    status='{"text": "VPN 🔒", "class":"enabled"}'
  elif nmcli -f GENERAL.STATE con show 'VPN' | grep 'activating' &>/dev/null; then
    status='{"text": "VPN 🔓", "class":"loading"}'
  else
    status='{"text": "VPN 🔓", "class":"disabled"}'
  fi
else
  status='{"text": ""}'
fi

echo $status
