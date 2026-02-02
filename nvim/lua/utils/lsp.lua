local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	local bufnr = event.buf
	local map = vim.keymap.set
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- 🧭 Navigation (pure LSP)
	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "gy", vim.lsp.buf.type_definition, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

	-- 🩺 Diagnostics
	map("n", "<leader>d", vim.diagnostic.open_float, opts)
	map("n", "<leader>pd", vim.diagnostic.goto_prev, opts)
	map("n", "<leader>nd", vim.diagnostic.goto_next, opts)
	map("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)

	-- ✏️ Refactor
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- 📦 Organize Imports (if supported)
	if client:supports_method("textDocument/codeAction", bufnr) then
		map("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

return M
