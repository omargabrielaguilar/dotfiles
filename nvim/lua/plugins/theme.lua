return {
	"oxfist/night-owl.nvim",
	name = "night-owl",
	lazy = false,
	priority = 1001,
	config = function()
		require("night-owl").setup({
			transparent_background = true,
			italic = true, -- night-owl solo acepta un boolean, no tablas
			bold = true, -- igual aquí
		})

		vim.cmd.colorscheme("night-owl")

		-- Mantener floats y statusline transparentes
		local transparent_groups = {
			"Normal",
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
