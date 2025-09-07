return function(lspconfig, capabilities)
	-- Detecta si estamos en un proyecto Vue
	local is_vue_project = lspconfig.util.root_pattern("package.json")(vim.fn.getcwd())
		and vim.fn.filereadable(vim.fn.getcwd() .. "/package.json") == 1
		and string.find(vim.fn.readfile("package.json")[1] or "", "vue")

	-- Si es Vue, no levantes tsserver
	if is_vue_project then
		return
	end

	lspconfig.tsserver.setup({
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
				format = { indentSize = 2, convertTabsToSpaces = true, tabSize = 2 },
				preferences = {
					importModuleSpecifier = "relative",
					quotePreference = "single",
				},
			},
			javascript = {
				format = { indentSize = 2, convertTabsToSpaces = true, tabSize = 2 },
			},
		},
		on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
		end,
	})
end
