return {
  "oxfist/night-owl.nvim",
  lazy = false,         -- carga inmediatamente
  priority = 1000,      -- asegúrate que sea el primero
  config = function()
    require("night-owl").setup()
    vim.cmd.colorscheme("night-owl")
  end,
}

