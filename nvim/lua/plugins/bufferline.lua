return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- opcional si ya usas mini.icons
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- o "tabs"
				numbers = "none",
				themable = true,
				separator_style = "thin", -- "thin" | "thick" | "slant" | "padded_slant"
				show_close_icon = false,
				show_buffer_close_icons = false,
				always_show_bufferline = true,
				diagnostics = "nvim_lsp", -- si quieres ver los errores por buffer
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,

				offsets = {
					{
						filetype = "oil",
						text = "",
						highlight = "Directory",
						separator = false,
					},
				},
			},
		})

		-- Keymaps fresh
		vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader>x", "<Cmd>bd<CR>", { silent = true }) -- cerrar buffer rápido
	end,
}
