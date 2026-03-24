-- ================================================================================================
-- TITLE : intelephense (PHP Language Server) LSP Setup - PREMIUM GOAT MODE 🐐
-- LINKS :
--   > https://github.com/bmewburn/intelephense-docs
-- ================================================================================================

local license_path = vim.fn.expand "~/.local/share/intelephense/license.txt"
local licence_key = ""
do
	local f = io.open(license_path, "r")
	if f then
		licence_key = f:read "*l" or ""
		f:close()
	end
end

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("intelephense", {
		capabilities = capabilities,

		-- Root directory detection
		root_markers = {
			"composer.json",
			".git",
			"artisan", -- Laravel
			"wp-config.php", -- WordPress
		},

		init_options = {
			licenceKey = licence_key,
			clearCache = false,
			-- Habilita todas las features premium
			globalStoragePath = vim.fn.expand "~/.local/share/intelephense",
		},

		settings = {
			intelephense = {
				-- 📁 FILES & PERFORMANCE
				files = {
					maxSize = 5000000,
					-- 🔥 Añadimos .blade.php para que el premium lo indexe
					associations = { "*.php", "*.phtml", "*.blade.php", "*.module", "*.inc", "*.theme" },
					exclude = {
						"**/.git/**",
						"**/.svn/**",
						"**/.hg/**",
						"**/CVS/**",
						"**/.DS_Store/**",
						"**/node_modules/**",
						"**/bower_components/**",
						"**/vendor/**/tests/**",
						"**/vendor/**/test/**",
						"**/vendor/**/*_test.php",
						"**/.history/**",
						"**/storage/framework/views/**",
						"**/bootstrap/cache/**",
					},
				},
				-- 🎯 STUBS - Incluye todo lo moderno
				stubs = {
					"apache",
					"bcmath",
					"bz2",
					"calendar",
					"com_dotnet",
					"Core",
					"ctype",
					"curl",
					"date",
					"dba",
					"dom",
					"enchant",
					"exif",
					"FFI",
					"fileinfo",
					"filter",
					"fpm",
					"ftp",
					"gd",
					"gettext",
					"gmp",
					"hash",
					"iconv",
					"imap",
					"intl",
					"json",
					"ldap",
					"libxml",
					"mbstring",
					"meta",
					"mysqli",
					"oci8",
					"odbc",
					"openssl",
					"pcntl",
					"pcre",
					"PDO",
					"pdo_ibm",
					"pdo_mysql",
					"pdo_pgsql",
					"pdo_sqlite",
					"pgsql",
					"Phar",
					"posix",
					"pspell",
					"readline",
					"Reflection",
					"session",
					"shmop",
					"SimpleXML",
					"snmp",
					"soap",
					"sockets",
					"sodium",
					"SPL",
					"sqlite3",
					"standard",
					"superglobals",
					"sysvmsg",
					"sysvsem",
					"sysvshm",
					"tidy",
					"tokenizer",
					"xml",
					"xmlreader",
					"xmlrpc",
					"xmlwriter",
					"xsl",
					"Zend OPcache",
					"zip",
					"zlib",
					"redis",
					"imagick",
					"mongodb",
					"amqp",
					"yaml",
					"grpc",
					"protobuf",
					"swoole",
					"xdebug",
					"pcov",
				},
				-- 🧠 COMPLETION - Autocompletado premium
				completion = {
					insertUseDeclaration = true,
					fullyQualifyGlobalConstantsAndFunctions = false,
					triggerParameterHints = true,
					maxItems = 16,
				},

				-- 🔍 CODE INTELLIGENCE
				format = {
					enable = true,
					braces = "psr13",
					sortUseDeclarations = true,
				},

				-- 📊 DIAGNOSTICS - Análisis profundo
				diagnostics = {
					enable = true,
					run = "onType",
					embeddedLanguages = true,
					undefinedSymbols = true,
					undefinedFunctions = true,
					undefinedConstants = true,
					undefinedClassConstants = true,
					-- 🔥 Apagamos estos dos. Son incompatibles con Laravel/Filament sin un IDE Helper perfecto.
					undefinedMethods = false,
					undefinedProperties = false,
					undefinedTypes = true,
					unusedSymbols = true,
					typeErrors = "Warning",
					undefinedVariables = "Warning",
					languageConstraints = true,
					implementationErrors = true,
					duplicateSymbols = true,
				},

				-- 🎨 ENVIRONMENT
				environment = {
					-- 🔥 Corregido a una versión real de PHP
					phpVersion = "8.3.0",
					shortOpenTag = false,
					documentRoot = vim.fn.getcwd(),
				},
				-- 🔧 RUNTIME
				runtime = vim.fn.exepath "php" ~= "" and vim.fn.exepath "php" or nil,

				-- 📦 PHPUNIT & PEST
				phpdoc = {
					returnVoid = true,
					textFormat = "snippet",
					classTemplate = {
						summary = "$2",
						tags = {
							"@author ${2:Your Name}",
							"@package ${3:App\\\\${3:Namespace}}",
						},
					},
					functionTemplate = {
						summary = "$2",
						tags = {
							"@param ${2:$SYMBOL_TYPE} $${1:$SYMBOL_NAME} ${2:$SYMBOL_DESCRIPTION}",
							"@return ${2:$SYMBOL_TYPE} ${2:$SYMBOL_DESCRIPTION}",
							"@throws ${2:\\Exception}",
						},
					},
				},

				-- 🚀 TELEMETRY
				telemetry = {
					enabled = false, -- Privacidad
				},

				-- 🔐 RENAME - Renombrado inteligente (PREMIUM)
				rename = {
					exclude = {
						"**/vendor/**",
						"**/node_modules/**",
					},
					namespaceMode = "all", -- Renombra namespace en todos lados
				},

				-- 🧪 REFERENCIAS
				references = {
					exclude = {
						"**/vendor/**",
					},
				},
			},
		},
	})
end
