#!/usr/bin/env zsh
DIR=$(pwd)
ln -sfv $DIR/.vimrc ~
ln -sfv $DIR/.zshrc.local ~
ln -sfv $DIR/.gtkrc-2.0 ~
ln -sfv $DIR/.gitignore_global ~
ln -sfv $DIR/.config/pikaur.conf ~/.config/pikaur.conf
ln -sfv $DIR/.config/i3/config ~/.config/i3/
ln -sfv $DIR/.config/i3/i3status.conf ~/.config/i3/
ln -sfv $DIR/.clang-format ~/.clang-format
mkdir ~/.config/yapf
ln -sfv $DIR/.style.yapf ~/.config/yapf/.style.yapf
ln -sfv $DIR/.fzf.zsh ~/.fzf.zsh
ln -sfv $DIR/.ls++.conf ~/.ls++.conf
ln -sfv $DIR/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sfv $DIR/.config/ranger/rc.conf ~/.config/ranger/rc.conf

mkdir  $HOME/.local/share/fonts

# vim stuff
mkdir $HOME/.vim
mkdir $HOME/.vim/undo
mkdir $HOME/.vim/backup
mkdir $HOME/.vim/swapfiles
mkdir $HOME/.vim/colors
mkdir $HOME/.vim/bundle
mkdir $HOME/.vim/bundle/vim-airline-themes
mkdir $HOME/.vim/bundle/autoload
mkdir $HOME/.vim/bundle/autoload/airline
mkdir $HOME/.vim/bundle/autoload/airline/themes
ln -sfv $DIR/wombat_oscar.vim ~/.vim/colors/wombat_oscar.vim
ln -sfv $DIR/airline_theme/minimalist_domondo.vim ~/.vim/bundle/vim-airline-themes/autoload/airline/themes/minimalist_domondo.vim

mkdir  $HOME/.local/share/fonts
cp $DIR/fonts/* $HOME/.local/share/fonts

fc-cache -f $HOME/.local/share/fonts

mkdir ~/lock-i3-desktop/
ln -sfv $DIR/i3-exit ~/lock-i3-desktop/i3-exit
git config --global core.excludesfile ~/.gitignore_global
mkdir $HOME/.zfunctions

ln -sfv $DIR/pure.zsh $HOME/.zfunctions/prompt_pure_setup
ln -sfv $DIR/async.zsh $HOME/.zfunctions/async
