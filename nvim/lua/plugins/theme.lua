return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { light = "latte", dark = "mocha" },
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				functions = { "bold" },
				keywords = { "bold" },
				loops = {},
				numbers = {},
				booleans = { "bold" },
				strings = {},
				types = { "bold" },
				operators = {},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				treesitter = true,
				notify = true,
				mini = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")

		-- opcional: resetea fondo de ciertas ventanas para que Snack quede piola
		local transparent_groups = {
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"LineNr",
			"CursorLine",
			"CursorLineNr",
			"StatusLine",
			"StatusLineNC",
		}
		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
