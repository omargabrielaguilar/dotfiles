return {
	"adalessa/laravel.nvim",

	enabled = true,

	dependencies = {
		"tpope/vim-dotenv",
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"kevinhwang91/promise-async",
	},

	cmd = { "Laravel" },
	event = { "VeryLazy" },
	opts = {
		lsp_server = "phpactor",
		features = {
			route_info = { enable = true, view = "top" },
			model_info = { enable = true },
			override = { enable = true },
			pickers = { enable = true, provider = "telescope" },
		},
	},

	config = function(_, opts)
		local laravel = require("laravel")
		laravel.setup(opts)

		vim.keymap.set("n", "<leader>va", ":Laravel artisan<CR>", { desc = "Laravel Artisan" })
		vim.keymap.set("n", "<leader>vr", ":Laravel routes<CR>", { desc = "Laravel Routes" })
		vim.keymap.set("n", "<leader>vm", ":Laravel related<CR>", { desc = "Laravel Related" })
		vim.keymap.set("n", "<leader>vt", ":Laravel tinker<CR>", { desc = "Laravel Tinker" })
		vim.keymap.set("n", "<leader>vv", ":Laravel view<CR>", { desc = "Laravel View" })
	end,
}
