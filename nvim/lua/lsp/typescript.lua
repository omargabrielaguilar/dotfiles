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
		init_options = { hostInfo = "neovim" },
		settings = {
			typescript = {
				format = {
					indentSize = 2,
					convertTabsToSpaces = true,
					tabSize = 2,
				},
				preferences = {
					importModuleSpecifier = "relative",
					quotePreference = "single",
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
		on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
