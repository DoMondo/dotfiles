#!/bin/bash

set -e 
cd /home/ogomez
echo exec i3 > .xinitrc
echo "if [[ -z \$DISPLAY ]] && [[ \$(tty) = /dev/tty1 ]]; then exec startx; fi" >> /home/ogomez/.bash_profile

mkdir repo && cd repo
sudo -u ogomez git clone https://github.com/DoMondo/dotfiles.git
cd dotfiles
sudo -u ogomez ./post-installation.sh
