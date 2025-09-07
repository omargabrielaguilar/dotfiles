return function(lspconfig, capabilities)
	lspconfig.ts_ls.setup({
		capabilities = capabilities,
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		init_options = {
			hostInfo = "neovim",
		},
		settings = {
			typescript = {
				format = {
					indentSize = 2,
					convertTabsToSpaces = true,
					tabSize = 2,
				},
				preferences = {
					importModuleSpecifier = "relative", -- usa rutas relativas
					quotePreference = "single", -- comillas simples
				},
			},
			javascript = {
				format = {
					indentSize = 2,
					convertTabsToSpaces = true,
					tabSize = 2,
				},
			},
		},
		on_attach = function(client, bufnr)
			-- Desactiva el formateo nativo si vas a usar Prettier/ESLint
			client.server_capabilities.documentFormattingProvider = false

			-- Aquí puedes añadir keymaps locales para TS/JS si quieres
			-- ejemplo: vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
		end,
	})
end
