return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "moon",
			transparent = true, -- Esto ya hace la mayoría del trabajo
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(hl, c)
				hl.Normal = { fg = c.fg, bg = "none" }
				hl.NormalNC = { fg = c.fg, bg = "none" }
				hl.NormalFloat = { fg = c.fg, bg = "none" }
				hl.FloatBorder = { fg = c.border_highlight, bg = "none" }
				hl.StatusLine = { fg = c.fg_sidebar, bg = "none" }
				hl.StatusLineNC = { fg = c.fg_gutter, bg = "none" }
				hl.SignColumn = { bg = "none" }
				hl.MsgArea = { bg = "none" }
				-- Esto hace que la sugerencia de Copilot parezca un comentario sutil e inclinado
				hl.CopilotSuggestion = { fg = "#565f89", italic = true }
				hl.Pmenu = { fg = c.fg, bg = "none" }
			end,
		})

		vim.cmd.colorscheme("tokyonight-moon")
	end,
}
