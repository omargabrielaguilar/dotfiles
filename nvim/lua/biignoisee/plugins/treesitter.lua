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
					"yaml",
					"php",
					"http",
					"bash",
					"toml",
					"phpdoc",
					"lua",
					"dockerfile",
					"gitignore",
					"groovy",
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
			"java",
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
					["php"] = {
						enable_close = true,
					},
					["java"] = {
						enable_close = true,
					},
					["xml"] = {
						enable_close = true, -- ⬅️ Para archivos XML en Java
					},
				},
			})
		end,
	},
}
