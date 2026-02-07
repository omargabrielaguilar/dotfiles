return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"V13Axel/neotest-pest", -- El mejor para Pest
	},
	config = function()
		local neotest = require "neotest"

		neotest.setup {
			-- 🎨 Configuración visual
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazy.core.config").plugins["snacks.nvim"] then
						Snacks.picker.qflist() -- Si falla, ábrelo en Snacks
					else
						vim.cmd "copen"
					end
				end,
			},
			-- 🚀 Adaptadores
			adapters = {
				require "neotest-pest" {
					pest_cmd = function()
						if vim.loop.fs_stat "vendor/bin/sail" then return "vendor/bin/sail pest" end
						return "vendor/bin/pest"
					end,
					parallel = 8, -- 16 era mucho, 8 es el sweet spot para no freír la CPU
					compact = true,
				},
			},
		}

		local opts = function(desc) return { desc = desc, silent = true } end
		vim.keymap.set("n", "<leader>tn", neotest.run.run, opts "Test Nearest")
		vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand "%") end, opts "Test File")
		vim.keymap.set(
			"n",
			"<leader>to",
			function() neotest.output.open { enter = true, auto_close = true } end,
			opts "Test Output"
		)

		vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, opts "Test Summary")
		vim.keymap.set("n", "<leader>tx", neotest.run.stop, opts "Stop Test")
		vim.keymap.set("n", "<leader>tD", function()
			neotest.diagnostic.get_all()
			Snacks.picker.diagnostics()
		end, opts "Test Diagnostics")
	end,
}
