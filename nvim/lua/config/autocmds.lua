-- ================================================================================================
-- TITLE : auto-commands
-- ================================================================================================
local on_attach = require("utils.lsp").on_attach

-- ─── Autopairs casero ────────────────────────────────────────────────────────
local pairs_map = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'", ["`"] = "`", ["<"] = ">" }
for open, close in pairs(pairs_map) do
	vim.keymap.set("i", open, function() return open .. close .. "<Left>" end, { expr = true })
end

-- ─── Grupos de autocomandos ───────────────────────────────────────────────────
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- ─── Blade: forzar treesitter ─────────────────────────────────────────────────
autocmd("FileType", {
	group = augroup "BladeTreesitter",
	pattern = "blade",
	callback = function() vim.treesitter.start() end,
})

-- ─── Restaurar posición del cursor ───────────────────────────────────────────
autocmd("BufReadPost", {
	group = augroup "LastCursor",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
	end,
})

-- ─── Highlight del texto copiado ─────────────────────────────────────────────
autocmd("TextYankPost", {
	group = augroup "YankHighlight",
	pattern = "*",
	callback = function() vim.hl.on_yank { higroup = "IncSearch", timeout = 200 } end,
})

-- ─── Formato al guardar ───────────────────────────────────────────────────────
-- blade y php usan intelephense | todo lo demás usa efm
-- format on save using efm langserver and configured formatters
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		vim.cmd "checktime"

		local ft = vim.bo.filetype
		local client_name = (ft == "php") and "intelephense" or "efm"
		vim.lsp.buf.format {
			name = client_name,
			async = false,
			timeout_ms = 2500,
		}
	end,
}) -- ─── LSP keymaps al adjuntarse ───────────────────────────────────────────────
autocmd("LspAttach", {
	group = augroup "LspMappings",
	callback = on_attach,
})
