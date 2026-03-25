return {
	"adalessa/laravel.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
	},
	ft = { "php", "blade" },
	event = { "BufEnter composer.json" },
	opts = {
		features = {
			pickers = {
				-- 🔥 Usamos Snacks ya que lo tienes instalado y vuela
				provider = "snacks",
			},
			-- Genera bloques de documentación en vendor para que Intelephense
			-- entienda tus modelos sin errores (Magia pura ✨)
			eloquent_generate_doc_blocks = true,
		},
	},
	keys = {
		-- 🚀 KEYMAPS CON LEADER L (Tu zona libre)
		{ "<leader>ll", function() Laravel.pickers.laravel() end, desc = "Laravel: Menu Principal" },
		{ "<leader>la", function() Laravel.pickers.artisan() end, desc = "Laravel: Artisan" },
		{ "<leader>lr", function() Laravel.pickers.routes() end, desc = "Laravel: Rutas" },
		{ "<leader>lm", function() Laravel.pickers.make() end, desc = "Laravel: Make" },
		{ "<leader>lt", function() Laravel.commands.run "actions" end, desc = "Laravel: Acciones" },
		{ "<leader>lc", function() Laravel.pickers.commands() end, desc = "Laravel: Comandos" },
		{ "<leader>lu", function() Laravel.commands.run "hub" end, desc = "Laravel: Hub (Serve/Logs)" },
		{ "<leader>lp", function() Laravel.commands.run "command_center" end, desc = "Laravel: Command Center" },

		-- 🧭 NAVEGACIÓN INTELIGENTE (gf mejorado)
		{
			"gf",
			function()
				if Laravel.app("gf").cursorOnResource() then
					return "<cmd>lua Laravel.commands.run('gf')<cr>"
				else
					return "gf"
				end
			end,
			expr = true,
			desc = "Laravel: Go to Resource",
		},
	},
}
