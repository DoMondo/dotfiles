#!/bin/bash

# Opens XnView MP on a directory taken from z's frecency list (~/.z).
#
#   xnview.sh          -> most recently accessed directory
#   xnview.sh --pick   -> choose a directory with rofi (most recent first)

Z_DATA="${_Z_DATA:-$HOME/.z}"

# Z_DATA format (rupa/z): path|rank|timestamp. Sort by timestamp so the
# most recently accessed directory comes first, and keep only real dirs.
z_dirs() {
    [ -f "$Z_DATA" ] || return
    awk -F'|' 'NF >= 3 && $3 ~ /^[0-9]+$/ { print $3 "\t" $1 }' "$Z_DATA" \
        | sort -rn \
        | cut -f2- \
        | while IFS= read -r dir; do
              [ -d "$dir" ] && printf '%s\n' "$dir"
          done
}

launch() {
    [ -d "$1" ] || return 1
    nohup xnviewmp "$1" >/dev/null 2>&1 &
}

case "$1" in
    --pick)
        choice=$(z_dirs | rofi -dmenu -i -p "xnview> ")
        [ -z "$choice" ] && exit 0
        # accept a typed path; fall back to its parent for a file
        [ -d "$choice" ] || choice=$(dirname "$choice")
        launch "$choice"
        ;;
    *)
        dir=$(z_dirs | head -n1)
        [ -n "$dir" ] && launch "$dir"
        ;;
esac
