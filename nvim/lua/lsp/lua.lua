return function(lspconfig, capabilities)
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                completion = {
                    callSnippet = "Replace",
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                    maxPreload = 10000,
                    preloadFileSize = 10000,
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
                format = {
                    enable = true,
                    -- Puedes configurar el estilo de formateo aquí
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "2",
                        quote_style = "single",
                    }
                }
            },
        },
        on_attach = function(client, bufnr)
            -- Asegurarse de que el formateo esté habilitado para este cliente
            client.server_capabilities.documentFormattingProvider = true
        end
    })
end
