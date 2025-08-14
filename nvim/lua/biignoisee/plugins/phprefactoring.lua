return {
	"adibhanna/phprefactoring.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	ft = "php",
	config = function()
		require("phprefactoring").setup({
			-- UI Configuration
			ui = {
				use_floating_menu = true, -- Use floating windows for dialogs
				border = "rounded", -- Border style: 'rounded', 'single', 'double'
				width = 40, -- Dialog width
				height = nil, -- Auto-calculated height
				highlights = {
					menu_title = "Title",
					menu_border = "FloatBorder",
					menu_item = "Normal",
					menu_selected = "PmenuSel",
					menu_shortcut = "Comment",
				},
			},

			-- Refactoring Options
			refactor = {
				auto_format = true, -- Auto-format after refactoring
			},
		})

		-- 🔹 Keymaps
		vim.keymap.set("v", "<leader>rv", "<cmd>PHPExtractVariable<cr>", { desc = "Extract variable" })
		vim.keymap.set("v", "<leader>rm", "<cmd>PHPExtractMethod<cr>", { desc = "Extract method" })
		vim.keymap.set("v", "<leader>rc", "<cmd>PHPExtractClass<cr>", { desc = "Extract class" })
		vim.keymap.set("n", "<leader>ri", "<cmd>PHPExtractInterface<cr>", { desc = "Extract interface" })
		vim.keymap.set("n", "<leader>ic", "<cmd>PHPIntroduceConstant<cr>", { desc = "Introduce constant" })
		vim.keymap.set("n", "<leader>if", "<cmd>PHPIntroduceField<cr>", { desc = "Introduce field" })
		vim.keymap.set("n", "<leader>ip", "<cmd>PHPIntroduceParameter<cr>", { desc = "Introduce parameter" })
		vim.keymap.set("n", "<leader>cs", "<cmd>PHPChangeSignature<cr>", { desc = "Change signature" })
		vim.keymap.set("n", "<leader>pm", "<cmd>PHPPullMembersUp<cr>", { desc = "Pull members up" })
	end,
}
