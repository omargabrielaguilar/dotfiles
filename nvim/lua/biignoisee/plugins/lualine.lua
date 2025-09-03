return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Brogrammer (Kitty accurate)
		local colors = {
			bg = "#1f1f1f",
			darker_bg = "#161616",
			alt_bg = "#2a2a2a",
			fg = "#e0e0e0",
			selection = "#3a3a3a",

			-- sobrio accents
			red = "#d75f5f",
			orange = "#d7875f",
			yellow = "#d7af5f", -- más apagado
			green = "#5faf5f",
			cyan = "#5f87af",
			blue = "#5f87d7",
			pink = "#af5faf",

			-- neutrals
			comment = "#808080",
			accent = "#d7af5f", -- un dorado/marrón suave
		}

		-- Brogrammer Lualine
		local my_lualine_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.accent, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.darker_bg },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.darker_bg },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.darker_bg },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.darker_bg },
			},
			command = {
				a = { fg = colors.bg, bg = colors.cyan, gui = "bold" },
				b = { fg = colors.fg, bg = colors.alt_bg },
				c = { fg = colors.fg, bg = colors.darker_bg },
			},
			inactive = {
				a = { fg = colors.comment, bg = colors.alt_bg, gui = "bold" },
				b = { fg = colors.comment, bg = colors.alt_bg },
				c = { fg = colors.comment, bg = colors.darker_bg },
			},
		}
		-- Components
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
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.yellow },
				removed = { fg = colors.red },
			},
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1,
			color = { fg = colors.fg, bg = colors.darker_bg },
			symbols = {
				modified = "●",
				readonly = "",
				unnamed = "󰘓",
				newfile = "",
			},
		}

		local branch = {
			"branch",
			icon = "",
			color = { fg = colors.purple, bg = colors.alt_bg },
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
				hint = { fg = colors.purple },
			},
			colored = true,
			update_in_insert = false,
		}

		lualine.setup({
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { diff, filename, diagnostics },
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
						color = { fg = colors.orange },
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
						color = { fg = colors.green },
					},
				},
				lualine_z = {
					{ "location", color = { fg = "#000000", bg = colors.accent, gui = "bold" } },
					{ "progress", color = { fg = "#000000", bg = colors.accent, gui = "bold" } },
				},
			},
			inactive_sections = {
				lualine_c = {
					{ "filename", color = { fg = colors.comment, bg = colors.darker_bg } },
				},
				lualine_x = {
					{ "location", color = { fg = colors.comment, bg = colors.darker_bg } },
				},
			},
		})
	end,
}
