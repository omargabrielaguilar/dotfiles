return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- "saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- LSP keymaps con prefijo "l" por "lsp"
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

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>lDg", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>ldg", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>llr", ":LspRestart<CR>", opts)

				opts.desc = "Signature help"
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end,
		})

		-- NOTE : Moved all this to Mason including local variables
		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		-- Change the Diagnostic symbols in the sign column (gutter)

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs, -- Enable signs in the gutter
			},
			virtual_text = true, -- Specify Enable virtual text for diagnostics
			underline = true, -- Specify Underline diagnostics
			update_in_insert = false, -- Keep diagnostics active in insert mode
		})

		-- NOTE :
		-- Moved back from mason_lspconfig.setup_handlers from mason.lua file
		-- as mason setup_handlers is deprecated & its causing issues with lsp settings
		--
		-- Setup servers
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Config lsp servers here
		-- lua_ls
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		--elixir
		lspconfig.elixirls.setup({
			cmd = {
				-- Ruta donde Mason instaló el elixir-ls
				vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh",
			},
			capabilities = capabilities,
			filetypes = { "elixir", "eelixir" },
			root_dir = function(fname)
				-- Busca mix.exs para detectar raíz del proyecto Elixir
				return lspconfig.util.root_pattern("mix.exs")(fname)
					or lspconfig.util.find_git_ancestor(fname)
					or vim.fn.getcwd()
			end,
			settings = {
				elixirLS = {
					dialyzerEnabled = false, -- Puedes activar si quieres dialyzer
					fetchDeps = false,
					suggestSpecs = true,
				},
			},
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					signs = true,
					update_in_insert = false,
				}),
			},
		})

		-- intelephense (php)
		lspconfig.intelephense.setup({
			capabilities = capabilities,
			cmd = { "intelephense", "--stdio" },
			filetypes = { "php" },
			root_dir = function(fname)
				local root_files = {
					"composer.json",
					".git",
					"phpunit.xml",
					"phpunit.xml.dist",
					".intelephense",
				}

				return lspconfig.util.root_pattern(unpack(root_files))(fname)
					or lspconfig.util.find_git_ancestor(fname)
					or vim.fn.getcwd()
			end,
			init_options = {
				licenceKey = "",
				globalStoragePath = vim.fn.expand("~/.intelephense"),
			},
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					signs = true,
					update_in_insert = false,
				}),
			},
			settings = {
				intelephense = {
					environment = {
						phpVersion = "8.3", -- Ajusta a tu versión
						includePaths = { "./vendor" },
					},
					diagnostics = {
						enable = true,
						undefinedTypes = true,
						undefinedFunctions = true,
						undefinedConstants = true,
						undefinedClassConstants = true,
						undefinedMethods = true,
						undefinedProperties = true,
						undefinedVariables = true,
						unusedVariables = true,
						undefinedExceptions = true,
					},
					completion = {
						maxItems = 100,
						insertUseDeclaration = true,
						fullyQualifyGlobalConstantsAndFunctions = true,
					},
					format = {
						enable = true,
						braces = "psr12",
					},
					files = {
						maxSize = 5000000,
						exclude = {
							"**/.git/**",
							-- "**/vendor/**",
							"**/node_modules/**",
						},
					},
					stubs = {
						"apache",
						"bcmath",
						"bz2",
						"calendar",
						"Core",
						"curl",
						"date",
						"dom",
						"fileinfo",
						"filter",
						"gd",
						"gettext",
						"hash",
						"iconv",
						"imap",
						"intl",
						"json",
						"libxml",
						"mbstring",
						"mysqli",
						"oci8",
						"openssl",
						"pcntl",
						"pcre",
						"PDO",
						"pdo_mysql",
						"pdo_pgsql",
						"Phar",
						"posix",
						"readline",
						"Reflection",
						"session",
						"SimpleXML",
						"soap",
						"sockets",
						"SPL",
						"sqlite3",
						"standard",
						"superglobals",
						"sysvmsg",
						"tidy",
						"tokenizer",
						"xml",
						"zip",
						"laravel",
						"livewire",
						"phpunit",
						"psr-http-message",
						"redis",
						"swoole",
						"carbon",
						"mockery",
						"php-di",
						"phpdocumentor",
						"random",
						"memcached",
					},
				},
			},
		})

		-- emmet_language_server
		lspconfig.emmet_ls.setup({
			cmd = { "emmet-ls", "--stdio" },
			capabilities = capabilities,
			filetypes = {
				"html",
				"css",
				"typescriptreact",
				"javascriptreact",
				"svelte",
				"less",
				"sass",
				"scss",
			},
			root_dir = function()
				return vim.loop.cwd()
			end,
		})

		lspconfig.dockerls.setup({
			cmd = { "docker-langserver", "--stdio" },
			filetypes = { "dockerfile" },
			root_dir = lspconfig.util.root_pattern("Dockerfile"),
			single_file_support = true,
		})

		-- denols
		lspconfig.denols.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		})

		-- ts_ls (replaces tsserver)
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local util = lspconfig.util
				return not util.root_pattern("deno.json", "deno.jsonc")(fname)
					and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
			end,
			single_file_support = false,
			init_options = {
				preferences = {
					includeCompletionsWithSnippetText = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})
	end,
}
