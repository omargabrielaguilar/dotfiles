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
		require("nvim-treesitter.config").setup({
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
			},

			auto_install = true,
			sync_install = false,

			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
