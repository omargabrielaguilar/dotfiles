return function(lspconfig, capabilities)
	lspconfig.volar.setup({
		capabilities = capabilities,
		filetypes = {
			"vue",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		init_options = {
			typescript = {
				-- Conecta volar con el TS de mason
				tsdk = vim.fn.stdpath("data")
					.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
			},
		},
		on_attach = function(client, _)
			-- Igual que en TS: sin formateo nativo
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
