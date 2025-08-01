return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			bg = "#181616",
			fg = "#c5c9c5",
			yellow = "#c4b28a",
			green = "#8a9a7b",
			blue = "#8ba4b0",
			red = "#c4746e",
			gray = "#727169",
		}

		local my_lualine_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = "#1f1f1f" },
				c = { fg = colors.fg, bg = "#1f1f1f" },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = "#1f1f1f" },
				c = { fg = colors.fg, bg = "#1f1f1f" },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
				b = { fg = colors.fg, bg = "#1f1f1f" },
				c = { fg = colors.fg, bg = "#1f1f1f" },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = "#1f1f1f" },
				c = { fg = colors.fg, bg = "#1f1f1f" },
			},
			inactive = {
				a = { fg = colors.gray, bg = "#1f1f1f", gui = "bold" },
				b = { fg = colors.gray, bg = "#1f1f1f" },
				c = { fg = colors.gray, bg = "#1f1f1f" },
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
