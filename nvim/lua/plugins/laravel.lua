return {
	"adibhanna/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "Artisan", "Composer", "Laravel", "LaravelRoute" },
	keys = {
		-- 🚀 Navegación y Comandos Core
		{ "<leader>la", ":Artisan<cr>", desc = "Artisan" },
		{ "<leader>lc", ":Composer<cr>", desc = "Composer" },
		{ "<leader>lr", ":LaravelRoute<cr>", desc = "Ver Rutas" },
		{ "<leader>lm", ":LaravelMake<cr>", desc = "Laravel Make (Picker)" },

		-- 🐞 DUMP VIEWER (El reemplazo de Ray/Browser)
		{ "<leader>Ld", ":LaravelDumps<cr>", desc = "Abrir Dump Viewer" },
		{ "<leader>Le", ":LaravelDumpsEnable<cr>", desc = "Activar Dump Log" },
		{ "<leader>Lc", ":LaravelDumpsClear<cr>", desc = "Limpiar Dumps" },

		-- 🔍 Smart Navigation (Ir a la vista, al config, al .env, etc.)
		{
			"gd",
			function()
				require("laravel.navigate").goto_definition()
			end,
			desc = "Laravel Goto Definition",
		},
	},
	config = function()
		require("laravel").setup({
			notifications = true,
			debug = false,
			keymaps = {
				enabled = true, -- Usa los default pero nosotros añadimos los nuestros arriba
			},
			sail = {
				enabled = true,
				auto_detect = true, -- Si usas Sail, lo detecta y envuelve los comandos solo
			},
			lsp = {
				-- Esto ayuda a que el autocompletado sea instantáneo
				override_methods = true,
			},
		})
	end,
}
