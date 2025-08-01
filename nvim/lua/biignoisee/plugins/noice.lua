return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local noice = require("noice")

			noice.setup({
				cmdline = {
					enabled = true,
					view = "cmdline_popup",
					format = {
						cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
						help = { pattern = "^:%s*he?l?p?%s+", icon = "󰮦 :" },
						search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
						search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
						filter = { pattern = "^:%s*!", icon = "$ :", lang = "bash" },
						lua = {
							pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
							icon = " :",
							lang = "lua",
						},
						input = { view = "cmdline_input", icon = "󰥻 :" },
					},
				},
				views = {
					popupmenu = {
						relative = "editor",
						position = {
							row = 17,
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
							max_height = 15,
						},
						border = {
							style = "rounded",
						},
						win_options = {
							winhighlight = {
								Normal = "Normal",
								FloatBorder = "DiagnosticInfo",
							},
						},
					},
				},
				popupmenu = {
					enabled = true,
				},
				lsp = {
					progress = {
						enabled = true,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						auto_open = { enabled = false },
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
								{ find = "%d fewer lines" },
								{ find = "%d more lines" },
							},
						},
						opts = { skip = true },
					},
				},
				messages = {
					enabled = false,
				},
				health = {
					checker = true,
				},
				signature = {
					enabled = true,
				},
			})
		end,
	},
}
