-- Plugin specifications
-- Converted from Vundle to lazy.nvim

return {
  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Glog", "Gblame" },
  },

  -- Code formatting
  {
    "rhysd/vim-clang-format",
    ft = { "c", "cpp", "objc" },
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>cc",
          block = "<leader>bc",
        },
        opleader = {
          line = "<leader>c",
          block = "<leader>b",
        },
      })
    end,
  },

  -- Status line (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "wombat_oscar",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = { { "filename", path = 2 } },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- File explorer (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
      })
    end,
  },

  -- Color scheme (custom wombat_oscar)
  -- Loaded from colors/wombat_oscar.vim


  -- Language support
  { "petRUShka/vim-opencl", ft = "opencl" },
  { "keith/swift.vim", ft = "swift" },
  { "tikhomirov/vim-glsl", ft = "glsl" },
  { "matze/vim-meson", ft = "meson" },
  { "peterhoeg/vim-qml", ft = "qml" },
  { "theRealCarneiro/hyprland-vim-syntax", ft = "hypr" },

  -- Utilities
  { "kopischke/vim-fetch" },
  { "fidian/hexmode", cmd = "Hexmode" },

  -- Wayland clipboard support

  {
    "let-def/texpresso.vim"
  }
}
