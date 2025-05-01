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
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
}
