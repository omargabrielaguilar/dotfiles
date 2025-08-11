-- after/ftplugin/php.lua
vim.cmd([[
  autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd FileType php setlocal commentstring=//\ %s
]])

-- Cargar snippets específicos para PHP
if package.loaded["luasnip"] then
	require("luasnip").filetype_extend("php", { "php" })
end
