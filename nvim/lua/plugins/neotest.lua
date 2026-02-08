return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"V13Axel/neotest-pest",
	},
	config = function()
		local neotest = require "neotest"

		neotest.setup {
			adapters = {
				require "neotest-pest" {
					-- Ruta a pest (puede ser relativa o usar una función)
					pest_cmd = function() return vim.fn.getcwd() .. "/vendor/bin/pest" end,
					-- Patrón para encontrar archivos de test
					root_files = { "composer.json", "phpunit.xml", "tests" },
					-- Directorio donde están los tests
					filter_dirs = { "vendor" },
				},
			},
			status = {
				virtual_text = true,
				signs = true,
			},
			output = {
				enabled = true,
				open_on_run = true,
			},
			quickfix = {
				open = false,
			},
			-- Importante para debugging
			log_level = vim.log.levels.DEBUG,
		}

		-- Keymaps mejorados
		vim.keymap.set("n", "<leader>tn", function() neotest.run.run() end, { desc = "Test Nearest" })

		vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand "%") end, { desc = "Test File" })

		vim.keymap.set("n", "<leader>td", function() neotest.run.run { strategy = "dap" } end, { desc = "Debug Test" })

		vim.keymap.set(
			"n",
			"<leader>to",
			function() neotest.output.open { enter = true, auto_close = true } end,
			{ desc = "Test Output" }
		)

		vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Test Summary" })

		vim.keymap.set("n", "<leader>tp", function() neotest.output_panel.toggle() end, { desc = "Test Output Panel" })
	end,
}
