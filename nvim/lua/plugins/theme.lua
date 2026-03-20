return {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Configuración de Nord antes de cargar el colorscheme
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = true -- Activa transparencia nativa
        vim.g.nord_italic = true

        require("nord").set()

        -- Forzamos transparencia en elementos específicos (como hacias en tokyonight)
        local hl = vim.api.nvim_set_hl
        local c = {
            nord_blue = "#81A1C1",
            nord_gray = "#4C566A",
            nord_fg = "#D8DEE9",
        }

        -- Aplicamos los overrides de transparencia y estilos
        hl(0, "Normal", { bg = "none", fg = "none" })
        hl(0, "NormalNC", { bg = "none", fg = "none" })
        hl(0, "NormalFloat", { bg = "none", fg = "none" })
        hl(0, "FloatBorder", { bg = "none", fg = c.nord_blue })
        hl(0, "Pmenu", { bg = "none", fg = "none" })
        hl(0, "SignColumn", { bg = "none" })
        hl(0, "MsgArea", { bg = "none" })
        
        -- Estilo para Copilot (Gris azulado, itálico)
        hl(0, "CopilotSuggestion", { fg = c.nord_gray, italic = true })
        
        -- StatusLine transparente
        hl(0, "StatusLine", { bg = "none", fg = c.nord_fg })
        hl(0, "StatusLineNC", { bg = "none", fg = c.nord_gray })
    end,
}
