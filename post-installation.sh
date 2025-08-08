#!/usr/bin/env bash
set -e

DIR=$(pwd)

echo ------------------------------- Installing pikaur
if ! command -v  pikaur &> /dev/null
then
   mkdir -p ~/repos_ajenos
   cd ~/repos_ajenos
   sudo pacman -S --needed base-devel git
   git clone https://aur.archlinux.org/pikaur.git
   cd pikaur
   makepkg -fsri
fi

echo ------------------------------- Installing Packages
cd $DIR
pikaur -S --needed --noconfirm `cat pkglist.txt`

chsh -s $(which zsh)

./linking.sh

echo ------------------------------- Installing manual packages
mkdir -p ~/repos_ajenos
cd ~/repos_ajenos
git clone https://github.com/rupa/z || true
git clone https://github.com/rupa/v || true
cd ~/repos_ajenos/v
sudo cp v /usr/local/bin

echo ------------------------------- Configuring hyprland plugins
hyprpm update
hyprpm add https://github.com/outfoxxed/hy3
hyprpm enable hy3

sudo systemctl reboot
