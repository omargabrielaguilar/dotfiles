return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  enabled = require("nixCatsUtils").enableForCategory("ai"),
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {},
  opts = vim.tbl_extend("force", {
    provider = "copilot",
    file_selector = {
      provider = "snacks",
    },
    behaviour = {
      enable_claude_text_editor_tool_mode = true,
    },
    custom_tools = {
      {
        name = "run_behat_test", -- Unique name for the tool
        description = "Run behat tests and return results", -- Description shown to AI
        command = "make exec-behat", -- Shell command to execute
        param = { -- Input parameters (optional)
          type = "table",
          fields = {
            {
              name = "target",
              description = "path to the feature test file for specific test add the :<line> of the test",
              type = "string",
              optional = false,
            },
          },
        },
        returns = { -- Expected return values
          {
            name = "result",
            description = "Result of the test",
            type = "string",
          },
          {
            name = "error",
            description = "Error message if the test was not successful",
            type = "string",
            optional = true,
          },
        },
        func = function(params, on_log, on_complete) -- Custom function to execute
          local target = params.target
          return vim.fn.system(string.format("make exec-behat test=%s", target))
        end,
      },
    },
    -- copilot = {
    --   model = "claude-3.7-sonnet",
    --   temperature = 0,
    --   max_tokens = 8192,
    -- },
  }, require("nixCatsUtils").getCatOrDefault("avanteOpts", {}) or {}),
  config = function(_, o)
    require("avante").setup(o)
    require("custom.avante-recipes")
  end,
}
