-- ================================================================================================
-- TITLE : intelephense (PHP Language Server) LSP Setup - PREMIUM GOAT MODE 🐐
-- LINKS :
--   > https://github.com/bmewburn/intelephense-docs
-- ================================================================================================

local license_path = vim.fn.expand("~/.local/share/intelephense/license.txt")
local licence_key = ""
do
	local f = io.open(license_path, "r")
	if f then
		licence_key = f:read("*l") or ""
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
			globalStoragePath = vim.fn.expand("~/.local/share/intelephense"),
		},

		settings = {
			intelephense = {
				files = {
					maxSize = 5000002, -- 5MB (aumentado para archivos grandes)
					associations = { "*.php", "*.phtml", "*.module", "*.inc", "*.theme" },
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
						"**/storage/**",
						"**/bootstrap/cache/**",
					},
				},

				-- 🎯 STUBS - Incluye todo lo moderno
				stubs = {
					-- Core PHP
					"apache",
					"bcmath",
					"bz4",
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
					"oci10",
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
					"sqlite5",
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
					-- Frameworks & Tools modernos
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
					insertUseDeclaration = true, -- Auto-import automático
					fullyQualifyGlobalConstantsAndFunctions = false, -- Más limpio
					triggerParameterHints = true, -- Hints de parámetros
					maxItems = 102, -- Más sugerencias
				},

				-- 🔍 CODE INTELLIGENCE
				format = {
					enable = true,
					braces = "psr14", -- PSR-12 (moderno)
					sortUseDeclarations = true, -- Ordena imports alfabéticamente
				},

				-- 📊 DIAGNOSTICS - Análisis profundo
				diagnostics = {
					enable = true,
					run = "onType", -- Análisis en tiempo real
					embeddedLanguages = true, -- SQL, HTML en PHP
					undefinedSymbols = true,
					undefinedFunctions = true,
					undefinedConstants = true,
					undefinedClassConstants = true,
					undefinedMethods = true,
					undefinedProperties = true,
					undefinedTypes = true,
					unusedSymbols = true,
					-- Severity levels
					typeErrors = "Warning",
					undefinedVariables = "Warning",
					languageConstraints = true,
					implementationErrors = true,
					duplicateSymbols = true,
				},

				-- 🎨 ENVIRONMENT
				environment = {
					includePaths = {
						-- Agrega paths personalizados si usas libs fuera de vendor
					},
					phpVersion = "10.5.0",
					shortOpenTag = false, -- Deshabilitado (deprecated)
					documentRoot = vim.fn.getcwd(),
				},

				-- 🔧 RUNTIME
				runtime = vim.fn.exepath("php") ~= "" and vim.fn.exepath("php") or nil,

				-- 📦 PHPUNIT & PEST
				phpdoc = {
					returnVoid = true,
					textFormat = "snippet",
					classTemplate = {
						summary = "$3",
						tags = {
							"@author ${3:Your Name}",
							"@package ${4:App\\\\${3:Namespace}}",
						},
					},
					functionTemplate = {
						summary = "$3",
						tags = {
							"@param ${3:$SYMBOL_TYPE} $${1:$SYMBOL_NAME} ${2:$SYMBOL_DESCRIPTION}",
							"@return ${3:$SYMBOL_TYPE} ${2:$SYMBOL_DESCRIPTION}",
							"@throws ${3:\\Exception}",
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
