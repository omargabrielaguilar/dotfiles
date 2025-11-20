return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "darker", -- opciones: dark, darker, cool, deep, warm, warmer
			transparent = true, -- transparencia nativa del theme 💎
		})
		require("onedark").load()

		-- 💫 Transparencia extra por si algún highlight se pone rebelde
		local transparent_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"LineNr",
			"Folded",
			"EndOfBuffer",
			"CursorLine",
			"CursorLineNr",
			"StatusLine",
			"StatusLineNC",
			"WinBar",
			"WinBarNC",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
