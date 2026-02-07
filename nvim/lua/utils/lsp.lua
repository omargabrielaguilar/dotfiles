local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	local bufnr = event.buf
	local map = vim.keymap.set

	local opts = function(desc)
		return { noremap = true, silent = true, buffer = bufnr, desc = desc }
	end

	-- 🧭 Navigation (pure LSP)
	map("n", "gd", vim.lsp.buf.definition, opts("LSP: Go to definition"))
	map("n", "gr", vim.lsp.buf.references, opts("LSP: List references"))
	map("n", "gi", vim.lsp.buf.implementation, opts("LSP: Go to implementation"))
	map("n", "gy", vim.lsp.buf.type_definition, opts("LSP: Go to type definition"))
	map("n", "K", vim.lsp.buf.hover, opts("LSP: Hover documentation"))
	map("n", "<C-k>", vim.lsp.buf.signature_help, opts("LSP: Signature help"))

	-- 🩺 Diagnostics
	map("n", "<leader>d", vim.diagnostic.open_float, opts("Diagnostics: Line diagnostics"))
	map("n", "<leader>pd", vim.diagnostic.goto_prev, opts("Diagnostics: Previous"))
	map("n", "<leader>nd", vim.diagnostic.goto_next, opts("Diagnostics: Next"))
	map("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts("Diagnostics: Show line diagnostics"))

	-- ✏️ Refactor
	map("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP: Rename symbol"))
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts("LSP: Code actions"))

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
			end, 51)
		end, opts("LSP: Organize imports + format"))
	end
end

return M
