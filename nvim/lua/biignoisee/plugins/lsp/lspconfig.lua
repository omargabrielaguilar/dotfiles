return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Keymaps al conectar LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- 📌 Navegación LSP
				local keymap = vim.keymap.set
				keymap(
					"n",
					"<leader>lr",
					"<cmd>Telescope lsp_references<CR>",
					{ desc = "LSP References", buffer = ev.buf }
				)
				keymap(
					"n",
					"<leader>ld",
					"<cmd>Telescope lsp_definitions<CR>",
					{ desc = "LSP Definitions", buffer = ev.buf }
				)
				keymap("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = ev.buf })
				keymap(
					"n",
					"<leader>li",
					"<cmd>Telescope lsp_implementations<CR>",
					{ desc = "LSP Implementations", buffer = ev.buf }
				)
				keymap(
					"n",
					"<leader>lt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ desc = "LSP Type Definitions", buffer = ev.buf }
				)

				-- 📌 Refactor / Acciones
				keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = ev.buf })
				keymap("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart Rename", buffer = ev.buf })

				-- 📌 Diagnósticos
				keymap(
					"n",
					"<leader>lDg",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Buffer Diagnostics", buffer = ev.buf }
				)
				keymap("n", "<leader>ldg", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = ev.buf })

				-- 📌 Docs
				keymap("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
				keymap("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = ev.buf })

				-- 📌 Formatting
				keymap("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "Format File", buffer = ev.buf })

				-- 📌 Restart LSP
				keymap("n", "<leader>llr", ":LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf })

				-- 📌 Phpactor: Refactor y utilidades
				keymap(
					"n",
					"<leader>lp",
					":PhpactorImportClass<CR>",
					{ desc = "Phpactor: Import Class", buffer = ev.buf }
				)
				keymap("n", "<leader>lpc", ":PhpactorClassNew<CR>", { desc = "Phpactor: Class New", buffer = ev.buf })
				keymap("n", "<leader>lpt", ":PhpactorTransform<CR>", { desc = "Phpactor: Transform", buffer = ev.buf })
				keymap(
					"n",
					"<leader>lpm",
					":PhpactorContextMenu<CR>",
					{ desc = "Phpactor: Context Menu", buffer = ev.buf }
				)
				keymap(
					"n",
					"<leader>lpo",
					":PhpactorGotoDefinition<CR>",
					{ desc = "Phpactor: Goto Definition", buffer = ev.buf }
				)
				keymap(
					"n",
					"<leader>lpr",
					":PhpactorRenameVariable<CR>",
					{ desc = "Phpactor: Rename Variable", buffer = ev.buf }
				)
				keymap("n", "<leader>lpp", ":PhpactorCopyClass<CR>", { desc = "Phpactor: Copy Class", buffer = ev.buf })
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

		-- PHP con Phpactor (full power)
		lspconfig.phpactor.setup({
			capabilities = capabilities,
			filetypes = { "php" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("composer.json", ".git", ".phpactor.json")(fname) or vim.fn.getcwd()
			end,
			init_options = {
				["language_server_phpstan.enabled"] = true, -- Si tienes PHPStan
				["language_server_psalm.enabled"] = false, -- O ponlo en true si prefieres Psalm
				["code_transform.refactor.extract_constant"] = true,
				["code_transform.refactor.extract_method"] = true,
				["code_transform.refactor.extract_class"] = true,
				["language_server_completion.trim_leading_dollar"] = true,
				["language_server.diagnostics_on_save"] = true,
				["language_server_phpcsfixer.enabled"] = true,
			},
		})
	end,
}
