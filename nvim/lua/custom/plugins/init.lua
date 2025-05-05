return {
  "tpope/vim-surround",
  "tpope/vim-dispatch",
  "tpope/vim-repeat",
  -- Lazy
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {},
    lazy = false,
    priority = 100,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    opts = {
      style = "darker", -- puedes cambiar a 'warmer', 'cool', etc.
    },
    lazy = false,
    priority = 100,
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },
 {
   "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({
      -- Your config here
    })
  end,
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
      user_default_options = {
        names = false,
      },
    },
  },
  {
    "direnv/direnv.vim",
    init = function()
      vim.g.direnv_silent_load = 1
    end,
  },
  "echasnovski/mini.ai",
  "adalessa/php-lsp-utils",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  -- bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{}
    end
  },

  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
}
