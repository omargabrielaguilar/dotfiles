return {
	-- NOTE: Everforest
	{
		"sainnhe/everforest",
		config = function()
			vim.g.everforest_background = "hard" -- 'hard', 'medium', 'soft'
			vim.g.everforest_enable_italic = 0
			vim.g.everforest_transparent_background = 1
			vim.cmd("colorscheme everforest")
		end,
	},

	-- NOTE: Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		-- priority = 1000 ,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					folds = false,
					operators = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					Pmenu = { bg = "" }, -- Completion menu background
				},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},

	-- NOTE: x
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warm", -- opciones: dark, darker, cool, deep, warm, warmer, light
				transparent = true, -- activa fondo transparente
				term_colors = true, -- aplica en la terminal integrada
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},
				lualine = { transparent = true }, -- barra de estado transparente
				diagnostics = {
					darker = true,
					undercurl = true,
					background = false,
				},
				colors = {}, -- si quieres sobreescribir la paleta
				highlights = {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					Pmenu = { bg = "none" },
					SignColumn = { bg = "none" },
					LineNr = { bg = "none" },
					EndOfBuffer = { bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopeBorder = { bg = "none" },
					LazyNormal = { bg = "none" },
					MasonNormal = { bg = "none" },
				},
			})

			require("onedark").load()
		end,
	},

	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		config = function()
			require("dracula").setup({
				transparent_bg = true,
				italic_comment = true,
				show_end_of_buffer = true,
				overrides = {
					Normal = { bg = "none" },
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					Pmenu = { bg = "none" },
					PmenuSel = { bg = "#44475a" }, -- selección visible
					SignColumn = { bg = "none" },
					LineNr = { bg = "none" },
					CursorLineNr = { bg = "none" },
					EndOfBuffer = { bg = "none" },

					-- 🚀 Fix para Telescope
					TelescopeNormal = { bg = "none" },
					TelescopeBorder = { fg = "#6272a4", bg = "none" },

					TelescopePromptNormal = { bg = "#1e1f29" }, -- contraste oscuro
					TelescopePromptBorder = { fg = "#6272a4", bg = "#1e1f29" },
					TelescopePromptTitle = { fg = "#f8f8f2", bg = "#bd93f9", bold = true },

					TelescopeResultsNormal = { bg = "#282a36" },
					TelescopeResultsBorder = { fg = "#6272a4", bg = "#282a36" },
					TelescopeResultsTitle = { fg = "#f8f8f2", bg = "#44475a", bold = true },

					TelescopePreviewNormal = { bg = "#1e1f29" },
					TelescopePreviewBorder = { fg = "#6272a4", bg = "#1e1f29" },
					TelescopePreviewTitle = { fg = "#f8f8f2", bg = "#50fa7b", bold = true },

					-- Otros plugins
					LazyNormal = { bg = "none" },
					MasonNormal = { bg = "none" },
					WhichKeyFloat = { bg = "none" },
				},
				diagnostics = {
					darker = true,
					undercurl = true,
					background = false,
				},
			})

			vim.cmd("colorscheme dracula")
		end,
	},
}
