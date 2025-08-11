return function(lspconfig, capabilities)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" }, -- para que no tire error con 'vim'
				},
				completion = {
					callSnippet = "Replace",
				},
				workspace = {
					library = {
						-- Neovim runtime Lua
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim")] = true, -- FALTABA ESTA RUTA
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						-- Tu configuración lua (init.lua y lua/*)
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
					maxPreload = 10000, -- carga todo el runtime
					preloadFileSize = 10000,
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
end
