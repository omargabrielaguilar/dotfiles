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
				maxSize = 1000000, -- Tamaño máximo de archivos analizados (1MB)
			},
			format = {
				enable = true, -- Habilita el formateo
			},
			diagnostics = {
				enable = true, -- Habilita diagnóstico de errores y advertencias
				undefinedTypes = true,
				undefinedFunctions = true,
				undefinedConstants = true,
				unusedVariables = true,
				unusedFunctions = true,
			},
			completion = {
				fullyQualifyGlobalConstants = true, -- Agrega prefijo a constantes globales
				triggerParameterHints = true, -- Muestra información de parámetros en funciones
			},
			environment = {
				phpVersion = "8.4.0", -- Configurar PHP 8.2
			},
			telemetry = {
				enabled = false, -- Deshabilita telemetría (recomendado)
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

require("lspconfig").gopls.setup({
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                nilness = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true, -- Formateo con gofumpt
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

-- emmet || html
require("lspconfig").html.setup({
	capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
})

require("lspconfig").emmet_language_server.setup({
	capabilities = capabilities, -- Asegura compatibilidad con cmp
	cmd = { "emmet-language-server", "--stdio" },
	filetypes = {
		"css",
		"eruby",
		"html",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"typescriptreact",
		"htmlangular",
	},
	init_options = {
		showexpandedabbreviation = "always",
		showabbreviationsuggestions = true,
		showcursormovementsuggestions = false,
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
