return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			bg = "#282828",
			fg = "#ebdbb2",
			yellow = "#fabd2f",
			green = "#b8bb26",
			blue = "#83a598",
			red = "#fb4934",
			gray = "#928374",
		}
		local my_lualine_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
				b = { fg = colors.fg, bg = "#3c3836" },
				c = { fg = colors.fg, bg = "#3c3836" },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = "#3c3836" },
				c = { fg = colors.fg, bg = "#3c3836" },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = "#3c3836" },
				c = { fg = colors.fg, bg = "#3c3836" },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = "#3c3836" },
				c = { fg = colors.fg, bg = "#3c3836" },
			},
			inactive = {
				a = { fg = colors.gray, bg = "#3c3836", gui = "bold" },
				b = { fg = colors.gray, bg = "#3c3836" },
				c = { fg = colors.gray, bg = "#3c3836" },
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
