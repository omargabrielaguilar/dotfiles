local null_ls = require("null-ls")

-- Configurar mason-null-ls para instalar herramientas automáticamente
require("mason-null-ls").setup({
	ensure_installed = {
		"prettier",
		"eslint_d",
		"stylua",
		"phpcsfixer",
		"phpstan",
	},
	automatic_installation = true,
	handlers = {},
})

-- Configurar null-ls
null_ls.setup({
	debug = true, -- Habilita logs
	sources = {
		-- Formatters
		null_ls.builtins.formatting.prettier, -- JS, TS, Vue, JSON, etc.
		null_ls.builtins.formatting.stylua, -- Lua
		null_ls.builtins.formatting.phpcsfixer, -- PHP

		-- Linters
		null_ls.builtins.diagnostics.eslint_d, -- JS, TS, Vue
		null_ls.builtins.diagnostics.phpstan, -- PHP
	},
})

-- Autoformatear antes de guardar solo con null-ls
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({
			async = false,
			filter = function(client)
				return client.name == "null-ls"
			end,
		})
	end,
})
