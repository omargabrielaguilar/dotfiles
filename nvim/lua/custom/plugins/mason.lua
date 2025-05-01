return {
  "williamboman/mason.nvim",
  enabled = require("nixCatsUtils").lazyAdd(true, false),
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
  },
  config = function()
    if not require("nixCatsUtils").isNixCats then
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = {}
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        "blade-formatter", -- Used to format Blade code
        "goimports",
        "php-debug-adapter",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pylsp",
          "phpactor",
          "gopls",
          "rnix",
          "nil_ls",
        },
      })
    end
  end,
}
