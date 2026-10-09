#!/usr/bin/env bash

# Check whether the fortisslvpn pppd plugin matches the installed pppd version
CHECK_OUTPUT=$("$HOME/repo/dotfiles/scripts/check_forti_pppd.sh")

# If there is a mismatch (or the plugin is missing) trigger a rebuild in kitty
if echo "$CHECK_OUTPUT" | grep -q -i "mismatch\|not found"; then
    echo "$CHECK_OUTPUT"
    echo "Triggering networkmanager-fortisslvpn rebuild..."

    # Launch kitty to run the rebuild script interactively so the user can enter their sudo password
    kitty --title "Rebuilding forti" bash -c "$HOME/repo/dotfiles/scripts/forti_rebuild.sh"

    # After kitty closes, re-check
    "$HOME/repo/dotfiles/scripts/check_forti_pppd.sh"
else
    echo "$CHECK_OUTPUT"
fi
