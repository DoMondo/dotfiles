#!/bin/bash

# ONLY FOR left to right dual monitors setups!

# The idea is to try to perform a movefocus. If the window is at the border, we 
# can try to move it to the next monitor like it did with i3.

number_of_screens=`hyprctl monitors | grep ID | wc -l`
if [[ $number_of_screens == "1" ]] 
then
case "$1" in
  "r")
     hyprctl dispatch hy3:movefocus r
     exit 0
    ;;
  "l")
     hyprctl dispatch hy3:movefocus l
     exit 0
    ;;
  "u")
     hyprctl dispatch hy3:movefocus u
     exit 0
    ;;
  "d")
     hyprctl dispatch hy3:movefocus d
     exit 0
    ;;
esac
fi

window_info=`hyprctl activewindow | head -1 | cut -d ' ' -f 2`
current_workspace=`hyprctl activeworkspace | head -1 | cut -d ' ' -f 3`

if [[ $number_of_screens == "2" ]] 
then
   case "$1" in
     "r")
        hyprctl dispatch hy3:movefocus r
        new_window_info=`hyprctl activewindow | head -1 | cut -d ' ' -f 2`
        # If it did not move and we are at an odd workspace, move it to the next
        # one
        if [[ "$window_info" == "$new_window_info" ]] && \
           [[ $(($current_workspace % 2)) -eq 1 ]]
        then
           hyprctl dispatch workspace +1 
        fi
        exit 0
       ;;
     "l")
        hyprctl dispatch hy3:movefocus l
        new_window_info=`hyprctl activewindow | head -1 | cut -d ' ' -f 2`
        # If it did not move and we are at an even workspace, move it to the next
        # one
        if [[ "$window_info" == "$new_window_info" ]] && \
           [[ $(($current_workspace % 2)) -eq 0 ]]
        then
           hyprctl dispatch workspace -1 
        fi
        exit 0
       ;;
     "u")
        hyprctl dispatch hy3:movefocus u
        exit 0
       ;;
     "d")
        hyprctl dispatch hy3:movefocus d
        exit 0
       ;;
   esac
fi
