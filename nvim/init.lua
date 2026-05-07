vim.opt.termguicolors = true

local function set_transparent()
	local groups = {
		"Normal", "NormalNC", "EndOfBuffer", "NormalFloat", "FloatBorder",
		"SignColumn", "StatusLine", "StatusLineNC", "TabLine", "TabLineFill",
		"TabLineSel", "ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

vim.cmd.colorscheme("retrobox")
set_transparent()

-- Como "set_transparent" ya fue creada arriba, esto funcionará perfecto.
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_transparent,
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

	-- === TEMAS ===
	"https://github.com/neanias/everforest-nvim", -- Ya lo tenías
	"https://github.com/rebelot/kanagawa.nvim",   -- Kanagawa
	"https://github.com/navarasu/onedark.nvim",   -- One Dark
	"https://github.com/oxfist/night-owl.nvim",   -- Night Owl
	
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