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
        xpos=`hyprctl activewindow | grep at\: | cut -d',' -f1 | cut -d' ' -f2`
        width=`hyprctl activewindow | grep size\: | cut -d',' -f1 | cut -d' ' -f2`
        right_border_pos=$((xpos + width))
        hyprctl dispatch hy3:movewindow r
        xpos=`hyprctl activewindow | grep at\: | cut -d',' -f1 | cut -d' ' -f2`
        width=`hyprctl activewindow | grep size\: | cut -d',' -f1 | cut -d' ' -f2`
        new_right_border_pos=$((xpos + width))
        if [[ "$right_border_pos" == "$new_right_border_pos" ]] && \
           [[ $(($current_workspace % 2)) -eq 1 ]]
        then
           echo move to workspace $((($current_workspace + 1)))
           hyprctl dispatch movetoworkspace $((($current_workspace + 1)))
        fi
       ;;
     "l")
        xpos=`hyprctl activewindow | grep at\: | cut -d',' -f1 | cut -d' ' -f2`
        hyprctl dispatch hy3:movewindow l
        new_xpos=`hyprctl activewindow | grep at\: | cut -d',' -f1 | cut -d' ' -f2`
        if [[ "$xpos" == "$new_xpos" ]] && \
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
