-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Save file with Ctrl+S
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
	vim.cmd("silent! w")
end, { desc = "Save file" })

-- Select all with Ctrl+A
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- File Explorer
vim.keymap.set("n", "-", function()
	require("oil").open()
end, { desc = "Abrir Oil en el buffer actual" })

-- Keymap para abrir Oil en modo flotante (con Shift -)
vim.keymap.set("n", "_", function()
	require("oil").open_float()
end, { desc = "Abrir Oil en modo flotante" })

-- ================================================================================================
-- GitHub Copilot
-- ================================================================================================

-- Aceptar sugerencia de Copilot con Ctrl+L en modo Insert
vim.keymap.set("i", "<C-l>", function()
	local ok, copilot = pcall(require, "copilot.suggestion")
	if ok then
		copilot.accept()
	end
end, { desc = "Copilot: Accept suggestion" })
