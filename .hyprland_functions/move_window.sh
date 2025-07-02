#!/bin/bash

# ONLY FOR left to right dual monitors setups!
# The idea is to try to perform a movewindow. If the window is at the border, we 
# can try to move it to the next monitor like it did with i3.

number_of_screens=`hyprctl monitors | grep ID | wc -l`
if [[ $number_of_screens == "1" ]] 
then
case "$1" in
  "r")
     hyprctl dispatch hy3:movewindow r
     exit 0
    ;;
  "l")
     hyprctl dispatch hy3:movewindow l
     exit 0
    ;;
  "u")
     hyprctl dispatch hy3:movewindow u
     exit 0
    ;;
  "d")
     hyprctl dispatch hy3:movewindow d
     exit 0
    ;;
esac
fi

window_pos=`hyprctl activewindow | grep at\:`
current_workspace=`hyprctl activeworkspace | head -1 | cut -d ' ' -f 3`

if [[ $number_of_screens == "2" ]] 
then
   case "$1" in
     "r")
        hyprctl dispatch hy3:movewindow r
        new_window_pos=`hyprctl activewindow | grep at\:`
        if [[ "$window_pos" == "$new_window_pos" ]] && \
           [[ $(($current_workspace % 2)) -eq 1 ]]
        then
           hyprctl dispatch movetoworkspace $((($current_workspace + 1)))
        fi
       ;;
     "l")
        hyprctl dispatch hy3:movewindow l
        new_window_pos=`hyprctl activewindow | grep at\:`
        if [[ "$window_pos" == "$new_window_pos" ]] && \
           [[ $(($current_workspace % 2)) -eq 0 ]]
        then
           hyprctl dispatch movetoworkspace $((($current_workspace - 1)))
        fi
       ;;
     "u")
        hyprctl dispatch hy3:movewindow u
       ;;
     "d")
        hyprctl dispatch hy3:movewindow d
       ;;
   esac
fi
