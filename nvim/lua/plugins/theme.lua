return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true

		require("onedark").setup({
			style = "darker", -- "dark" | "darker" | "cool" | "deep" | "warm" | "warmer"
			transparent = true,
			code_style = {
				comments = "italic",
				keywords = "italic",
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

		require("onedark").load()

		-- 🔎 Fuerza transparencia (anti plugins que pisan bg)
		local transparent_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"LineNr",
			"CursorLineNr",
			"MsgArea",
			"StatusLine",
			"StatusLineNC",

			-- Snacks / floating UI
			"SnacksNotifier",
			"SnacksNotifierBorder",

			-- Telescope / Pickers
			"TelescopeNormal",
			"TelescopeBorder",

			-- File explorers
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"OilFloat",

			-- Popup menus
			"Pmenu",
			"PmenuSel",
			"PmenuThumb",
			"PmenuSbar",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
