return {
	-- NOTE: Rose pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				-- disable_background = true,
				-- 	disable_nc_background = false,
				-- 	disable_float_background = false,
				-- extend_background_behind_borders = false,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" }, -- Main background remains transparent
					Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
					PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
					PmenuSbar = { bg = "#191724" }, -- Scrollbar background
					PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
				},
				enable = {
					terminal = false,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
			})

			-- HACK: set this on the color you want to be persistent
			-- when quit and reopening nvim
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		config = function()
			require("ayu").setup({
				mirage = false, -- false = dark, true = light-ish mirage
				overrides = {
					Normal = { bg = "none" },
					ColorColumn = { bg = "#1C1C21" },
					Pmenu = { bg = "#0F1419", fg = "#e0def4" },
					PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" },
					PmenuSbar = { bg = "#0F1419" },
					PmenuThumb = { bg = "#E6B450" },
				},
			})

			-- set colorscheme
			vim.cmd("colorscheme ayu-dark")
		end,
	},
	{
		"oxfist/night-owl.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("night-owl").setup({
				bold = true,
				italics = true,
				underline = true,
				undercurl = true,
				transparent_background = true,
			})
		end,
	},
	{
		"sainnhe/everforest",
		name = "everforest",
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard" -- 'soft', 'medium', 'hard'
			vim.g.everforest_enable_italic = 0
			vim.g.everforest_enable_bold = 1
			vim.g.everforest_transparent_background = 2 -- 1: bg transparente, 2: total transparency

			vim.cmd("colorscheme everforest")

			-- Custom highlight overrides (opcional, igual que tu rose-pine)
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3b444d" }) -- columna guía
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", fg = "#d3c6aa" })
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5c6a72", fg = "#fdf6e3" })
			vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#374145" })
			vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#a7c080" })
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		lazy = false, -- o true si prefieres cargarlo bajo demanda
		priority = 1000, -- asegúrate de que se cargue antes que otros temas
		config = function()
			require("cyberdream").setup({
				transparent = true, -- fondo transparente
				italic_comments = false,
				hide_fillchars = true,
				borderless_telescope = true,
				terminal_colors = true,
				theme = {
					highlights = {
						ColorColumn = { bg = "#1C1C21" },
						Normal = { bg = "none" },
						Pmenu = { bg = "none", fg = "#e0def4" },
						PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" },
						PmenuSbar = { bg = "#2a273f" },
						PmenuThumb = { bg = "#9ccfd8" },
					},
				},
			})

			-- HACK: activar el colorscheme al iniciar
			-- vim.cmd("colorscheme cyberdream")
		end,
	},
	-- NOTE: gruvbox
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		config = function()
			require("onedark").setup({
				style = "darker", -- opciones: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
				transparent = true, -- fondo transparente
				term_colors = true,
				ending_tildes = false,
				cmp_itemkind_reverse = false,

				code_style = {
					comments = "none",
					keywords = "bold",
					functions = "bold",
					strings = "none",
					variables = "none",
				},

				highlights = {
					ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" },
					Pmenu = { bg = "none", fg = "#abb2bf" },
					PmenuSel = { bg = "#3E4452", fg = "#ffffff" },
					PmenuSbar = { bg = "#2c313a" },
					PmenuThumb = { bg = "#528bff" },
				},

				diagnostics = {
					darker = true,
					undercurl = true,
					background = false,
				},
			})

			-- HACK: set this on the color you want to be persistent
			-- cuando cambies de rose-pine a onedark
			-- vim.cmd("colorscheme onedark")
		end,
	},

	-- NOTE: gruvbox
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
	-- NOTE: Kanagwa
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none",
								border = "rounded",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						Pmenu = { fg = theme.ui.shade0, bg = "NONE", blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						TelescopeTitle = { fg = theme.ui.special, bold = true },
						TelescopePromptBorder = { fg = theme.ui.special },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim },
						TelescopeResultsBorder = { fg = theme.ui.special },
						TelescopePreviewBorder = { fg = theme.ui.special },
					}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
				},
			})
		end,
	},
	-- NOTE: neosolarized
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = c.bg_dark,
					}
					hl.TelescopePromptBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = "#2C94DD",
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
		end,
	},
	-- NOTE : tokyonight
	{
		"folke/tokyonight.nvim",
		name = "folkeTokyonight",
		-- priority = 1000,
		config = function()
			local transparent = true
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,

				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = transparent and colors.none or bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
			-- vim.cmd("colorscheme tokyonight")
			-- NOTE: Auto switch to tokyonight for markdown files only
			-- vim.api.nvim_create_autocmd("FileType", {
			--     pattern = { "markdown" },
			--     callback = function()
			--         -- Ensure the theme switch only happens once for a buffer
			--         local buffer = vim.api.nvim_get_current_buf()
			--         if not vim.b[buffer].tokyonight_applied then
			--             if vim.fn.expand("%:t") ~= "" and vim.api.nvim_buf_get_option(0, "buftype") ~= "nofile" then
			--                 vim.cmd("colorscheme tokyonight")
			--             end
			--             vim.b[buffer].tokyonight_applied = true
			--         end
			--     end,
			-- })
		end,
	},
}
