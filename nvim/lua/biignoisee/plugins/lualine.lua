return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Gruvbox Dark Hard colors
		local colors = {
			bg = "#1d2021", -- fondo más oscuro
			fg = "#ebdbb2",
			yellow = "#d79921",
			green = "#98971a",
			blue = "#458588", -- azul Gruvbox original (más apagado)
			red = "#cc241d",
			purple = "#b16286",
			cyan = "#83a598", -- celeste Gruvbox, más cálido que el anterior
			gray = "#a89984",
			alt_bg = "#3c3836",
		}

		-- Custom Gruvbox theme for lualine
		local my_lualine_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			command = {
				a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			inactive = {
				a = { fg = colors.gray, bg = colors.alt_bg, gui = "bold" },
				b = { fg = colors.gray, bg = colors.alt_bg },
				c = { fg = colors.gray, bg = colors.bg },
			},
		}

		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " },
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1, -- relative path for cleaner look
		}

		local branch = {
			"branch",
			icon = { "", color = { fg = colors.yellow } },
			separator = { right = "" },
		}

		lualine.setup({
			icons_enabled = true,
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				globalstatus = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { diff, filename },
				lualine_x = {
					{
						function()
							local ok, _ = pcall(require, "nvim-navic")
							return ok and require("nvim-navic").get_location() or ""
						end,
						cond = function()
							local ok, navic = pcall(require, "nvim-navic")
							return ok and navic.is_available()
						end,
						color = { fg = colors.cyan },
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.yellow },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return "󰠱 No LSP"
							end
							return " " .. clients[1].name
						end,
						icon = "",
					},
				},
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
