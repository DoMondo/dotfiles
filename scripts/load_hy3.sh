#!/usr/bin/env bash

# Path to the plugin
PLUGIN_PATH="/usr/lib/libhy3.so"

# Try loading the plugin and capture both stdout and stderr
OUTPUT=$(hyprctl plugin load "$PLUGIN_PATH" 2>&1)

# If the output contains an error (such as 'mismatch' or 'No such file')
# and it is not just telling us the plugin is already loaded
if echo "$OUTPUT" | grep -q -E -i "mismatch|error|no such file"; then
    echo "Failed to load hy3. Triggering rebuild..."
    
    # Launch kitty to run the rebuild script interactively so the user can enter their sudo password
    kitty --title "Rebuilding hy3" bash -c "$HOME/repo/dotfiles/scripts/hy3_rebuild.sh"
    
    # After kitty closes, try to load it again
    hyprctl plugin load "$PLUGIN_PATH"
else
    echo "hy3 plugin loaded successfully or was already loaded."
fi
