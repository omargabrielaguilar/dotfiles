return {
  -- Override LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        intelephense = {
          init_options = {
            licenceKey = "00D0IEADQVBNA0K",
          },
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000,
              },
            },
          },
        },
      },
    },
  },
}
