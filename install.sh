#!/usr/bin/env bash
DIR=$(pwd)
ln -sfv $DIR/.vimrc ~
ln -sfv $DIR/.zshrc.local ~
ln -sfv $DIR/.gtkrc-2.0 ~
ln -sfv $DIR/.gitignore_global ~
ln -sfv $DIR/.config/i3/config ~/.config/i3/
ln -sfv $DIR/.config/i3/i3status.conf ~/.config/i3/
ln -sfv $DIR/.config/konsolerc ~/.config/konsolerc
ln -sfv $DIR/DoMo.profile ~/.local/share/konsole/DoMo.profile
ln -sfv $DIR/DarkPastels.colorscheme ~/.local/share/konsole/DarkPastels.colorscheme
ln -sfv $DIR/wombat_oscar.vim ~/.vim/colors/wombat_oscar.vim

mkdir  $HOME/.local/share/fonts
cp $DIR/fonts/* $HOME/.local/share/fonts

fc-cache -f $HOME/.local/share/fonts

mkdir ~/lock-i3-desktop/
ln -sfv $DIR/i3-exit ~/lock-i3-desktop/i3-exit
git config --global core.excludesfile ~/.gitignore_global
