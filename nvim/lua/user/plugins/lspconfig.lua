-- Setup Mason to automatically install LSP servers
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP
require("lspconfig").intelephense.setup({ capabilities = capabilities })

-- Vue, JavaScript, TypeScript
require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
-- Tailwind CSS
require("lspconfig").tailwindcss.setup({ capabilities = capabilities })

-- JSON
require("lspconfig").jsonls.setup({
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})

-- SQL
require("lspconfig").sqlls.setup({
	capabilities = capabilities,
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/sql-language-server", "up", "--method", "stdio" },
	root_dir = require("lspconfig.util").root_pattern(
		".git",
		"package.json",
		"sqlconfig.json",
		".sqllsrc.json",
		".sqlls.json"
	) or vim.fn.getcwd(),
})

-- Keymaps
vim.keymap.set("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = false,
	float = {
		source = true,
	},
})
-- Sign configuration
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
