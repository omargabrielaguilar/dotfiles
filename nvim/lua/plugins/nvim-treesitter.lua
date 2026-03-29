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
	config = function()
		-- ✅ API nueva: registrar parser externo ANTES del setup
		require("nvim-treesitter.parsers").blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				branch = "main",
			},
			filetype = "blade",
		}

		require("nvim-treesitter.config").setup {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"json",
				"yaml",
				"html",
				"css",
				"javascript",
				"typescript",
				"sql",
				"dockerfile",
				"php",
				"markdown",
				"markdown_inline",
				"blade", -- ← agregar aquí también
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = { "blade" } },
			indent = { enable = true },
		}
	end,
}
