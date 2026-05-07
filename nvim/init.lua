vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- ⚡ CARGA INSTANTÁNEA (Solo Core y Dashboard)
-- ============================================================================
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.theme")

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
	-- THEMES (La Élite)
	-- ============================================================================
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/sainnhe/everforest",
})

-- ============================================================================
-- CARGA PEREZOSA (Event-driven Lazy Loading)
-- ============================================================================
require("plugins.dashboard") -- El dashboard debe cargar al instante

-- 1. Plugins ligeros en segundo plano (10ms de delay)
vim.defer_fn(function()
	require("plugins.fzf")
	require("plugins.terminal")
	require("plugins.mini")
end, 10)

-- 2. El peso pesado: LSP, Treesitter y Git (Solo cargan al abrir código)
local lazy_augroup = vim.api.nvim_create_augroup("LazyLoadConfig", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = lazy_augroup,
	callback = function()
		require("plugins.treesitter")
		require("plugins.gitsigns")
		require("lsp.blink")
		require("lsp.config")
		require("lsp.efm")
	end,
	once = true,
})

-- 3. Oil.nvim (Solo carga si abres un directorio)
vim.api.nvim_create_autocmd("BufEnter", {
	group = lazy_augroup,
	callback = function(args)
		if vim.fn.isdirectory(args.file) == 1 then
			require("plugins.oil")
		end
	end,
	once = true,
})
