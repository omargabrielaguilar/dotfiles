local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end
	local bufnr = event.buf
	local keymap = vim.keymap.set
	local opts = {
		noremap = true, -- prevent recursive mapping
		silent = true, -- don't print the command to the cli
		buffer = bufnr, -- restrict the keymap to the local buffer number
	}

	-- Diagnostics
	keymap("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	keymap("n", "<leader>d", function()
		vim.diagnostic.open_float()
	end, opts)
	keymap("n", "<leader>pd", function()
		vim.diagnostic.goto_prev()
	end, opts)
	keymap("n", "<leader>nd", function()
		vim.diagnostic.goto_next()
	end, opts)

	-- Code actions & rename
	keymap("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	keymap("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)

	-- Order Imports (if supported by the client LSP)
	if client:supports_method("textDocument/codeAction", bufnr) then
		keymap("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
				bufnr = bufnr,
			})
			-- format after changing import order
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50) -- slight delay to allow for the import order to go first
		end, opts)
	end
end

return M
