-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Treesitter configurations and abstraction layer for Neovim.
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Lenguajes que quieres tener sí o sí
			ensure_installed = {
				-- Core stack
				"javascript",
				"typescript",
				"tsx", -- JSX / React / Next.js
				"json",
				"html",
				"css",

				-- Backend / Infra
				"sql",
				"dockerfile",

				-- Utilidades varias
				"lua", -- para Neovim config
				"markdown",
				"markdown_inline",
				"yaml",
				"php",
			},

			-- auto instala parser cuando abras un nuevo lenguaje
			auto_install = true,
			sync_install = false,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
		})
	end,
}
