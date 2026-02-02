local M = {}

M.setup = function()
	local dap, dapui = require("dap"), require("dapui")

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	local map = vim.keymap.set
	local opts = { noremap = true, silent = true }

	map("n", "<leader>ac", dap.continue, { desc = "Debug: Continue / Start", silent = true })
	map("n", "<leader>ab", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint", silent = true })
	map("n", "<leader>ao", dap.step_over, { desc = "Debug: Step Over", silent = true })
	map("n", "<leader>ai", dap.step_into, { desc = "Debug: Step Into", silent = true })
	map("n", "<leader>aO", dap.step_out, { desc = "Debug: Step Out", silent = true })
	map("n", "<leader>ar", dap.repl.open, { desc = "Debug: Open REPL", silent = true })
	map("n", "<leader>al", dap.run_last, { desc = "Debug: Run Last", silent = true })
	map("n", "<leader>aq", dap.terminate, { desc = "Debug: Terminate Session", silent = true })
end

return M
