return {
	-- Adding a filename to the Top Right
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- o "tabs"
					indicator = {
						style = "underline", -- sutil
					},
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "thick", -- puedes probar: "thick", "thin", "slant"
					modified_icon = "●",
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					always_show_bufferline = true,
					highlights = {
						buffer_selected = {
							italic = false,
							bold = true, -- opcional, si quieres resaltar un poco más
						},
						diagnostic_selected = {
							italic = false,
						},
						-- Puedes agregar más si ves que algún otro queda en italic
					},
				},
			})

			-- Keymaps para cambiar entre buffers como tabs
			vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<C-w>", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
			vim.keymap.set("n", "<C-k>w", function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
						vim.cmd("bdelete " .. buf)
					end
				end
			end, { desc = "Close all buffers" })
			vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
		end,
	},
}
