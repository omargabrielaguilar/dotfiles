return {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nord_disable_background = true -- clave para transparencia
		vim.g.nord_borders = false

		require("nord").set()

		-- Overrides manuales para dejar TODO limpio y transparente
		local hl = vim.api.nvim_set_hl
		local c = require "nord.colors"

		hl(0, "Normal", { fg = c.nord6, bg = "none" })
		hl(0, "NormalNC", { fg = c.nord6, bg = "none" })
		hl(0, "NormalFloat", { fg = c.nord6, bg = "none" })
		hl(0, "FloatBorder", { fg = c.nord3, bg = "none" })

		hl(0, "StatusLine", { fg = c.nord4, bg = "none" })
		hl(0, "StatusLineNC", { fg = c.nord3, bg = "none" })

		hl(0, "SignColumn", { bg = "none" })
		hl(0, "MsgArea", { bg = "none" })

		hl(0, "Pmenu", { fg = c.nord6, bg = "none" })

		-- Copilot ghost text estilo elegante
		hl(0, "CopilotSuggestion", { fg = "#4c566a", italic = true })
	end,
}
