-- ================================================================================================
-- TITLE : GitHub Copilot
-- ABOUT : AI pair programmer that suggests code completions inline.
-- LINKS :
--   > github : https://github.com/zbirenbaum/copilot.lua
--   > cmp integration : https://github.com/zbirenbaum/copilot-cmp
-- ================================================================================================

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false, -- Desactivamos sugerencias inline (usaremos cmp)
          auto_trigger = false, -- Evita que se dispare a cada rato
        },
        panel = { enabled = false }, -- Sin panel flotante
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

