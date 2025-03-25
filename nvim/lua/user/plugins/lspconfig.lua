-- Setup Mason to automatically install LSP servers
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP
require("lspconfig").intelephense.setup({
	capabilities = capabilities,
	init_options = {
		licenceKey = "00D0IEADQVBNA0K",
	},
	settings = {
		intelephense = {
			files = {
				maxSize = 1000000,
			},
			format = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				undefinedTypes = true,
				undefinedFunctions = true,
				undefinedConstants = true,
				unusedVariables = true,
				unusedFunctions = true,
			},
			completion = {
				fullyQualifyGlobalConstants = true,
				triggerParameterHints = true,
			},
			environment = {
				phpVersion = "8.4.0",
			},
			telemetry = {
				enabled = false,
			},
		},
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

require("lspconfig").clangd.setup({
	capabilities = capabilities,
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed", "--header-insertion=never" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = require("lspconfig").util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
	settings = {
		clangd = {
			fallbackFlags = { "-std=c++20" },
		},
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
})

-- Vue, JavaScript, TypeScript
require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- JSON
require("lspconfig").jsonls.setup({
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
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
vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

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
