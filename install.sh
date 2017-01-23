#!/usr/bin/env bash
DIR=$(pwd)
ln -sfv $DIR/.vimrc ~
ln -sfv $DIR/.zshrc.local ~
ln -sfv $DIR/.gtkrc-2.0 ~
ln -sfv $DIR/.gitignore_global ~
ln -sfv $DIR/.config/i3/config ~/.config/i3/
ln -sfv $DIR/.config/i3/i3status.conf ~/.config/i3/
git config --global core.excludesfile ~/.gitignore_global
