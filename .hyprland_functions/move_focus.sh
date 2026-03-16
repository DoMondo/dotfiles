#!/bin/bash

# move_focus.sh <direction>
# Directions: l, r, u, d

DIR=$1

# Get current window address
PREV_WIN=$(hyprctl activewindow -j | jq -r '.address' 2>/dev/null)

# Try moving focus with hy3 (handles tree-based navigation)
hyprctl dispatch hy3:movefocus "$DIR"

# Get new window address
NEXT_WIN=$(hyprctl activewindow -j | jq -r '.address' 2>/dev/null)

# If focus didn't move to a different window, try native movefocus
# This handles crossing monitors where hy3 might fail to select a window
if [ "$PREV_WIN" = "$NEXT_WIN" ] || [ "$NEXT_WIN" = "null" ]; then
    hyprctl dispatch movefocus "$DIR"
fi
