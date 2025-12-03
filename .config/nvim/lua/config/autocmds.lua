-- Autocommands
-- Converted from .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General autocommands group
local general = augroup("General", { clear = true })

-- Jump to last known cursor position
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- File type specific settings
local filetype_settings = augroup("FileTypeSettings", { clear = true })

-- Text files
autocmd("FileType", {
  group = filetype_settings,
  pattern = "text",
  callback = function()
    vim.opt_local.textwidth = 78
  end,
})

-- LaTeX files
autocmd("FileType", {
  group = filetype_settings,
  pattern = "tex",
  callback = function()
    if vim.fn.expand("%:e") ~= "sty" then
      vim.opt_local.textwidth = 78
      vim.opt_local.spell = true
      vim.opt_local.spelllang = "es"
    end
  end,
})

-- LaTeX syntax sync
autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_settings,
  pattern = "*.tex",
  command = "syntax sync fromstart",
})

-- DokuWiki
autocmd("FileType", {
  group = filetype_settings,
  pattern = "dokuwiki",
  callback = function()
    vim.opt_local.textwidth = 83
  end,
})

-- YAML
autocmd("FileType", {
  group = filetype_settings,
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Python
autocmd("FileType", {
  group = filetype_settings,
  pattern = "python",
  callback = function()
    vim.opt_local.omnifunc = "python3complete#Complete"
    vim.opt_local.equalprg = "autopep8 -"
  end,
})

-- Strace files
autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_settings,
  pattern = "*.strace",
  command = "set filetype=strace",
})
