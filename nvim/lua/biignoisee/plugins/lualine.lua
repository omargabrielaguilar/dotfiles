return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			bg = "#2b3339", -- fondo oscuro principal
			fg = "#d3c6aa", -- texto principal
			yellow = "#dbbc7f", -- amarillo cálido
			green = "#a7c080", -- verde suave bosque
			blue = "#7fbbb3", -- azul verdoso
			red = "#e67e80", -- rojo coral
			gray = "#868d80", -- gris medio
			magenta = "#d699b6", -- rosa/magenta suave
		}

		local my_lualine_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = "#3a454a" },
				c = { fg = colors.fg, bg = "#3a454a" },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = "#3a454a" },
				c = { fg = colors.fg, bg = "#3a454a" },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
				b = { fg = colors.fg, bg = "#3a454a" },
				c = { fg = colors.fg, bg = "#3a454a" },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = "#3a454a" },
				c = { fg = colors.fg, bg = "#3a454a" },
			},
			inactive = {
				a = { fg = colors.gray, bg = "#3a454a", gui = "bold" },
				b = { fg = colors.gray, bg = "#3a454a" },
				c = { fg = colors.gray, bg = "#3a454a" },
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
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			-- cond = hide_in_width,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
		}

		local branch = { "branch", icon = { "", color = { fg = "#A6D4DE" } }, "|" }

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
						color = { fg = "#A6D4DE" },
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					{
						function()
							local clients = vim.lsp.get_active_clients({ bufnr = 0 })
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
