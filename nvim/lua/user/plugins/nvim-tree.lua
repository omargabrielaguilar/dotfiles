require("nvim-tree").setup({
	view = {
		width = 40, -- Hace el panel más ancho
		side = "right",
	},
	git = {
		ignore = false,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				folder_arrow = false,
			},
		},
		indent_markers = {
			enable = true,
		},
	},
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true, -- Ajusta el tamaño del panel automáticamente
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

-- Atajo de teclado para abrir/cerrar NvimTree
vim.keymap.set("n", "<Leader>n", ":NvimTreeFindFileToggle<CR>")

-- Mejora la visibilidad del indent marker y de los iconos
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#51576D" }) -- Color sutil
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#89B4FA" }) -- Azul vibrante
