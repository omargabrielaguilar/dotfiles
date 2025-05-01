return {
  {
    "zbirenbaum/copilot.lua",
    enabled = require("nixCatsUtils").enableForCategory("ai"),
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = require("nixCatsUtils").enableForCategory("ai"),
    dependencies = { "zbirenbaum/copilot.lua" },
  },
}
