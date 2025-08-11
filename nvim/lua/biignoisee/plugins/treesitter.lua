return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				highlight = { enable = true },
				indent = { enable = true },
				fold = { enable = true },
				ensure_installed = {
					"json",
					"yaml",
					"php",
					"http",
					"bash",
					"toml",
					"phpdoc",
					"lua",
					"dockerfile",
					"gitignore",
					"xml",
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

	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "php", "blade" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["php"] = { enable_close = true },
					["xml"] = { enable_close = true },
				},
			})
		end,
	},
}
