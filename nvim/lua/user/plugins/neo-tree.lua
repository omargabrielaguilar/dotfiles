require('neo-tree').setup({
  close_if_last_window = true, -- Cierra si es el último buffer abierto
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
  },
  window = {
    position = "right", -- Aquí lo ponemos a la derecha bro
    width = 30,
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
})

-- Keymap para abrir/cerrar
vim.keymap.set('n', '<Leader>n', ':Neotree toggle<CR>')

