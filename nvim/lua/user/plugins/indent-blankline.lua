require("ibl").setup {
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "dashboard",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftypes = {
      "terminal",
      "NvimTree",
    },
  },
  indent = {
    char = "│",
  },
  scope = {
    enabled = true,
    show_start = true,
  },
}

