return function(lspconfig, capabilities)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = { checkThirdParty = false },
			},
		},
	})
end
