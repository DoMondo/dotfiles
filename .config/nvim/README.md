# Neovim Configuration

Modern Neovim configuration converted from VimScript to Lua.

## Installation

Run the installation script to create a symlink from `~/.config/nvim` to this directory:

```bash
./install.sh
```

## Quick Start

1. **Install Neovim** (v0.8.0+)
2. **Launch Neovim**: `nvim`
3. **Wait for plugins to install** (automatic on first launch)
4. **Restart Neovim**

## Features

- 🚀 **lazy.nvim** - Fast plugin manager with lazy loading
- 📝 **LaTeX Support** - Extensive helpers for Beamer presentations
- 🎨 **Wombat Theme** - Beautiful dark color scheme
- 🔍 **Git Integration** - Fugitive for Git operations
- 📁 **File Explorer** - nvim-tree for file navigation
- ✨ **Status Line** - lualine with powerline fonts
- 🔧 **Auto-formatting** - Python (yapf), C/C++ (ClangFormat), LaTeX

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>t` - Toggle file tree
- `<C-f>` - Format current file

### LaTeX (`.tex` files only)
- `<leader>l` - Insert itemize list
- `<leader>s` - Insert Beamer frame
- `<leader>C` - Insert two-column layout
- `o` / `O` - Smart `\item` insertion
- `<leader>bb` - Toggle bold
- `<leader>i` - Toggle italic
- `<leader>t` - Toggle typewriter font

### Git
- `<leader>b` - Git blame
- `<leader>g` - GitGutter toggle

## Plugin Management

```vim
:Lazy          " Open plugin manager
:Lazy sync     " Install/update plugins
:Lazy clean    " Remove unused plugins
:Lazy profile  " View startup time
```

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
└── lua/
    ├── config/
    │   ├── settings.lua     # Core settings
    │   ├── keymaps.lua      # Key mappings
    │   ├── autocmds.lua     # Autocommands
    │   ├── functions.lua    # Custom functions
    │   └── latex.lua        # LaTeX keymaps
    └── plugins/
        └── init.lua         # Plugin specs
```

## Requirements

- Neovim ≥ 0.8.0
- Git
- Nerd Font (for icons)
- Python 3 with yapf (for Python formatting)
- clang-format (for C/C++ formatting)

## Customization

Edit files in `~/.config/nvim/lua/config/` to customize settings, keymaps, or add new functionality.
