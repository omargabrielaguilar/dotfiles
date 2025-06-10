return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- ensure these languages parsers are installed
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
					"blade", -- para Blade templates de Laravel
					"toml", -- por si usas tools modernas (como Deno, cargo, etc.)
					"phpdoc", -- para documentación PHP
					"lua",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"elixir",
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
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"xml",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"elixir",
			"php", -- para Laravel / Blade
			"blade", -- Blade syntax
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
						enable_close = false, -- set false si ves problemas
					},
				},
			})
		end,
	},
}
