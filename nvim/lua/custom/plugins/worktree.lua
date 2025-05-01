return {
  "polarmutex/git-worktree.nvim",
  enabled = require("nixCatsUtils").enableForCategory("worktree"),
  version = "^2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>gt",
      function()
        vim.system(
          { "git", "worktree", "list" },
          {},
          vim.schedule_wrap(function(obj)
            local out = obj.stdout
            local worktrees = {}
            local base_path = nil
            if not out then
              return
            end
            -- Split output into lines and process each line
            for line in out:gmatch("[^\r\n]+") do
              if line:match("%(bare%)") then
                -- Extract base path from bare repository line
                base_path = line:match("^%s*(.-)%s+%(bare%)") or ""
              else
                if base_path == nil then
                  vim.notify("Not a worktree project")
                  return
                end
                -- Parse non-bare worktree lines
                local path, hash, branch = line:match("^%s*(.-)%s+([%x]+)%s+%[(.-)%]")
                if path and hash and branch then
                  local basename = path:match(base_path:gsub("-", "%%-") .. "/(.+)$") or path
                  table.insert(worktrees, {
                    path = path,
                    base_path = base_path,
                    basename = basename,
                    hash = hash,
                    branch = branch,
                  })
                end
              end
            end

            local snacks = require("snacks").picker
            snacks.pick({
              title = "Worktrees",
              items = vim
                .iter(worktrees)
                :map(function(worktree)
                  return {
                    value = worktree,
                    text = worktree.path .. " " .. worktree.branch .. " " .. worktree.hash,
                  }
                end)
                :totable(),
              preview = "none",
              format = function(item, _)
                return {
                  { string.format("[%s]", item.value.basename), "@string" },
                  { " ", "@string" },
                  { item.value.hash, "@keyword" },
                  { " - ", "@string" },
                  { item.value.branch, "@string" },
                }
              end,
              layout = {
                preview = false,
              },
              confirm = function(picker, item)
                picker:close()
                if item then
                  require("git-worktree").switch_worktree(item.value.path)
                end
              end,
            })
          end)
        )
      end,
    },
  },
}
