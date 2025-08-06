#!/bin/bash

if nmcli connection show | grep -q vpn; then
  if nmcli -f GENERAL.STATE con show 'VPN' | grep 'activated' &>/dev/null; then
    status='{"text": "VPN On 🔒"}'
  elif nmcli -f GENERAL.STATE con show 'VPN' | grep 'activating' &>/dev/null; then
    status='{"text": "VPN Connecting"}'
  else
    status='{"text": "VPN Off 🔓"}'
  fi
else
  status='{"text": ""}'
fi

echo $status
