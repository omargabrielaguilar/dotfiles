vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- CORE
-- ============================================================================

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- ============================================================================
-- PLUGINS
-- ============================================================================

vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/oil.nvim",

	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},

	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",

	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},

	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/kdheepak/lazygit.nvim",

	-- ============================================================================
	-- THEMES
	-- ============================================================================

	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/shaunsingh/nord.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/sainnhe/everforest",
	"https://github.com/sainnhe/sonokai",
	"https://github.com/oxfist/night-owl.nvim",
	"https://github.com/dracula/vim",
	"https://github.com/marko-cerovac/material.nvim",
	"https://github.com/alacritty/alacritty-theme",
	"https://github.com/miikanissi/modus-themes.nvim",
	"https://github.com/nyoom-engineering/oxocarbon.nvim",
	"https://github.com/tiagovla/tokyodark.nvim",
	"https://github.com/ramojus/mellifluous.nvim",
	"https://github.com/scottmckendry/cyberdream.nvim",
	"https://github.com/vague2k/vague.nvim",
	"https://github.com/yazeed1s/oh-lucy.nvim",
	"https://github.com/ray-x/aurora",
	"https://github.com/kvrohit/substrata.nvim",
	"https://github.com/ficcdaf/ashen.nvim",
	"https://github.com/yashguptaz/calvera-dark.nvim",
	"https://github.com/killitar/obscure.nvim",
	"https://github.com/slugbyte/lackluster.nvim",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/yorumicolors/yorumi.nvim",
	"https://github.com/Skardyy/makurai-nvim",
	"https://github.com/y9san9/y9nika.nvim",
})

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.terminal")

-- ============================================================================
-- LSP
-- ============================================================================

require("lsp.blink")
require("lsp.config")
require("lsp.efm")

-- ============================================================================
-- THEME
-- ============================================================================

require("core.theme")
