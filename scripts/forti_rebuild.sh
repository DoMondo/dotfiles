#!/usr/bin/env bash

# This script rebuilds the networkmanager-fortisslvpn package when invoked
echo "==========================================="
echo "  Rebuilding networkmanager-fortisslvpn"
echo "  This will require sudo password to install"
echo "==========================================="

# Use pikaur to rebuild and install the plugin without asking for confirmations
pikaur -S --rebuild --noconfirm networkmanager-fortisslvpn

echo "==========================================="
echo "  Rebuild complete!"
echo "  Closing window in 5 seconds..."
echo "==========================================="
sleep 5
