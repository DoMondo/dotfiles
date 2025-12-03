-- LaTeX-specific keymaps and autocommands
-- Converted from .vimrc

local functions = require("config.functions")
local map = vim.keymap.set

-- Create augroup for LaTeX
local latex_group = vim.api.nvim_create_augroup("LaTeXMappings", { clear = true })

-- LaTeX-specific keymaps (buffer-local)
vim.api.nvim_create_autocmd("FileType", {
  group = latex_group,
  pattern = "tex",
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }
    
    -- Insert LaTeX list
    map("n", "<leader>l", function()
      functions.insert_latex_list()
    end, opts)
    
    -- Insert LaTeX frame
    map("n", "<leader>s", function()
      functions.insert_latex_frame()
    end, opts)
    
    -- Insert LaTeX columns
    map("n", "<leader>C", function()
      functions.insert_latex_columns()
    end, opts)
    
    -- Smart item insertion
    map("n", "o", function()
      functions.smart_item_insert(true)
    end, opts)
    
    map("n", "O", function()
      functions.smart_item_insert(false)
    end, opts)
    
    -- Toggle bold
    map("n", "<leader>bb", function()
      functions.toggle_tex_style("textbf")
    end, opts)
    
    map("x", "<leader>bb", function()
      functions.toggle_tex_style_visual("textbf")
    end, opts)
    
    -- Toggle italic
    map("n", "<leader>i", function()
      functions.toggle_tex_style("textit")
    end, opts)
    
    map("x", "<leader>i", function()
      functions.toggle_tex_style_visual("textit")
    end, opts)
    
    -- Toggle typewriter
    map("n", "<leader>t", function()
      functions.toggle_tex_style("texttt")
    end, opts)
    
    map("x", "<leader>t", function()
      functions.toggle_tex_style_visual("texttt")
    end, opts)
  end,
})
