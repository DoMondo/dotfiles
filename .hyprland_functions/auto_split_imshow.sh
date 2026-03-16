#!/bin/bash

# Monitor for new imshow_python windows and apply vertical split
# This script uses the Hyprland socket to listen for window events

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Check if socket exists
if [ ! -S "$SOCKET" ]; then
    echo "Hyprland socket not found: $SOCKET"
    exit 1
fi

# Function to handle window events
handle_event() {
    local event="$1"
    
    # Check if it's an openwindow event
    if [[ "$event" =~ ^openwindow\>\>([^,]+),([^,]+),([^,]+),(.+)$ ]]; then
        local address="${BASH_REMATCH[1]}"
        local workspace="${BASH_REMATCH[2]}"
        local class="${BASH_REMATCH[3]}"
        local title="${BASH_REMATCH[4]}"
        
        # Check if title starts with imshow_python
        if [[ "$title" =~ ^imshow_python ]]; then
            # Small delay to ensure window is fully created
            sleep 0.1
            # Force vertical split for the window
            hyprctl dispatch hy3:makegroup v
        fi
    fi
}

# Read from socket using nc (netcat) or direct file reading
if command -v nc &> /dev/null; then
    nc -U "$SOCKET" | while read -r line; do
        handle_event "$line"
    done
else
    # Fallback: use direct socket reading with bash
    while true; do
        if [ -S "$SOCKET" ]; then
            exec 3<>"$SOCKET"
            while read -r line <&3; do
                handle_event "$line"
            done
            exec 3>&-
        fi
        sleep 1
    done
fi
