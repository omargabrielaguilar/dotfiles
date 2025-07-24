return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"php",
					"http",
					"markdown",
					"markdown_inline",
					"graphql",
					"bash",
					"blade",
					"toml",
					"phpdoc",
					"lua",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"elixir",
					"java", -- ⬅️ AÑADIDO
					"xml", -- opcional si usas XML en Java EE
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},

	-- Autotag para HTML/XML/PHP/etc
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"xml", -- ⬅️ Ya soportado por autotag
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"elixir",
			"php",
			"blade",
		},
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
					["typescriptreact"] = {
						enable_close = true,
					},
					["php"] = {
						enable_close = true,
					},
					["blade"] = {
						enable_close = true,
					},
					["elixir"] = {
						enable_close = false,
					},
					["xml"] = {
						enable_close = true, -- ⬅️ Para archivos XML en Java
					},
				},
			})
		end,
	},
}
