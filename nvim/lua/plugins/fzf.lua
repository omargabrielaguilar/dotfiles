-- ==========================================
-- Fzf-lua CONFIG (MAXIMIZED)
-- ==========================================
local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		-- Un diseño un poco más limpio y amplio para leer código
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.50,
		preview = {
			layout = "flex",
			flip_columns = 120, -- Cambia a horizontal si la pantalla es muy estrecha
		},
	},
})

-- ----------------------------------------------------------------------------
-- 1. BÚSQUEDA CORE (Tus atajos mejorados)
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", fzf.colorschemes, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })

-- Reabrir la última búsqueda de fzf (¡salva vidas!)
vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Resume Last FZF" })

-- ----------------------------------------------------------------------------
-- 2. LSP (Navegación Backend)
-- Moverse rápido por arquitecturas robustas sin perderse
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ld", fzf.lsp_definitions, { desc = "Goto Definition" })
vim.keymap.set("n", "<leader>lr", fzf.lsp_references, { desc = "Goto References" })
vim.keymap.set("n", "<leader>li", fzf.lsp_implementations, { desc = "Goto Implementation" })
-- Buscar métodos, structs y clases en el archivo actual
vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, { desc = "Document Symbols" })
-- Buscar en todo el workspace (ideal para encontrar ese servicio perdido)
vim.keymap.set("n", "<leader>lS", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })
vim.keymap.set("n", "<leader>lx", fzf.diagnostics_document, { desc = "Diagnostics Document" })
vim.keymap.set("n", "<leader>lX", fzf.diagnostics_workspace, { desc = "Diagnostics Workspace" })

-- ----------------------------------------------------------------------------
-- 3. GIT (Complemento para gitsigns/lazygit)
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "Git Files" })
-- Ver qué has modificado y hacer saltos rápidos
vim.keymap.set("n", "<leader>gs", fzf.git_status, { desc = "Git Status" })
-- Buscar en el historial de commits
vim.keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "Git Commits" })

-- ----------------------------------------------------------------------------
-- 4. HERRAMIENTAS DE NEOVIM
-- ----------------------------------------------------------------------------
-- Buscar atajos de teclado (por si olvidas cómo mapeaste algo)
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
-- Buscar en tus registros (yanks, deletes pasados) para pegar rápido
vim.keymap.set("n", '<leader>f"', fzf.registers, { desc = "Registers" })
-- Buscar comandos y volver a ejecutarlos
vim.keymap.set("n", "<leader>f:", fzf.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>f/", fzf.search_history, { desc = "Search History" })
