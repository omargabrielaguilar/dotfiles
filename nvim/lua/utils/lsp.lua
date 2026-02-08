local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then return end

	local bufnr = event.buf
	local map = vim.keymap.set

	local opts = function(desc) return { noremap = true, silent = true, buffer = bufnr, desc = desc } end

	-- 🧭 NAVEGACIÓN PRO (Usando  Picker donde brilla)
	map("n", "gd", function() Snacks.picker.lsp_definitions() end, opts "LSP: Go to definition")
	map("n", "gr", function() Snacks.picker.lsp_references() end, opts "LSP: List references")
	map("n", "gi", function() Snacks.picker.lsp_implementations() end, opts "LSP: Go to implementation")
	map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, opts "LSP: Go to type definition")
	map("n", "K", vim.lsp.buf.hover, opts "LSP: Hover documentation")
	map("n", "<C-k>", vim.lsp.buf.signature_help, opts "LSP: Signature help")

	-- 🩺 DIAGNÓSTICOS (Snacks ya los maneja muy bien)
	map("n", "<leader>d", function() Snacks.picker.diagnostics_buffer() end, opts "Diagnostics: Buffer")
	map("n", "<leader>D", function() Snacks.picker.diagnostics() end, opts "Diagnostics: Workspace")
	map("n", "<leader>pd", vim.diagnostic.goto_prev, opts "Diagnostics: Previous")
	map("n", "<leader>nd", vim.diagnostic.goto_next, opts "Diagnostics: Next")

	-- ✏️ REFACTOR & ACCIONES
	map("n", "<leader>rn", vim.lsp.buf.rename, opts "LSP: Rename symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts "LSP: Code actions")

	-- Organizar Imports + Formatear al guardar o con líder
	if client.name == "intelephense" then
		map("n", "<leader>oi", function()
			vim.lsp.buf.code_action {
				context = { only = { "source.organizeImports" } },
				apply = true,
			}
			vim.defer_fn(function()
				vim.lsp.buf.format { bufnr = bufnr, async = true }
				vim.notify("Imports organizados y archivo formateado", "info", { title = "PHP Intelephense" })
			end, 100)
		end, opts "Organize Imports + Format")
	end

	-- 💾 AUTO-FORMAT AL GUARDAR
	if client:supports_method "textDocument/formatting" then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function() vim.lsp.buf.format { bufnr = bufnr, id = client.id } end,
		})
	end
end

return M
