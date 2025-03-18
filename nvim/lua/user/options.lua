-- Configuración de tabulación
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Formato de texto y edición
vim.opt.wrap = true
vim.opt.colorcolumn = "" -- No mostrar la línea límite

-- Números de línea
vim.opt.number = true
vim.opt.relativenumber = true

-- Autocompletado y explorador de archivos
vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menuone,longest,preview"

-- Apariencia y UI
vim.opt.title = true
vim.opt.mouse = "a" -- Habilitar el mouse en todos los modos
vim.opt.termguicolors = true
vim.opt.cursorline = true -- Resaltar la línea actual

-- Minimapa y bordes del editor
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·" }
vim.opt.fillchars:append({ eob = " " }) -- Eliminar "~" en líneas vacías
vim.opt.signcolumn = "yes:1"

-- Búsqueda inteligente
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- División de ventanas
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Portapapeles del sistema
vim.opt.clipboard = "unnamedplus"

-- Guardado y seguridad
vim.opt.undofile = true -- Habilitar undo persistente
vim.opt.backup = true -- Guardar backups automáticos
vim.opt.backupdir:remove(".") -- Evitar backups en el directorio actual

vim.cmd([[
highlight clear SignColumn
highlight clear FoldColumn
highlight clear CursorLineNr
]])

vim.opt.spell = false
