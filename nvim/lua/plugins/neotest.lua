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
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-pest")({
					ignore_dirs = { "vendor", "node_modules" },
					root_ignore_files = { "phpunit-only.tests" },
					test_file_suffixes = { "Test.php", "_test.php", "PestTest.php" },
					sail_enabled = function()
						return false
					end,
					sail_executable = "vendor/bin/sail",
					sail_project_path = "/var/www/html",
					pest_cmd = "vendor/bin/pest",
					parallel = 16,
					compact = false,
					results_path = function()
						return "/tmp/neotest-pest-" .. math.random(100000) .. ".xml"
					end,
				}),
			},
		})

		vim.keymap.set("n", "<leader>tn", function()
			require("neotest").run.run()
		end)
	end,
}
