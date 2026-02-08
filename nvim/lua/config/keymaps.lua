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
vim.keymap.set("n", "<leader>st", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +3<CR>", { desc = "Increase window height" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Save file with Ctrl+S
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function() vim.cmd "silent! w" end, { desc = "Save file" })

-- Select all with Ctrl+A
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- File Explorer
vim.keymap.set("n", "-", function() require("oil").open() end, { desc = "Abrir Oil en el buffer actual" })

-- Keymap para abrir Oil en modo flotante (con Shift -)
vim.keymap.set("n", "_", function() require("oil").open_float() end, { desc = "Abrir Oil en modo flotante" })

-- Window navigation (simple)
vim.keymap.set("n", "<M0>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<M-2>", "<C-w>l", { desc = "Window right" })

-- ===============================================================================================
-- Fold - unfold
-- ===============================================================================================
vim.keymap.set("n", "<leader>k", "za", { desc = "Toggle fold" })

-- ================================================================================================
-- 🚀 Keymap: Copiar Relative Path
-- ================================================================================================
vim.keymap.set("n", "<leader>cr", function()
	local path = vim.fn.expand "%:." -- El punto (.) lo hace relativo al root de tu proyecto
	vim.fn.setreg("+", path) -- Lo guarda en el clipboard del sistema (+)
	vim.notify('Copiado: "' .. path .. '"', vim.log.levels.INFO, { title = "Path Relativo" })
end, { desc = "Copiar ruta relativa del archivo" })

-- ================================================================================================
-- 🧹 Limpieza visual con Esc
-- ================================================================================================
-- Al presionar Esc en modo normal: limpia búsqueda, quita notificaciones de Snacks y cierra floats
vim.keymap.set("n", "<Esc>", function()
	vim.cmd "noh"
	Snacks.notifier.hide()
	return "<Esc>"
end, { expr = true, desc = "Limpiar búsqueda y notificaciones" })

-- ================================================================================================
-- 🪟 Navegación de ventanas (Corregida)
-- ================================================================================================
-- Window navigation (simple)
vim.keymap.set("n", "<M-1>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<M-2>", "<C-w>l", { desc = "Window right" })

-- ================================================================================================
-- 📋 Movimiento de bloques (Calidad de vida PRO)
-- ================================================================================================
-- Mueve líneas seleccionadas hacia arriba o abajo con Alt + j/k (como en VS Code)
vim.keymap.set("v", "J", ":m '>+2<CR>gv=gv", { desc = "Mover bloque abajo" })
vim.keymap.set("v", "K", ":m '<-1<CR>gv=gv", { desc = "Mover bloque arriba" })
