return {
  "uloco/bluloco.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "rktjmp/lush.nvim" },
  config = function()
    vim.opt.termguicolors = true

    require("bluloco").setup({
      style = "dark",
      transparent = true,
      italics = true,
      terminal = vim.fn.has("gui_running") == 1,
      guicursor = true,
      rainbow_headings = false,
      float_window = "transparent",
    })

    vim.cmd.colorscheme("bluloco")

    -- 🔎 Fuerza transparencia (anti plugins que pisan bg)
    local transparent_groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "SignColumn",
      "LineNr",
      "CursorLineNr",
      "MsgArea",
      "StatusLine",
      "StatusLineNC",

      -- Telescope
      "TelescopeNormal",
      "TelescopeBorder",

      -- Oil / Tree / Explorer
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "OilFloat",

      -- Popup menus
      "Pmenu",
      "PmenuSel",
      "PmenuThumb",
      "PmenuSbar",
    }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
}

