return function(lspconfig, capabilities)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
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
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						-- Tu configuración lua (init.lua y lua/*)
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
					checkThirdParty = false, -- evita mensajes molestos de sumneko
				},
				telemetry = {
					enable = false, -- desactiva telemetry para que no mande datos
				},
			},
		},
	})
end
