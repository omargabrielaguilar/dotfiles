return {
	"adibhanna/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = {
		"Artisan",
		"Composer",
		"LaravelRoute",
		"LaravelMake",
		"LaravelStatus",
	},
	keys = {
		{ "<leader>la", ":Artisan<cr>", desc = "Laravel: Artisan" },
		{ "<leader>lc", ":Composer<cr>", desc = "Laravel: Composer" },
		{ "<leader>lr", ":LaravelRoute<cr>", desc = "Laravel: Routes" },
		{ "<leader>lm", ":LaravelMake<cr>", desc = "Laravel: Make Something" },
		{ "<leader>ls", ":LaravelStatus<cr>", desc = "Laravel: Status" },

		-- Dump viewer
		{ "<leader>Ld", ":LaravelDumps<cr>", desc = "Laravel: Dump Viewer" },
		{ "<leader>LDe", ":LaravelDumpsEnable<cr>", desc = "Laravel: Enable Dumps" },
		{ "<leader>LDd", ":LaravelDumpsDisable<cr>", desc = "Laravel: Disable Dumps" },
		{ "<leader>LDt", ":LaravelDumpsToggle<cr>", desc = "Laravel: Toggle Dumps" },
		{ "<leader>LDc", ":LaravelDumpsClear<cr>", desc = "Laravel: Clear Dumps" },
	},
	event = "VeryLazy",

	config = function()
		require("laravel").setup({
			notifications = true,
			debug = false,

			sail = {
				enabled = true,
				auto_detect = true,
			},
		})
	end,
}
