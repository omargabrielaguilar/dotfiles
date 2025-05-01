vim.keymap.set("v", "<", "<gv", { desc = "Indent out and keeps the selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent in and keeps the selection" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Goes to next result on the search and put the cursor in the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Goes to prev result on the search and put the cursor in the middle" })


-- Remap Ctrl-Up to behave like Ctrl-a
vim.api.nvim_set_keymap('n', '<C-Up>', '<C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Up>', '<C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-Up>', '<C-a>', { noremap = true, silent = true })

-- Remap Ctrl-Down to behave like Ctrl-x
vim.api.nvim_set_keymap('n', '<C-Down>', '<C-x>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Down>', '<C-x>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-Down>', '<C-x>', { noremap = true, silent = true })
