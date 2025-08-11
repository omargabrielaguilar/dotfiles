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
					root_ignore_files = {},
					test_file_suffixes = { "php" }, -- acepta todos los php
					sail_enabled = function()
						return false
					end,
					pest_cmd = function()
						-- Pest con flag para output junit en ruta accesible
						local cwd = vim.fn.getcwd()
						return { "vendor/bin/pest", "--log-junit=" .. cwd .. "/storage/logs/pest-results.xml" }
					end,
					results_path = function()
						return vim.fn.getcwd() .. "/storage/logs/pest-results.xml"
					end,
					parallel = 16,
					compact = false,
				}),
			},
			output = {
				enabled = true,
				open_on_run = "short",
			},
		})

		-- Keymaps para correr tests
		vim.keymap.set("n", "<M-1>", function()
			neotest.run.run() -- nearest test
		end, { desc = "Run nearest test" })

		vim.keymap.set("n", "<M-2>", function()
			neotest.run.run(vim.fn.expand("%")) -- test del archivo actual
		end, { desc = "Run current test file" })

		vim.keymap.set("n", "<M-3>", function()
			neotest.run.run({ suite = true }) -- suite completa
		end, { desc = "Run full test suite" })

		vim.keymap.set("n", "<M-4>", function()
			neotest.output.open({ enter = true }) -- abrir output
		end, { desc = "Open last test output" })
	end,
}
