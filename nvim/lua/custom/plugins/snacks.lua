return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<c-\\>",
      function()
        require("snacks").terminal()
      end,
      desc = "Toggle a terminal",
      mode = { "n", "t" },
    },

    {
      "<leader>z",
      function()
        require("snacks").zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        require("snacks").zen.zoom()
      end,
      desc = "Toggle Zoom",
    },

    {
      "<leader>.",
      function()
        require("snacks").scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        require("snacks").scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },

    {
      "<leader>n",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>bd",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        require("snacks").rename.rename_file()
      end,
      desc = "Rename File",
    },

    {
      "<leader>gB",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gb",
      function()
        require("snacks").git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gf",
      function()
        require("snacks").lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        require("snacks").lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>N",
      function()
        require("snacks").notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    -- { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
    -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
    {
      "<leader>fd",
      function()
        require("snacks").picker.treesitter()
      end,
      desc = "Treesitter elements",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Buffers Picker",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep Picker",
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Picker",
    },
    {
      "<leader>fs",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Git Status Picker",
    },
    {
      "<leader>:",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command history picker",
    },
    {
      "<leader>fi",
      function()
        require("snacks").picker.icons()
      end,
      desc = "Icons Picker",
    },
    {
      "<F6>",
      function()
        require("snacks").explorer()
      end,
      desc = "File Explorer",
    },
  },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = require("custom.dashboard"),
    indent = { enabled = true },
    input = { enabled = true },
    image = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")

        vim.keymap.set("n", "<leader>ff", function()
          require("snacks").picker.smart({ multi = { "buffers", "files" } })
        end, { desc = "Find files" })
      end,
    })
  end,
}
