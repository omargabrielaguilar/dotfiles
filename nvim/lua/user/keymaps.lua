-- Space is my leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")

-- Disable annoying command line typo.
vim.keymap.set("n", "q:", ":q")

-- Paste replace visual selection without copying it.
vim.keymap.set("v", "p", '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set("i", ";;", "<Esc>A;")
vim.keymap.set("i", ",,", "<Esc>A,")

-- Quickly clear search highlighting.
vim.keymap.set("n", "<Leader>k", ":nohlsearch<CR>")

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set("n", "<Leader>x", ":!xdg-open %<CR><CR>")

-- Move lines up and down.
vim.keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi")
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")

vim.schedule(function()
	vim.keymap.set("n", "zz", function()
		vim.cmd("silent! write")
		vim.cmd("silent! bdelete!")
	end, { noremap = true, silent = true })
end)

vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- vsplit hsplit
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { noremap = true, silent = true })

-- Dividir ventanas
vim.keymap.set("n", "<C-S-Right>", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Left>", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Up>", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Down>", ":split<CR>", { noremap = true, silent = true })

--bufferline
vim.api.nvim_set_keymap("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
