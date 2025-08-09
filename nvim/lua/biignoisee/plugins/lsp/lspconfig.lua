return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Keymaps al conectar LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- 📌 Navegación
				opts.desc = "Show LSP references"
				vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts)
				opts.desc = "Go to declaration"
				vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)
				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts)
				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts)
				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				-- 📌 Refactor / Acciones
				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)

				-- 📌 Diagnósticos
				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>lDg", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>ldg", vim.diagnostic.open_float, opts)

				-- 📌 Docs y ayuda
				opts.desc = "Hover documentation"
				vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
				opts.desc = "Signature help"
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

				-- 📌 Extra útil
				opts.desc = "Format file"
				vim.keymap.set("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>llr", ":LspRestart<CR>", opts)

				-- 📌 Phpactor-specific extras
				opts.desc = "Phpactor: Import Class"
				vim.keymap.set("n", "<leader>lp", ":PhpactorImportClass<CR>", opts)
				opts.desc = "Phpactor: Class New"
				vim.keymap.set("n", "<leader>lpc", ":PhpactorClassNew<CR>", opts)
				opts.desc = "Phpactor: Transform"
				vim.keymap.set("n", "<leader>lpt", ":PhpactorTransform<CR>", opts)
				opts.desc = "Phpactor: Context Menu"
				vim.keymap.set("n", "<leader>lpm", ":PhpactorContextMenu<CR>", opts)
			end,
		})

		-- Símbolos diagnósticos
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}
		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Lua LSP
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- PHP con Phpactor
		lspconfig.phpactor.setup({
			capabilities = capabilities,
			filetypes = { "php" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
			end,
			init_options = {
				["language_server_phpstan.enabled"] = true, -- si tienes phpstan instalado
				["language_server_psalm.enabled"] = false,
			},
		})
	end,
}
