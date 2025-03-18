require("ibl").setup {
    indent = { char = "│" },  -- Sin colores, solo líneas de indentación
    scope = { enabled = false }, -- Desactiva el resaltado de scopes si no lo quieres
    exclude = {
        filetypes = {
            'help',
            'terminal',
            'dashboard',
            'packer',
            'lspinfo',
            'TelescopePrompt',
            'TelescopeResults',
        },
        buftypes = { 'terminal', 'NvimTree' },
    },
}

