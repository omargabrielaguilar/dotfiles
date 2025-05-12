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
                -- Buffer local mappings
                -- Check `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- keymaps
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })


        -- NOTE : Moved all this to Mason including local variables
        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        -- Change the Diagnostic symbols in the sign column (gutter)

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- Enable signs in the gutter
            },
            virtual_text = true,  -- Specify Enable virtual text for diagnostics
            underline = true,     -- Specify Underline diagnostics
            update_in_insert = false,  -- Keep diagnostics active in insert mode
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
        -- emmet_ls
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })

        -- emmet_language_server
        lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            init_options = {
                includeLanguages = {},
                excludeLanguages = {},
                extensionsPath = {},
                preferences = {},
                showAbbreviationSuggestions = true,
                showExpandedAbbreviation = "always",
                showSuggestionsAsSnippets = false,
                syntaxProfiles = {},
                variables = {},
            },
        })

        -- denols
        lspconfig.denols.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        })

        -- gopls (Golang)
       lspconfig.gopls.setup({
            capabilities = capabilities,
            root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    gofumpt = true,            -- Usa gofumpt para formato más estricto (mejor estilo)
                    staticcheck = true,       -- Activa análisis estático (como golangci-lint)
                    usePlaceholders = true,   -- Autocompletado con placeholders
                    completeUnimported = true, -- Completa paquetes no importados

                    analyses = {
                        unusedparams = true,
                        fieldalignment = true, -- Sugiere alinear structs para optimizar memoria
                        nilness = true,
                        shadow = true,         -- Detecta variables sombreadas (evita bugs)
                        unusedwrite = true,
                        useany = true,
                    },

                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },

                    codelenses = {
                        generate = true,       -- `go generate` lens
                        gc_details = true,     -- detalles de recolección de basura
                        tidy = true,           -- auto `go mod tidy`
                        upgrade_dependency = true,
                        vendor = true,
                    },

                    buildFlags = { "-tags=integration" }, -- agrega tags personalizados si usas test especiales
                },
            },
        })

        -- intelephense (PHP)
        lspconfig.intelephense.setup({
            capabilities = capabilities,
            settings = {
                intelephense = {
                    -- 🔑 Tu clave de licencia
                    licenceKey = "00D0IEADQVBNA0K", -- 🔁 Reemplaza esto con tu key real (sin espacios)

                    environment = {
                        includePaths = {
                            "/usr/include/php", -- por si trabajas con libs del sistema
                        },
                    },

                    files = {
                        maxSize = 5000000, -- permite archivos grandes
                        associations = { "*.php", "*.inc" },
                        exclude = {
                            "**/.git/**",
                            "**/node_modules/**",
                            "**/vendor/**/{Test,test,Tests,tests}/**",
                        },
                    },

                    stubs = {
                        "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core",
                        "ctype", "curl", "date", "dba", "dom", "enchant", "exif", "FFI",
                        "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash",
                        "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring",
                        "meta", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre",
                        "PDO", "pdo_mysql", "pdo_sqlite", "Phar", "posix", "readline",
                        "Reflection", "session", "SimpleXML", "soap", "sockets", "sodium",
                        "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem",
                        "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc",
                        "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                    },

                    diagnostics = {
                        enable = true,
                        undefinedTypes = true,
                        undefinedFunctions = true,
                        undefinedConstants = true,
                        undefinedVariables = true,
                    },

                    format = {
                        enable = true, -- usa el formateador interno de intelephense
                    },

                    telemetry = {
                        enabled = false,
                    },
                },
            },
        })

        -- pyright (Python)
        lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoImportCompletions = true, -- autocompletado de imports
                        autoSearchPaths = true,       -- busca automáticamente los paths correctos
                        diagnosticMode = "workspace", -- analiza todo el workspace, no solo el buffer abierto
                        typeCheckingMode = "strict",  -- ⚠️ Cambia a "basic" si es muy estricto para tu proyecto
                        useLibraryCodeForTypes = true, -- usa código de libs para entender mejor los tipos
                        logLevel = "Information",      -- puedes cambiar a "Trace" si estás debuggeando

                        diagnosticSeverityOverrides = {
                            reportMissingImports = "warning",
                            reportMissingTypeStubs = "none",
                            reportUndefinedVariable = "error",
                            reportUnboundVariable = "error",
                            reportGeneralTypeIssues = "warning",
                        },
                    },
                    venvPath = vim.fn.expand("~/.virtualenvs"), -- si usas virtualenvwrapper o poetry
                },
            },
            root_dir = require("lspconfig").util.root_pattern(
                "pyrightconfig.json",
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                ".git"
            ),
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
