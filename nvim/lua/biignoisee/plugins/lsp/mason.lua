-- mason.lua
return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"dockerls",
				"intelephense",
				"ts_ls",
				"tailwindcss",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"php-cs-fixer",
				"stylua",
				"phpstan",
				"blade-formatter",
				"prettier",
				"eslint_d",
			},
		})
	end,
}
