#!/bin/bash

# Replaces an active Evince window with the next/previous pdf file in the directory.
CURRENT_INFO=$(hyprctl clients -j | jq -r '.[] | select(.class == "org.gnome.Evince")' | jq -s 'sort_by(.focusHistoryID) | .[0]')

if [ -z "$CURRENT_INFO" ] || [ "$CURRENT_INFO" == "null" ]; then
    notify-send "Error" "There is no active Evince window."
    exit 1
fi

OLD_PID=$(echo "$CURRENT_INFO" | jq -r '.pid')
OLD_ADDR=$(echo "$CURRENT_INFO" | jq -r '.address')
RAW_TITLE=$(echo "$CURRENT_INFO" | jq -r '.title')

FILENAME=$(echo "$RAW_TITLE" | sed 's/ — .*//; s/ - .*//')

# Find current file path in open file descriptors
FULL_PATH=$(ls -l /proc/$OLD_PID/fd 2>/dev/null | grep -i "$FILENAME" | head -n 1 | sed 's/.*-> //')
if [ -z "$FULL_PATH" ] || [ ! -f "$FULL_PATH" ]; then
    FULL_PATH=$(ls -l /proc/$OLD_PID/fd 2>/dev/null | grep -o '/.*\.pdf' | head -n 1)
fi

if [ -z "$FULL_PATH" ] || [ ! -f "$FULL_PATH" ]; then
    notify-send "Error" "No se pudo determinar la ruta del PDF actual."
    exit 1
fi

DIR=$(dirname "$FULL_PATH")
BASE=$(basename "$FULL_PATH")

cd "$DIR" || exit 1
# Natsorted files (.pdf and .PDF)
mapfile -t FILES < <(ls -1v -- *.pdf *.PDF 2>/dev/null)
COUNT=${#FILES[@]}
if [ "$COUNT" -le 1 ]; then
    exit 0
fi

INDEX=-1
for i in "${!FILES[@]}"; do
   if [[ "${FILES[$i]}" == "$BASE" ]]; then
       if [[ "$1" == "next" ]]; then
           INDEX=$(( (i + 1) % COUNT ))
       else
           INDEX=$(( (i - 1 + COUNT) % COUNT ))
       fi
       break
   fi
done

if [ "$INDEX" -lt 0 ]; then
    exit 1
fi

NEXT_FILE="${FILES[$INDEX]}"
FULL_PATH_NEXT="$(realpath "$NEXT_FILE")"

# Launch next PDF in Evince
evince "$FULL_PATH_NEXT" &

# Wait for the new Evince window and swap focus
for i in {1..50}; do
    NEW_ADDR=$(hyprctl clients -j | jq -r ".[] | select(.class == \"org.gnome.Evince\" and .address != \"$OLD_ADDR\") | .address" | head -n 1)
    
    if [ -n "$NEW_ADDR" ] && [ "$NEW_ADDR" != "null" ]; then
        hyprctl dispatch "hl.dsp.window.close({ window = 'address:$OLD_ADDR' })" > /dev/null 2>&1 || hyprctl dispatch closewindow "address:$OLD_ADDR" > /dev/null 2>&1
        hyprctl dispatch "hl.dsp.focus({ window = 'address:$NEW_ADDR' })" > /dev/null 2>&1 || hyprctl dispatch focuswindow "address:$NEW_ADDR" > /dev/null 2>&1
        exit 0
    fi
    sleep 0.02
done

notify-send "Error" "The pdf could not be opened"
