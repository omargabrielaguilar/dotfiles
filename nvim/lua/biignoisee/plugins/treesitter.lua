return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },

                -- ensure these languages parsers are installed
                ensure_installed = {
                    "json",
                    "javascript",
                    "typescript",
                    "tsx",
                    "go",
                    "yaml",
                    "html",
                    "css",
                    "python",
                    "php",
                    "http",
                    "prisma",
                    "markdown",
                    "markdown_inline",
                    "svelte",
                    "graphql",
                    "bash",
                    "blade",         -- para Blade templates de Laravel
                    "toml",          -- por si usas tools modernas (como Deno, cargo, etc.)
                    "phpdoc",        -- para documentación PHP
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                    "query",
                    "vimdoc",
                    "c",
                    "java",
                    "rust",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                    },
                },
                additional_vim_regex_highlighting = false,
            })
        end,
    },
    -- NOTE: js,ts,jsx,tsx Auto Close Tags
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "xml",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "php",           -- para Laravel / Blade
            "blade",         -- Blade syntax
            "python",        -- aunque no usa tags, puede estar ahí por si acaso
            "go",            -- mismo caso, pero lo puedes quitar si no te sirve
        },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false,
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true,
                    },
                    ["typescriptreact"] = {
                        enable_close = true,
                    },
                    ["php"] = {
                        enable_close = true,
                    },
                    ["blade"] = {
                        enable_close = true,
                    },
                    ["go"] = {
                        enable_close = false, -- set false si ves problemas
                    },
                    ["python"] = {
                        enable_close = false, -- set false si ves problemas
                    },
                },
            })
        end,
    }

}
