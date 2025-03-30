local null_ls = require("null-ls")

-- Configurar mason-null-ls para instalar herramientas automáticamente
require("mason-null-ls").setup({
	ensure_installed = { "prettier", "eslint_d", "stylua", "phpcsfixer", "phpstan" },
	automatic_installation = true,
	handlers = {},
})

-- Configurar null-ls
null_ls.setup({
	debug = true, -- Para ver logs si sigue fallando
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[augroup LspFormatting]])
			vim.cmd([[autocmd!]])
			vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false})]])
			vim.cmd([[augroup END]])
		end
	end,
	sources = {
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.diagnostics.phpstan,
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
