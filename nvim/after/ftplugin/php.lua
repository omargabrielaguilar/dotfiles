-- after/ftplugin/php.lua
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

if package.loaded["luasnip"] then
	require("biignoisee.snippets")
end
