vim.cmd("let g:netrw_banner=0")
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.optsigncolumn = "yes"

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.clipboard:append("unnamedplus")
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.g.editorconfig = true

vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait700-blinkon400-blinkoff250",
	"i-ci:ver25-Cursor/lCursor-blinkwait700-blinkon400-blinkoff250",
	"r-cr:hor20-Cursor/lCursor",
}

vim.opt.scrolloff = 999 -- siempre centra el cursor
