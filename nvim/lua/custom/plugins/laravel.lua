local dir_path = vim.fn.expand("~/code/plugins/laravel.nvim")
local dir_exists = vim.fn.isdirectory(dir_path) == 1

return {
  "adalessa/laravel.nvim",
  branch = "4.x",
  enabled = require("nixCatsUtils").enableForCategory("laravel"),
  dir = dir_exists and dir_path or nil,
  dependencies = {
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>ll", "<cmd>Laravel<cr>" },
    { "<c-g>", "<cmd>Laravel view_finder<cr>" },
    { "<leader>la", "<cmd>Laravel art<cr>" },
    { "<leader>lt", "<cmd>Laravel actions<cr>" },
    { "<leader>lr", "<cmd>Laravel routes<cr>" },
    { "<leader>lh", "<cmd>Laravel art docs<cr>" },
    { "<leader>lm", "<cmd>Laravel make<cr>" },
    { "<leader>ln", "<cmd>Laravel related<cr>" },
    { "<leader>lc", "<cmd>Laravel commands<cr>" },
    { "<leader>lo", "<cmd>Laravel resources<cr>" },
    { "<leader>lp", "<cmd>Laravel panel<cr>" },
    {
      "gf",
      function()
        if require("laravel").app("gf").cursor_on_resource() then
          return "<cmd>Laravel gf<cr>"
        else
          return "gf"
        end
      end,
      expr = true,
      noremap = true,
    },
  },
  event = { "VeryLazy" },
  opts = {
    lsp_server = "phpactor",
    features = {
      pickers = {
        provider = "snacks",
      },
    },
    user_commands = {
      composer = {
        quality = {
          cmd = { "quality" },
          desc = "Runs the quality script in composer.json",
        },
      },
    },
  },
}
