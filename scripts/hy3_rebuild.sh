#!/usr/bin/env bash

# This script rebuilds the hyprland-plugin-hy3 package when invoked
echo "==========================================="
echo "  Rebuilding hyprland-plugin-hy3"
echo "  This will require sudo password to install"
echo "==========================================="

# Use pikaur to rebuild and install the plugin without asking for confirmations
pikaur -S --rebuild --noconfirm hyprland-plugin-hy3

echo "==========================================="
echo "  Rebuild complete!"
echo "  Closing window in 5 seconds..."
echo "==========================================="
sleep 5
