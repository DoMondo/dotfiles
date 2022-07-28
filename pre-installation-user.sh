#!/bin/bash

set -e 
cd /home/ogomez
mkdir repo && cd repo
sudo -u ogomez git clone https://github.com/DoMondo/dotfiles.git
cd dotfiles
sudo -u ogomez ./post-installation.sh
