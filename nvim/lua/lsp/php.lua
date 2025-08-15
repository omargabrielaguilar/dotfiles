-- ~/Documentos/omar/dotfiles/nvim/lua/lsp/php.lua
return function(lspconfig, capabilities)
	lspconfig.intelephense.setup({
		capabilities = capabilities,
		filetypes = { "php", "blade" }, -- soporte blade si usas el plugin correcto
		root_dir = function(fname)
			return lspconfig.util.root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
		end,
		settings = {
			intelephense = {
				-- Entorno
				environment = {
					phpVersion = "8.4", -- o la versión que uses
				},

				-- Indexación
				files = {
					maxSize = 5000000, -- 5MB por archivo
					associations = { "*.php", "*.blade.php" },
					exclude = {
						"**/vendor/**/{Tests,tests}/**/*",
						"**/vendor/composer/**",
						"**/vendor/laravel/fortify/workbench/**/*",
						"**/storage/framework/{cache,views}/**/*",
						"**/vendor/**/_ide_helpers.php",
					},
				},

				-- Diagnósticos
				diagnostics = {
					enable = true,
				},

				-- Formato
				format = {
					enable = true,
				},

				-- Laravel boost con IDE Helper
				stubs = {
					"laravel",
					"laravel-ide-helper",
					"eloquent",
					"blade",
					"auth",
					"session",
					"filesystem",
					"queue",
					"cache",
					"phpunit",
					"Carbon",
				},
			},
		},
	})
end
