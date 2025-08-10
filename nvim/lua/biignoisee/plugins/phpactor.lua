-- plugins/phpactor.lua
return {
	"phpactor/phpactor",
	build = "composer install --no-dev -o",
	ft = "php",
	config = function()
		local keymap = vim.keymap.set
		local opts = { silent = true, buffer = 0 }

		-- Phpactor comandos extra
		keymap("n", "<leader>pi", ":PhpactorImportClass<CR>", { desc = "Phpactor: Import Class", unpack(opts) })
		keymap("n", "<leader>pc", ":PhpactorClassNew<CR>", { desc = "Phpactor: Class New", unpack(opts) })
		keymap("n", "<leader>pt", ":PhpactorTransform<CR>", { desc = "Phpactor: Transform", unpack(opts) })
		keymap("n", "<leader>pm", ":PhpactorContextMenu<CR>", { desc = "Phpactor: Context Menu", unpack(opts) })
		keymap("n", "<leader>po", ":PhpactorGotoDefinition<CR>", { desc = "Phpactor: Goto Definition", unpack(opts) })
	end,
}
