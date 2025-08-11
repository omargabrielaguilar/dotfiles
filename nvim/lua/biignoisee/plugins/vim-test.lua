return {
	{
		"vim-test/vim-test",
		ft = { "php" },
		config = function()
			-- Opciones de vim-test, puedes ajustar si quieres
			vim.g["test#strategy"] = "neovim" -- corre tests en terminal integrado de Neovim
			vim.g["test#php#runner"] = "pest" -- usa pest para PHP

			-- Keymaps Alt+1..4 para vim-test
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<M-1>", ":TestNearest<CR>", opts) -- correr test cercano
			vim.api.nvim_set_keymap("n", "<M-2>", ":TestFile<CR>", opts) -- correr tests archivo actual
			vim.api.nvim_set_keymap("n", "<M-3>", ":TestSuite<CR>", opts) -- correr toda la suite
			vim.api.nvim_set_keymap("n", "<M-4>", ":TestLast<CR>", opts) -- repetir último test
		end,
	},
}
