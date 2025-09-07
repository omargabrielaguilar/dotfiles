return {
	{
		"vim-test/vim-test",
		ft = { "php", "javascript", "typescript" },
		config = function()
			-- PHP
			vim.g["test#php#runner"] = "pest"

			-- JS/TS
			vim.g["test#javascript#runner"] = "jest"
			vim.g["test#typescript#runner"] = "jest"

			-- Estrategia: terminal dentro de Neovim
			vim.g["test#strategy"] = "neovim"

			-- Keymaps Alt+1..4 (funciona igual para PHP y JS/TS)
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<M-1>", ":TestNearest<CR>", opts)
			vim.api.nvim_set_keymap("n", "<M-2>", ":TestFile<CR>", opts)
			vim.api.nvim_set_keymap("n", "<M-3>", ":TestSuite<CR>", opts)
			vim.api.nvim_set_keymap("n", "<M-4>", ":TestLast<CR>", opts)
		end,
	},
}
