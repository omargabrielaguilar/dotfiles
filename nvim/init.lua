-- ============================================================================
-- SISTEMA DE TEMAS Y TRANSPARENCIA
-- ============================================================================
vim.opt.termguicolors = true

-- Ruta donde guardaremos el último tema elegido
local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

-- Función para leer el tema guardado
local function get_saved_theme()
	local f = io.open(theme_file, "r")
	if f then
		local theme = f:read("*l")
		f:close()
		if theme and theme ~= "" then
			-- MAGIA AQUÍ: Limpiamos espacios y saltos de línea invisibles
			return theme:match("^%s*(.-)%s*$")
		end
	end
	return "retrobox" -- Tema por defecto
end

-- Función para aplicar la transparencia
local function set_transparent()
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

-- 1. Cargar el tema guardado
local current_theme = get_saved_theme()
local ok = pcall(vim.cmd.colorscheme, current_theme)
if not ok then
	vim.cmd.colorscheme("retrobox")
end

-- 2. Aplicar transparencia inicial
set_transparent()

-- 3. Autocmd: Guarda inteligentemente y reaplica transparencia
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function(args)
		-- Usamos vim.g.colors_name para obtener el nombre real del tema aplicado
		local new_theme = vim.g.colors_name or args.match
		if new_theme then
			local f = io.open(theme_file, "w")
			if f then
				f:write(new_theme)
				f:close()
			end
		end
		-- Reaplicar transparencia
		set_transparent()
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/kdheepak/lazygit.nvim",

	-- === TEMAS FAMOSOS Y POPULARES ===
	"https://github.com/neanias/everforest-nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/oxfist/night-owl.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/shaunsingh/nord.nvim",
	"https://github.com/dracula/vim",
	"https://github.com/sainnhe/sonokai",
})

require("core.options")
require("core.statusline")
require("core.keymaps")
require("core.autocmds")

require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.terminal")

require("lsp.blink")
require("lsp.config")
require("lsp.efm")

