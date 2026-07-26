#!/usr/bin/env bash

if hyprctl clients | grep -q "class: com.github.hluk.copyq"; then
    copyq hide
else
    copyq show
    # Wait up to 1 second (50 * 0.02s) for the window to be mapped/visible
    for _ in {1..50}; do
        if hyprctl clients | grep -q "class: com.github.hluk.copyq"; then
            hyprctl dispatch resizewindowpixel exact 65% 65%,class:com.github.hluk.copyq
            hyprctl dispatch centerwindow class:com.github.hluk.copyq
            break
        fi
        sleep 0.02
    done
fi
