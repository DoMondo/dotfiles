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
pikaur -S --needed - < pkglist.txt

chsh -s $(which zsh)

echo ------------------------------- Linking config files
ln -sfv $DIR/.vimrc ~
ln -sfv $DIR/.zshrc ~
ln -sfv $DIR/.zshrc.local ~
touch ~/.zshrc.local.extra
ln -sfv $DIR/.gtkrc-2.0 ~
ln -sfv $DIR/.gitignore_global ~
ln -sfv $DIR/.config/pikaur.conf ~/.config/pikaur.conf
mkdir -p ~/.config/i3
ln -sfv $DIR/.config/i3/config ~/.config/i3/
ln -sfv $DIR/.config/i3/i3status.conf ~/.config/i3/
mkdir -p ~/.config/parcellite
ln -sfv $DIR/.config/parcellite ~/.config/parcellite/parcelliterc
ln -sfv $DIR/.clang-format ~/.clang-format
mkdir -p ~/.config/yapf
ln -sfv $DIR/.style.yapf ~/.config/yapf/.style.yapf
ln -sfv $DIR/.fzf.zsh ~/.fzf.zsh
ln -sfv $DIR/.ls++.conf ~/.ls++.conf
mkdir -p ~/.config/kitty
ln -sfv $DIR/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
mkdir -p ~/.config/ranger
ln -sfv $DIR/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sfv $DIR/.zsh_functions ~/.zsh_functions
mkdir -p ~/.config/dunst
ln -sfv $DIR/.config/dunst/dunstrc ~/.config/dunst/dunstrc
mkdir -p ~/.local/share/fonts
# vim stuff
mkdir -p ~/.vim
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/bundle/vim-airline-themes
mkdir -p ~/.vim/bundle/autoload
mkdir -p ~/.vim/bundle/autoload/airline
mkdir -p ~/.vim/bundle/autoload/airline/themes
vim -c ":PluginInstall"
ln -sfv $DIR/wombat_oscar.vim ~/.vim/colors/wombat_oscar.vim
ln -sfv \
   $DIR/airline_theme/minimalist_domondo.vim \
   ~/.vim/bundle/vim-airline-themes/autoload/airline/themes/minimalist_domondo.vim
mkdir -p  ~/.local/share/fonts
cp $DIR/fonts/* ~/.local/share/fonts
fc-cache -f ~/.local/share/fonts
mkdir -p ~/lock-i3-desktop/
ln -sfv $DIR/i3-exit ~/lock-i3-desktop/i3-exit
git config --global core.excludesfile ~/.gitignore_global
mkdir -p ~/.zfunctions
ln -sfv $DIR/pure.zsh ~/.zfunctions/prompt_pure_setup
ln -sfv $DIR/async.zsh ~/.zfunctions/async

echo ------------------------------- Installing manual packages
mkdir -p ~/repos_ajenos
cd ~/repos_ajenos
git clone https://github.com/rupa/z || true
git clone https://github.com/rupa/v || true
cd ~/repos_ajenos/v
sudo cp v /usr/local/bin
sudo systemctl reboot
