#!/bin/bash

# `hyprctl getoption plugin:hyprbars:enabled`
# This is shadowed by the global plugin state, thus I'll use the text size as a 
# workaround

if hyprctl getoption plugin:hyprbars:bar_text_size | grep 11
then
   hyprctl keyword plugin:hyprbars:enabled true
   hyprctl keyword plugin:hyprbars:bar_text_size 10
else
   hyprctl keyword plugin:hyprbars:enabled false
   hyprctl keyword plugin:hyprbars:bar_text_size 11
fi
