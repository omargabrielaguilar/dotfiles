-- ================================================================================================
-- TITLE : oil.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/stevearc/oil.lua
-- ================================================================================================

return 
{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true, -- reemplaza netrw
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 80,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },
  lazy = false,
  config = function(_, opts)
    local oil = require("oil")
    oil.setup(opts)
  end,
}

