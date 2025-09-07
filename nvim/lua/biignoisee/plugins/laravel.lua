return {
	"adibhanna/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter", -- navegación inteligente
	},
	event = "VeryLazy",
	keys = {
		-- Core Laravel
		{ "<leader>va", ":Artisan<cr>", desc = "Laravel Artisan" },
		{ "<leader>vc", ":Composer<cr>", desc = "Composer" },
		{ "<leader>vr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
		{ "<leader>vm", ":LaravelMake<cr>", desc = "Laravel Make" },

		-- Dumps
		{ "<leader>Ld", ":LaravelDumps<cr>", desc = "Laravel Dump Viewer" },
		{ "<leader>LDe", ":LaravelDumpsEnable<cr>", desc = "Enable Dumps" },
		{ "<leader>LDt", ":LaravelDumpsToggle<cr>", desc = "Toggle Dumps" },
		{ "<leader>LDc", ":LaravelDumpsClear<cr>", desc = "Clear Dumps" },
	},
	config = function()
		require("laravel").setup({
			features = {
				-- 🔍 Navegación inteligente (views, routes, configs, controllers, etc.)
				navigation = true,
				-- ⚡ Autocompletado (routes, views, configs, envs, translations)
				autocomplete = true,
				-- 📦 Artisan / Composer / Sail integration
				artisan = true,
				composer = true,
				sail = true,
				-- 🗺️ Route visualization
				routes = true,
				-- 🔥 Dump viewer
				dumps = true,
			},
			dumps = {
				auto_enable = true, -- activa captura automáticamente
				notify = true, -- notifica cuando recibe dump
			},
		})
	end,
}
