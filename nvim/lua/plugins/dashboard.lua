local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- El logo KONG en modo bestia
dashboard.section.header.val = {
	"                                           ",
	"    ██╗  ██╗ ██████╗ ███╗   ██╗ ██████╗    ",
	"    ██║ ██╔╝██╔═══██╗████╗  ██║██╔════╝    ",
	"    █████═╝ ██║   ██║██╔██╗ ██║██║  ███╗   ",
	"    ██╔═██╗ ██║   ██║██║╚██╗██║██║   ██║   ",
	"    ██║  ██╗╚██████╔╝██║ ╚████║╚██████╔╝   ",
	"    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝    ",
	"                                           ",
}

-- Los botones del menú principal (Expandido al máximo)
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":FzfLua files<CR>"),
	dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
	dashboard.button("g", "󰊄  Live grep", ":FzfLua live_grep<CR>"),
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	dashboard.button("s", "  Colorschemes", ":FzfLua colorschemes<CR>"),
	dashboard.button("l", "󰒲  LazyGit", ":LazyGit<CR>"),
	dashboard.button("m", "󰒋  Mason (LSP/Linters)", ":Mason<CR>"),
	dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
}

-- El recordatorio diario en el footer
dashboard.section.footer.val = "135 Weeks. Choose Hard. Live Easy."

-- Opciones de diseño para darle respiro
dashboard.config.layout = {
	{ type = "padding", val = 4 },
	dashboard.section.header,
	{ type = "padding", val = 2 },
	dashboard.section.buttons,
	{ type = "padding", val = 2 },
	dashboard.section.footer,
}

alpha.setup(dashboard.config)
