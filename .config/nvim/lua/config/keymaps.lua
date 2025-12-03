-- Key mappings
-- Converted from .vimrc

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Don't use Ex mode, use Q for formatting
map("n", "Q", "gq", opts)

-- Add line break below without entering insert mode
map("n", "<CR>", "i<CR><Esc>", opts)

-- Console-dependent mapping (Shift+Enter)
map("n", "<M-O>M", "o<Esc>", opts)

-- Leader key mappings
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>Q", ":q!<CR>", opts)
map("n", "<leader>x", ":x<CR>", opts)
map("n", "<leader>X", ":x!<CR>", opts)
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>W", ":w!<CR>", opts)
map("n", "<leader>n", ":nohl<CR>", opts)

-- Formatter
map("n", "<C-f>", ":lua CallFormatter()<CR>", opts)

-- NERDTree (or file explorer)
map("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

-- Git blame
map("n", "<leader>b", ":Git blame<CR>", opts)

-- GitGutter toggle
map("n", "<leader>g", ":GitGutterToggle<CR>", opts)

-- Make commands
map("n", "<leader>1", ":make<CR>:cw<CR>", opts)
map("n", "<leader>2", ":cp<CR>", opts)
map("n", "<leader>3", ":cn<CR>", opts)
map("n", "<leader>4", ":cl<CR>", opts)

-- Deactivate man search
map("n", "<S-K>", "<Nop>", opts)

-- CTRL-U in insert mode with undo break
map("i", "<C-U>", "<C-G>u<C-U>", opts)
