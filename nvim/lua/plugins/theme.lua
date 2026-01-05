return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1001,
	config = function()
		require("onedark").setup({
			style = "dark", -- dark > darker para contrast clean
			transparent = true, -- CLAVE
			term_colors = true,

			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},

			diagnostics = {
				darker = true,
				undercurl = true,
				background = false,
			},
		})

		vim.cmd.colorscheme("onedark")

		-- 🔎 Fuerza background NONE (por si algún plugin se pone pesado)
		local transparent_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"LineNr",
			"CursorLine",
			"CursorLineNr",
			"MsgArea",
			"StatusLine",
			"StatusLineNC",
			"TelescopeNormal",
			"TelescopeBorder",
			"NvimTreeNormal",
			"NvimTreeNormalNC",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
