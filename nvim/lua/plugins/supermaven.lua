return {
	"supermaven-inc/supermaven-nvim",
	-- Borramos la línea de 'event = "InsertEnter"' para que arranque de una
	config = function()
		require("supermaven-nvim").setup {
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			color = {
				suggestion_color = "#8aaa3d",
				cterm = 244,
			},
		}
	end,
}
