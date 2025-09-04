return function(lspconfig, capabilities)
	lspconfig.ts_ls.setup({
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		settings = {
			typescript = {
				format = {
					indentSize = 2,
					convertTabsToSpaces = true,
					tabSize = 2,
				},
				preferences = {
					importModuleSpecifier = "relative", -- "non-relative" si prefieres alias/paths
					quotePreference = "single", -- usa comillas simples
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
		-- nada de keymaps locales, ya los tienes en LspAttach
		on_attach = function(client, _)
			-- Desactiva el formateo nativo si vas a usar prettier/eslint
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
