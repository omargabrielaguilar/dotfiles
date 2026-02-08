return {
	"adalessa/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"folke/snacks.nvim", -- Aseguramos que snacks esté ahí
	},
	-- Quitamos el event para que no dé problemas, lazy.nvim lo cargará por los keys
	ft = { "php", "blade" },
	opts = {
		features = {
			pickers = {
				provider = "snacks",
			},
		},
	},
	keys = {
		-- 🚀 ARTISAN & PICKERS (Usamos la API de Snacks directamente donde se puede)
		{
			"<leader>la",
			function()
				require("laravel").pickers.artisan()
			end,
			desc = "Laravel: Artisan",
		},
		{
			"<leader>lr",
			function()
				require("laravel").pickers.routes()
			end,
			desc = "Laravel: Routes",
		},
		{
			"<leader>lm",
			function()
				require("laravel").pickers.make()
			end,
			desc = "Laravel: Make",
		},
		{
			"<leader>lo",
			function()
				require("laravel").pickers.resources()
			end,
			desc = "Laravel: Resources",
		},

		-- 🧠 INTELIGENCIA & HUB
		-- Nota: Usamos require interno para que no explote si el plugin no cargó
		{
			"<leader>ll",
			function()
				require("laravel").pickers.laravel()
			end,
			desc = "Laravel: Main Picker",
		},
		{
			"<leader>lt",
			function()
				require("laravel").commands.run("actions")
			end,
			desc = "Laravel: Actions",
		},
		{
			"<leader>lp",
			function()
				require("laravel").commands.run("command_center")
			end,
			desc = "Laravel: Command Center",
		},
		{
			"<leader>lu",
			function()
				require("laravel").commands.run("hub")
			end,
			desc = "Laravel: Artisan Hub 🐐",
		},

		-- 📂 NAVEGACIÓN
		{
			"<leader>lv",
			function()
				require("laravel").commands.run("view:finder")
			end,
			desc = "Laravel: View Finder",
		},
		{
			"gf",
			function()
				-- Esta lógica es la única que necesita pcall por seguridad
				local ok, laravel = pcall(require, "laravel")
				if ok and laravel.app("gf").cursorOnResource() then
					laravel.commands.run("gf")
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gf", true, false, true), "n", false)
				end
			end,
			desc = "Laravel: Smart GF",
		},
	},
}
