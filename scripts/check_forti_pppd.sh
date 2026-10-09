#!/usr/bin/env bash

# Compare the installed pppd version with the one the fortisslvpn plugin was built for.
# The plugin is installed under /usr/lib/pppd/<version>/, so the directory name encodes it.

PPPD_VERSION=$(pppd --version 2>/dev/null | awk '{print $NF}')
PLUGIN=$(ls /usr/lib/pppd/*/nm-fortisslvpn-pppd-plugin.so 2>/dev/null | head -n 1)
PLUGIN_VERSION=$(basename "$(dirname "$PLUGIN" 2>/dev/null)" 2>/dev/null)

if [ -z "$PLUGIN" ]; then
    echo "fortisslvpn pppd plugin not found"
elif [ "$PLUGIN_VERSION" != "$PPPD_VERSION" ]; then
    echo "mismatch: fortisslvpn plugin was built for pppd $PLUGIN_VERSION, but pppd $PPPD_VERSION is installed"
else
    echo "fortisslvpn plugin matches pppd $PPPD_VERSION"
fi
