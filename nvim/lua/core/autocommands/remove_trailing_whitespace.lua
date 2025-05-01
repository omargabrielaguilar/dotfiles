vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  command = ":%s/\\s\\+$//e",
})
