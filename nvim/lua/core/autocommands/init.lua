require("core.autocommands.remove_trailing_whitespace")
require("core.autocommands.easy_close_buffers")

-- TODO: move to the db plugin
-- Disable folding for dbout file type
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  callback = function()
    vim.cmd("setlocal nofoldenable")
  end,
})
