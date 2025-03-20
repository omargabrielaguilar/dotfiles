require("dashboard").setup({
	theme = "doom",
	config = {
		header = {
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"       ███╗   ███╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗ ██████╗        ",
			"       ████╗ ████║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗       ",
			"       ██╔████╔██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ██║   ██║       ",
			"       ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██║   ██║       ",
			"       ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ╚██████╔╝       ",
			"       ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝        ",
			"",
		},
		center = {
			{ action = "enew", desc = "New file", icon = " ", key = "n" },
			{ action = "Telescope find_files", desc = "Find file", icon = " ", key = "SPC f" },
			{ action = "Telescope oldfiles", desc = "Recent files", icon = " ", key = "SPC h" },
			{ action = "Telescope live_grep", desc = "Find Word", icon = " ", key = "SPC g" },
		},
		footer = { "" },
	},
})

-- Ajuste manual del padding para centrar verticalmente
vim.api.nvim_exec(
	[[
  augroup DashboardCenter
    autocmd!
    autocmd VimEnter * execute "normal! zt"
  augroup END
]],
	false
)

-- Colores personalizados
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#ff5555" }) -- Rojo para resaltar
vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#f8f8f2" })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#bd93f9" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#6272a4" })
