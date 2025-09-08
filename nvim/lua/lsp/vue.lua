-- vue.lua
return function(lspconfig, capabilities)
	lspconfig.volar.setup({
		capabilities = capabilities,
		filetypes = { "vue" },
		init_options = {
			typescript = {
				tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
			},
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
