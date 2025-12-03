#!/bin/bash
# Neovim Configuration Installation Script

set -e

DOTFILES_NVIM="/home/ogomez/repo/dotfiles/.config/nvim"
HOME_NVIM="$HOME/.config/nvim"

echo "🔧 Installing Neovim configuration..."

# Backup existing config if it exists
if [ -e "$HOME_NVIM" ] && [ ! -L "$HOME_NVIM" ]; then
    echo "📦 Backing up existing Neovim config to $HOME_NVIM.backup"
    mv "$HOME_NVIM" "$HOME_NVIM.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Remove existing symlink if it exists
if [ -L "$HOME_NVIM" ]; then
    echo "🗑️  Removing existing symlink"
    rm "$HOME_NVIM"
fi

# Create symlink
echo "🔗 Creating symlink: $HOME_NVIM -> $DOTFILES_NVIM"
ln -sf "$DOTFILES_NVIM" "$HOME_NVIM"

echo "✅ Neovim configuration installed!"
echo ""
echo "Next steps:"
echo "1. Run 'nvim' to start Neovim"
echo "2. Plugins will install automatically on first launch"
echo "3. Restart Neovim after plugin installation completes"
