local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = false })

-- ============================================================================
-- DIAGNOSTICS (UI)
-- ============================================================================
local diagnostic_signs = { Error = " ", Warn = " ", Hint = "", Info = "" }

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true, header = "", prefix = "", focusable = false, style = "minimal" },
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

-- ============================================================================
-- ON ATTACH (Atajos Nativos)
-- ============================================================================
local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end
	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)
	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true, bufnr = bufnr })
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ============================================================================
-- CAPABILITIES (blink.cmp)
-- ============================================================================
vim.lsp.config["*"] = {
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("blink.cmp").get_lsp_capabilities()
	),
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

-- ============================================================================
-- MOTOR DE SERVIDORES (Velocidad y Modularidad)
-- ============================================================================
-- 1. Servidores que tienen archivo propio en lua/lsp/servers/
local configured_servers = { "clangd", "lua_ls", "ts_ls", "efm" }

-- 2. Importar servidores generales
local general_servers = require("lsp.servers.general")

-- Unimos las dos listas
local all_servers = {}
for _, srv in ipairs(configured_servers) do
	table.insert(all_servers, srv)
end
for _, srv in ipairs(general_servers) do
	table.insert(all_servers, srv)
end

-- Cargar configuración dinámicamente si existe
for _, lsp_name in ipairs(configured_servers) do
	local ok, custom_config = pcall(require, "lsp.servers." .. lsp_name)
	if ok and type(custom_config) == "table" then
		vim.lsp.config(lsp_name, custom_config)
	else
		vim.lsp.config(lsp_name, {})
	end
end

-- Habilitar todos los servidores de un solo golpe
vim.lsp.enable(all_servers)
