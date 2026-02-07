return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1501,
	config = function()
		require("tokyonight").setup {
			style = "moon",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		}

		vim.cmd.colorscheme "tokyonight-moon"

		-- 🌙 Transparencia global segura
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
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"OilFloat",
			"Pmenu",
			"PmenuThumb",
			"PmenuSbar",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
