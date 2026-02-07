-- ================================================================================================
-- TITLE : options.lua
-- ABOUT : Configuración nativa optimizada para Snacks, Oil y agilidad pura.
-- ================================================================================================

-- 🛠️ UI & Visuals
vim.opt.number = true -- Números de línea
vim.opt.relativenumber = true -- Números relativos (clave para saltos rápidos)
vim.opt.cursorline = true -- Resaltar línea actual
vim.opt.termguicolors = true -- Colores de 24 bits
vim.opt.signcolumn = "yes" -- Evita saltos de la columna de signos
vim.opt.showmode = false -- No mostrar mode (Lualine ya lo hace)
vim.opt.laststatus = 3 -- Barra de estado global (más moderno)
vim.opt.cmdheight = 0 -- Oculta la línea de comandos cuando no se usa (limpieza total)

-- 🧠 Comportamiento de Edición
vim.opt.scrolloff = 10 -- Mantiene el cursor centrado
vim.opt.sidescrolloff = 8
vim.opt.wrap = false -- No romper líneas
vim.opt.smartindent = true -- Indentación inteligente
vim.opt.expandtab = true -- Espacios en vez de Tabs
vim.opt.shiftwidth = 2 -- Tamaño de indentación
vim.opt.tabstop = 2
vim.opt.mouse = "a" -- Mouse habilitado (útil para el Statuscolumn de Snacks)
vim.opt.clipboard = "unnamedplus" -- Clipboard del sistema
vim.opt.updatetime = 250 -- Respuesta más rápida del LSP y Git
vim.opt.timeoutlen = 400 -- Menos espera para completar keymaps

-- 🔍 Búsqueda
vim.opt.ignorecase = true -- Ignorar mayúsculas
vim.opt.smartcase = true -- ...a menos que busques con una mayúscula
vim.opt.hlsearch = false -- Limpia el resaltado automáticamente
vim.opt.incsearch = true -- Salta al resultado mientras escribes

-- 📂 Archivos y Undo (Persistencia)
vim.opt.undofile = true -- Mantiene el historial de cambios tras cerrar
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- 📂 Configuración de Undo Dir (Auto-creado)
local undodir = vim.fn.stdpath "data" .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, "p") end
vim.opt.undodir = undodir

-- 📦 Splits y Ventanas
vim.opt.splitbelow = true -- Splits horizontales abajo
vim.opt.splitright = true -- Splits verticales a la derecha

-- 🍿 Snacks & Modern Folds (Optimizado para Statuscolumn)
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ⌨️ Cursor (Block everywhere, estilo Bromley: Sólido)
vim.opt.guicursor = "n-v-c-i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"

-- 🚀 Performance
vim.opt.lazyredraw = false -- En Neovim moderno, true a veces rompe el scroll de Snacks
vim.opt.synmaxcol = 250 -- No procesar líneas larguísimas (evita lag)
