-- Core Neovim settings
-- Converted from .vimrc

local opt = vim.opt
local g = vim.g

-- General settings
opt.compatible = false
opt.encoding = "utf-8"
opt.shell = "/bin/bash"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Backup and swap files
opt.backup = true
opt.backupdir = vim.fn.expand("~/.vim/backup") .. ",/tmp"
opt.directory = vim.fn.expand("~/.vim/swapfiles") .. ",/tmp"

-- Undo
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undo/")

-- Create directories if they don't exist
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p", 0700)
  end
end

ensure_dir(vim.fn.expand("~/.vim"))
ensure_dir(vim.fn.expand("~/.vim/backup"))
ensure_dir(vim.fn.expand("~/.vim/swapfiles"))
ensure_dir(vim.fn.expand("~/.vim/undo"))

-- History and command line
opt.history = 50
opt.showcmd = true

-- UI
opt.number = true
opt.cursorline = true
opt.ruler = true
opt.laststatus = 2
opt.scrolloff = 5
opt.termguicolors = true

-- Indentation
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 3
opt.tabstop = 3
opt.autoindent = true

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Timeouts
opt.timeoutlen = 1000
opt.ttimeoutlen = 0

-- Mouse
opt.mouse = "a"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- File info
opt.viminfo = "'100,f1"

-- Color scheme
opt.background = "dark"
vim.cmd("syntax on")
vim.cmd("colorscheme wombat_oscar")

-- Global variables
g.tex_flavor = "latex"
g.mapleader = " "
g.maplocalleader = " "

-- Plugin-specific settings

-- Autopep8
g.autopep8_disable_show_diff = 1
g.autopep8_max_line_length = 79

-- YCM (if still using)
g.ycm_confirm_extra_conf = 0
g.ycm_server_python_interpreter = "/usr/bin/python"
g.ycm_enable_diagnostic_signs = 0
g.ycm_enable_diagnostic_highlighting = 0
g.ycm_echo_current_diagnostic = 0
g.ycm_server_use_vim_stdout = 0
g.ycm_server_keep_logfiles = 1
g.ycm_autoclose_preview_window_after_insertion = 1
g.ycm_autoclose_preview_window_after_completion = 1
g.ycm_add_preview_to_completeopt = 0

-- GitGutter
g.gitgutter_enabled = 0
g.gitgutter_highlight_lines = 1
g.gitgutter_map_keys = 0

-- Vundle default git protocol
g.vundle_default_git_proto = "https"

-- Highlight groups
g.no_highlight_group_for_current_word = { "Statement", "Comment", "Type", "PreProc" }

-- Cursor shape (for terminals)
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}
