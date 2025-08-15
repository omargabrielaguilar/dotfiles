return {
	"adibhanna/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>va", ":Artisan<cr>", desc = "Laravel Artisan" },
		{ "<leader>vc", ":Composer<cr>", desc = "Composer" },
		{ "<leader>vr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
		{ "<leader>vm", ":LaravelMake<cr>", desc = "Laravel Make" },
	},
	config = function()
		require("laravel").setup()
	end,
}
