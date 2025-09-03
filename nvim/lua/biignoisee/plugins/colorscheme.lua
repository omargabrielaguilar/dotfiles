return {
	-- NOTE: Everforest
	{
		"sainnhe/everforest",
		config = function()
			vim.g.everforest_background = "soft" -- 'hard', 'medium', 'soft'
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
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {
					Pmenu = { bg = "" }, -- Completion menu background
				},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},

	-- NOTE: onedark
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

	-- NOTE: Jellybeans
	{
		"nanotech/jellybeans.vim",
		config = function()
			-- termguicolors para soporte full
			vim.opt.termguicolors = true

			-- overrides: fondo transparente
			vim.g.jellybeans_overrides = {
				background = { guibg = "none", ctermbg = "none" },
				Pmenu = { guibg = "none" },
				NormalFloat = { guibg = "none" },
				SignColumn = { guibg = "none" },
				LineNr = { guibg = "none" },
				EndOfBuffer = { guibg = "none" },
				TelescopeNormal = { guibg = "none" },
				TelescopeBorder = { guibg = "none" },
			}

			-- aplica esquema
			vim.cmd("colorscheme jellybeans")
		end,
	},

	-- NOTE: Sonokai
	{
		"sainnhe/sonokai",
		config = function()
			vim.opt.termguicolors = true

			-- estilo de Sonokai: default / atlantis / andromeda / shusia / maia / espresso
			vim.g.sonokai_style = "andromeda"

			-- transparencia + opciones recomendadas
			vim.g.sonokai_transparent_background = 1
			vim.g.sonokai_better_performance = 1

			-- aplica esquema
			vim.cmd("colorscheme sonokai")

			-- overrides manuales para asegurar transparencia (como jellybeans)
			local groups = {
				"Normal",
				"NormalFloat",
				"SignColumn",
				"LineNr",
				"EndOfBuffer",
				"Pmenu",
				"FloatBorder",
				"TelescopeNormal",
				"TelescopeBorder",
			}
			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, { bg = "none" })
			end
		end,
	},
}
