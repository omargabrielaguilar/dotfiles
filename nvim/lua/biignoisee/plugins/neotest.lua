return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-vim-test",
		"V13Axel/neotest-pest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-pest")({
					-- Ignorar carpetas comunes
					ignore_dirs = { "vendor", "node_modules" },

					-- Ignorar si detecta estos archivos (útil si mezclas PHPUnit y Pest)
					root_ignore_files = { "phpunit-only.tests" },

					-- Archivos considerados como tests
					test_file_suffixes = { "Test.php", "_test.php", "PestTest.php" },

					-- No estás usando Sail
					sail_enabled = function()
						return false
					end,

					-- Ruta del binario Pest (ajusta si estás en Docker, Sail, etc.)
					pest_cmd = "vendor/bin/pest",

					-- Ejecuta 16 pruebas en paralelo (ajusta si tu máquina se sofoca)
					parallel = 16,

					-- Desactiva el modo compacto
					compact = false,

					-- Ruta de resultados (puede omitirse si no usas CI o parsing de resultados)
					results_path = function()
						return vim.fn.tempname() -- esto genera un archivo temporal
					end,
				}),
			},
		})

		-- Keymaps 🔥
		vim.keymap.set("n", "<leader>tn", function()
			require("neotest").run.run()
		end, { desc = "Run nearest test" })

		vim.keymap.set("n", "<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Run test file" })

		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, { desc = "Toggle test summary" })
	end,
}
