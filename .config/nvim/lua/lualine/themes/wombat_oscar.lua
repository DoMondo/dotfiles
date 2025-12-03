-- Lualine theme based on minimalist_domondo airline theme
-- Converted to match the exact colors from airline

local colors = {
  -- Colors from minimalist_domondo airline theme
  fg = '#E4E4E4',        -- 254
  bg = '#262626',        -- 235
  bg_alt = '#3A3A3A',    -- 237
  bg_mid = '#4E4E4E',    -- 239
  fg_bright = '#EEEEEE', -- 255
  inactive = '#666666',  -- 242
  
  -- Accent colors
  modified = '#75765D',
  insert_accent = '#005e5e',
  warning = '#FFAF5F',   -- 215
  error = '#D75F5F',     -- 167
}

return {
  normal = {
    a = { fg = colors.fg, bg = colors.bg_alt, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.fg_bright, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.fg, bg = colors.bg_alt, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.fg_bright, bg = colors.bg },
  },
  visual = {
    a = { fg = colors.fg, bg = colors.bg_alt, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.fg_bright, bg = colors.bg },
  },
  replace = {
    a = { fg = colors.fg, bg = colors.bg_alt, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.fg_bright, bg = colors.bg },
  },
  command = {
    a = { fg = colors.fg, bg = colors.bg_alt, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.fg_bright, bg = colors.bg },
  },
  inactive = {
    a = { fg = colors.inactive, bg = colors.bg },
    b = { fg = colors.inactive, bg = colors.bg },
    c = { fg = colors.inactive, bg = colors.bg },
  },
}
