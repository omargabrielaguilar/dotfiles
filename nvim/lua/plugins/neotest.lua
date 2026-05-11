-- ==================================================================================
--  NEOTEST CONFIG
-- ==================================================================================
local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-go"),
	},
})

vim.keymap.set("n", "<leader>tt", function()
	neotest.run.run()
end, { desc = "Run nearest test" })

vim.keymap.set("n", "<leader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })

vim.keymap.set("n", "<leader>tb", function()
	neotest.run.run({ strategy = "dap" })
end, { desc = "Debug test" })

vim.keymap.set("n", "<leader>ts", function()
	neotest.summary.toggle()
end, { desc = "Test summary" })

vim.keymap.set("n", "<leader>to", function()
	neotest.output.open({ enter = true })
end, { desc = "Test output" })

vim.keymap.set("n", "<leader>tO", function()
	neotest.output_panel.toggle()
end, { desc = "Output panel" })

vim.keymap.set("n", "<leader>tr", function()
	neotest.run.stop()
end, { desc = "Stop test" })
