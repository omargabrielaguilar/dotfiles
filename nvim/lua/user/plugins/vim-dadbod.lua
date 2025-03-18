vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui_queries"

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_help = 0

vim.keymap.set("n", "<leader>db", ":DBUI<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dc", ":DBUIClose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dq", ":DBUIToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dr", ":DBUIRenameBuffer<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
