-- Custom functions
-- Converted from .vimrc

local M = {}

-- Formatter function
function CallFormatter()
  local ft = vim.bo.filetype
  local line_number = vim.fn.line(".")
  
  if ft == "python" then
    vim.cmd("0,$!yapf --style=\"$HOME/.config/yapf/.style.yapf\"")
    vim.cmd("normal! gg")
    vim.cmd("normal! " .. line_number .. "gg")
  elseif ft == "tex" then
    vim.cmd("normal! gg=G")
    vim.cmd("normal! " .. line_number .. "gg")
  else
    vim.cmd("ClangFormat")
  end
  
  vim.cmd("normal! zz")
end

-- Make function globally available
_G.CallFormatter = CallFormatter

-- LaTeX helper functions

-- Insert LaTeX list
function M.insert_latex_list()
  local line = vim.fn.getline(".")
  local indent = line:match("^%s*") or ""
  local lines = {
    indent .. "\\begin{itemize}",
    indent .. "   \\item ",
    indent .. "\\end{itemize}"
  }
  vim.fn.append(vim.fn.line("."), lines)
  vim.cmd("normal! 2j")
  vim.cmd("startinsert!")
end

-- Insert LaTeX frame
function M.insert_latex_frame()
  local line = vim.fn.getline(".")
  local indent = line:match("^%s*") or ""
  local lines = {
    indent .. "\\begin{frame}[s]{}",
    indent .. "\\end{frame}"
  }
  vim.fn.append(vim.fn.line("."), lines)
  vim.cmd("call cursor(line('.') + 1, 4)")
  vim.cmd("normal! f}f}")
  vim.cmd("startinsert")
end

-- Insert LaTeX columns
function M.insert_latex_columns()
  local line = vim.fn.getline(".")
  local indent = line:match("^%s*") or ""
  local lines = {
    indent .. "\\stretchytwocols{",
    indent .. "}{",
    indent .. "}"
  }
  vim.fn.append(vim.fn.line("."), lines)
  vim.cmd("normal! 2j")
  vim.cmd("startinsert!")
end

-- Smart item insertion
function M.smart_item_insert(open_below)
  local current_line = vim.fn.line(".")
  local begin_count = 0
  local end_count = 0
  
  -- Count begin/end occurrences
  for i = 1, current_line do
    local line_text = vim.fn.getline(i)
    if line_text:match("\\begin{itemize}") or line_text:match("\\begin{enumerate}") then
      begin_count = begin_count + 1
    end
    if line_text:match("\\end{itemize}") or line_text:match("\\end{enumerate}") then
      end_count = end_count + 1
    end
  end
  
  local in_list = begin_count > end_count
  local indent = ""
  
  if in_list then
    -- Search backwards for previous \item line
    local item_line = vim.fn.search("^\\s*\\\\item", "bnW")
    if item_line > 0 then
      indent = vim.fn.getline(item_line):match("^%s*") or ""
    else
      indent = vim.fn.getline("."):match("^%s*") or ""
    end
  else
    indent = vim.fn.getline("."):match("^%s*") or ""
  end
  
  local new_line = in_list and (indent .. "\\item ") or indent
  
  if open_below then
    vim.fn.append(vim.fn.line("."), new_line)
    vim.cmd("normal! j")
  else
    vim.fn.append(vim.fn.line(".") - 1, new_line)
    vim.cmd("normal! k")
  end
  
  vim.cmd("startinsert!")
end

-- Toggle LaTeX style (normal mode)
function M.toggle_tex_style(style)
  local word = vim.fn.expand("<cword>")
  local line = vim.fn.getline(".")
  local pattern = "\\" .. style .. "{" .. word .. "}"
  
  if line:find(vim.pesc(pattern), 1, true) then
    -- Remove wrapper
    vim.cmd("silent! s/" .. vim.pesc(pattern) .. "/" .. word .. "/")
  else
    -- Add wrapper
    vim.cmd("silent! normal! ciw\\" .. style .. "{" .. word .. "}")
  end
end

-- Toggle LaTeX style (visual mode)
function M.toggle_tex_style_visual(style)
  -- Yank the visual selection
  vim.cmd('noau normal! "vy')
  local sel = vim.fn.getreg('v')
  
  -- Check if already wrapped
  local unwrapped = sel:match("^\\" .. style .. "{(.*)}$")
  
  local replacement
  if unwrapped then
    -- Remove wrapper
    replacement = unwrapped
  else
    -- Add wrapper
    replacement = "\\" .. style .. "{" .. sel .. "}"
  end
  
  -- Replace the selection
  vim.fn.setreg('v', replacement)
  vim.cmd('noau normal! gv"vp')
end

-- Highlight word under cursor (optional, commented out in original)
function M.highlight_word_under_cursor()
  local word = vim.fn.expand("<cword>")
  local col = vim.fn.stridx(vim.fn.getline("."), word) + 1
  local syntaxgroup = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(vim.fn.line("."), col, 1)), "name")
  
  local no_highlight = vim.g.no_highlight_group_for_current_word or {}
  local should_highlight = true
  
  for _, group in ipairs(no_highlight) do
    if group == syntaxgroup then
      should_highlight = false
      break
    end
  end
  
  if should_highlight then
    vim.cmd(string.format("match Occurrence /\\V\\<%s\\>/", vim.fn.escape(word, "/\\")))
  else
    vim.cmd("match Occurrence /\\V\\<\\>/")
  end
end

return M
