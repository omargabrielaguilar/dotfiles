require("nvim-treesitter.configs").setup({
	ensure_installed = { "php", "blade", "lua", "html", "css", "javascript", "json", "bash", "yaml", "markdown" }, -- Lenguajes específicos
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
	},
})

-- Configuración nueva para context_commentstring
require("ts_context_commentstring").setup({})
