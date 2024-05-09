#!/bin/bash 

sleep 2
setxkbmap -layout us -variant altgr-intl -option ctrl:nocaps && xset r rate 200 40
killall xcape
xcape -t 200 -e 'Control_L=Escape'
