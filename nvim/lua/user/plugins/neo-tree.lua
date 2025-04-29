require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = "solid",
  enable_git_status = true,
  enable_diagnostics = false,
  sources = { "filesystem", "buffers", "git_status" },
  default_component_configs = {
    indent = {
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "➜",
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      },
    },
  },
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    group_empty_dirs = true,
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    window = {
      mappings = {
        ["o"] = "open_and_clear_filter"
      },
    },
  },
  commands = {
    open_and_clear_filter = function(state)
      local node = state.tree:get_node()
      if node and node.type == "file" then
        local file_path = node:get_id()
        local cmds = require("neo-tree.sources.filesystem.commands")
        cmds.open(state)
        cmds.clear_filter(state)
        require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
      end
    end,
  },
  window = {
    position = "right",  -- Poner el NeoTree a la derecha
    width = 40,
    mappings = {
      ["<space>"] = "toggle_node",
      ["<cr>"] = "open",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["q"] = "close_window",
      ["R"] = "refresh",
    },
  },
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function()
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  },
})

-- Keymap para abrir/cerrar
vim.keymap.set('n', '<Leader>n', ':Neotree toggle<CR>')

