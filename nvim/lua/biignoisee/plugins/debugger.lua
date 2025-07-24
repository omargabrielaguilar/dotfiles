return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- Adapter para PHP
			dap.adapters.php = {
				type = "executable",
				command = "php", -- O el path completo si no está en el PATH
				args = { "path/to/php-debug-adapter", "debug" }, -- Ajusta el path según lo que hayas configurado para php-debug-adapter
			}

			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Launch PHP Script",
					program = "${file}",
					port = 8000, -- Asegúrate de que el puerto coincida con el configurado en tu IDE o servidor
					stopOnEntry = true,
					serverSourceRoot = "${workspaceFolder}",
					localSourceRoot = "${workspaceFolder}",
				},
			}

			dap.configurations.java = {
				{
					type = "java",
					request = "attach", -- ¡IMPORTANTE! "attach" para conectar al proceso ya lanzado
					name = "Attach to Java Process",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}

			-- Auto abrir/cerrar UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps para DAP
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debug" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate Debug" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
