return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,

			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},

			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			inverse = true,

			contrast = "hard", -- CLAVE: gruvbox hard
			dim_inactive = false,
			transparent_mode = true, -- CLAVE: transparencia nativa
		})

		-- MUY IMPORTANTE: después del setup
		vim.cmd.colorscheme("gruvbox")

		-- 🔎 Fuerza transparencia (anti plugins)
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

			-- Telescope
			"TelescopeNormal",
			"TelescopeBorder",

			-- File trees
			"NvimTreeNormal",
			"NvimTreeNormalNC",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
