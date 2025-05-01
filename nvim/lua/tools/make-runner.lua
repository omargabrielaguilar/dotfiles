vim.keymap.set({ "n" }, "<leader>mm", function()
  -- TODO: should check if the file is redeable
  local items =
    vim.fn.systemlist("make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\\/\t=]*:([^=]|$)/ {split($1,A,/ /);print A[1]}'")

  if vim.tbl_isempty(items) then
    vim.notify("No make items", vim.log.levels.WARN, {})
    return
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  vim.ui.select(vim.fn.uniq(items), { promt = "Make command" }, function(choice)
    if not choice then
      return
    end

    vim.cmd(string.format("Dispatch make %s", choice))
  end)
end, {})
