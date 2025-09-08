-- typescript.lua
return function(lspconfig, capabilities)
	lspconfig.vtsls.setup({
		capabilities = capabilities,
		settings = {
			complete_function_calls = true,
			vtsls = {
				autoUseWorkspaceTsdk = true,
			},
		},
	})
end
