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

		vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Test nearest" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Test file" })
		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.run({ suite = true })
		end, { desc = "Test suite" })
		vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Test output" })
		vim.keymap.set("n", "<leader>tp", neotest.summary.toggle, { desc = "Test panel" })
	end,
}
