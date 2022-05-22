#!/bin/sh
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/google-chrome/'Local State'
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/; s/"exit_type":"[^"]\+"/"exit_type":"Normal"/' ~/.config/google-chrome/Default/Preferences
google-chrome-stable "$@"
