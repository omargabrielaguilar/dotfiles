return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    -- Configuración de bufferline
    require("bufferline").setup({
      options = {
        mode = "buffers", -- o "tabs"
        diagnostics = "nvim_lsp", -- Muestra los diagnósticos LSP
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return icon .. count
        end,
        separator_style = "thick", -- "slant" | "thick" | "thin"
        show_buffer_close_icons = true, -- Mostrar el icono de cerrar en los buffers
        show_close_icon = true, -- Icono de cerrar en la parte de la derecha
        always_show_bufferline = true,
        show_buffer_icons = true, -- Mostrar iconos en los buffers
        enforce_regular_tabs = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    })

    -- Keymaps para navegación entre buffers
    vim.opt.mousemoveevent = true -- Mejora compatibilidad en splits

    -- Saltar a buffer por número (Alt + número)
    for i = 1, 9 do
      vim.keymap.set(
        "n",
        "<A-" .. i .. ">",
        "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>",
        { desc = "Go to buffer " .. i }
      )
    end

    -- Mover buffers
    vim.keymap.set("n", "<A-,>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
    vim.keymap.set("n", "<A-.>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

    -- Cerrar buffer actual
    vim.keymap.set("n", "<A-w>", "<Cmd>bd<CR>", { desc = "Close current buffer" })

    -- Navegación entre ventanas
    vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
    vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
  end,
}

