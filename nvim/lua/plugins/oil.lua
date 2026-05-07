-- ==========================================
-- OIL.NVIM CONFIG
-- ==========================================
require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	view_options = {
		show_hidden = false, -- Cambia a true si quieres ver archivos ocultos (.env, .gitignore)
		is_always_hidden = function(name, bufnr)
			return name == ".."
		end,
	},
	-- Opcional: Para mantener la estética transparente si usas un colorscheme transparente
	win_options = {
		winblend = 0,
	},
})

-- Atajo clásico de Oil (Abre la carpeta del archivo actual)
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })