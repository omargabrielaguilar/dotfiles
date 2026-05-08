vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- ⚡ CARGA INSTANTÁNEA (Solo Core y Dashboard)
-- ============================================================================
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.theme")
require("core.statusline")

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

	-- DASHBOARD
	"https://github.com/goolord/alpha-nvim",

	-- ============================================================================
	-- THEMES
	-- ============================================================================
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/sainnhe/everforest",

	-- ============================================================================
	-- EXTRAS
	-- ============================================================================
	"https://github.com/b0o/incline.nvim",

	-- NEOTEST GO
	-- TESTING
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/nvim-neotest/neotest-go",
})

-- ============================================================================
-- CARGA PEREZOSA (Event-driven Lazy Loading)
-- ============================================================================
require("plugins.dashboard") -- El dashboard debe cargar al instante

-- 1. Plugins ligeros en segundo plano (10ms de delay)
vim.defer_fn(function()
	require("plugins.fzf")
	require("plugins.mini")
	require("plugins.incline")
end, 10)

-- 2. El peso pesado: LSP, Treesitter y Git (Solo cargan al abrir código)
local lazy_augroup = vim.api.nvim_create_augroup("LazyLoadConfig", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = lazy_augroup,
	callback = function()
		require("plugins.treesitter")
		require("plugins.gitsigns")
		require("plugins.oil")
		require("lsp.blink")
		require("lsp.efm")
		require("lsp.config")
		require("plugins.neotest")
	end,
	once = true,
})
