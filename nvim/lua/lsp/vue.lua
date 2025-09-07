return function(lspconfig, capabilities)
	lspconfig.volar.setup({
		capabilities = capabilities,
		cmd = { "vue-language-server", "--stdio" },
		filetypes = { "vue" }, -- ⚡ solo Vue, no JS/TS
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		init_options = {
			typescript = {
				tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
			},
		},
		on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
