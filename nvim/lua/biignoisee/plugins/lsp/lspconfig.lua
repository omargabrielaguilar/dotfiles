-- plugins/lsp.lua
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

		-- 📌 Keymaps LSP al conectar
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local keymap = vim.keymap.set
				local opts = { buffer = ev.buf, silent = true }

				-- Navegación
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

				-- Acciones
				keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = ev.buf })
				keymap("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart Rename", buffer = ev.buf })

				-- Diagnósticos
				keymap(
					"n",
					"<leader>ltg",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Buffer Diagnostics", buffer = ev.buf }
				)
				keymap("n", "<leader>ldg", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = ev.buf })

				-- Docs
				keymap("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
				keymap("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = ev.buf })

				-- Formatting
				keymap("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "Format File", buffer = ev.buf })
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

		-- 🌟 PHP con Phpactor full tuneado
		lspconfig.phpactor.setup({
			capabilities = capabilities,
			filetypes = { "php", "blade" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("composer.json", ".git", ".phpactor.json")(fname) or vim.fn.getcwd()
			end,
			init_options = {
				["language_server_configuration.auto_config"] = false,
				["language_server_worse_reflection.inlay_hints.enable"] = true,
				["language_server_worse_reflection.inlay_hints.types"] = false,
				["language_server_worse_reflection.inlay_hints.params"] = true,
				["code_transform.import_globals"] = false,
				["indexer.exclude_patterns"] = {
					"/vendor/**/Tests/**/*",
					"/vendor/**/tests/**/*",
					"/vendor/composer/**/*",
					"/vendor/laravel/fortify/workbench/**/*",
					"/vendor/filament/**/.stubs.php",
					"/storage/framework/cache/**/*",
					"/storage/framework/views/**/*",
					"vendor/kirschbaum-development/eloquent-power-joins/.stubs.php",
					"/vendor/**/_ide_helpers.php",
				},
				["php_code_sniffer.enabled"] = false,
				["language_server_phpstan.enabled"] = false,
				["language_server_phpstan.level"] = "5",
				["language_server_phpstan.bin"] = "%project_root%/vendor/bin/phpstan",
				["language_server_phpstan.mem_limit"] = "2048M",
			},
			handlers = {
				["textDocument/publishDiagnostics"] = function(err, result, ...)
					if vim.endswith(result.uri, "Test.php") then
						result.diagnostics = vim.tbl_filter(function(d)
							return (not vim.startswith(d.message, 'Namespace should probably be "Tests'))
								and (not vim.endswith(d.message, "PHPUnit\\Framework\\MockObject\\MockObject given."))
						end, result.diagnostics)
					end
					if vim.endswith(result.uri, "blade.php") then
						result.diagnostics = vim.tbl_filter(function(d)
							return (not vim.startswith(d.message, 'Undefined variable "$this"'))
						end, result.diagnostics)
					end
					vim.lsp.diagnostic.on_publish_diagnostics(err, result, ...)
				end,
				["textDocument/inlayHint"] = function(err, result, ...)
					for _, res in ipairs(result or {}) do
						if res.kind == 2 then
							res.label = res.label .. ":"
						end
						res.label = res.label .. " "
					end
					vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
				end,
			},
		})
	end,
}
