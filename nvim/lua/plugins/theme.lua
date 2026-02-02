return {
  "shaunsingh/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = true
    vim.g.nord_uniform_diff_background = true

    vim.cmd.colorscheme("nord")

    -- 🔎 Fuerza transparencia (anti plugins)
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

      -- Trees
      "NvimTreeNormal",
      "NvimTreeNormalNC",

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

