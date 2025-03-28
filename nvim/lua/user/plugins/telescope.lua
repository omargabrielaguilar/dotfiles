local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.cmd([[
  highlight link TelescopePromptTitle PMenuSel
  highlight link TelescopePreviewTitle PMenuSel
  highlight link TelescopePromptNormal NormalFloat
  highlight link TelescopePromptBorder FloatBorder
  highlight link TelescopeNormal CursorLine
  highlight link TelescopeBorder CursorLineBg
]])

require("telescope").setup({
	defaults = {
		path_display = { truncate = 1 },
		prompt_prefix = "   ",
		selection_caret = "  ",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
			},
		},
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		buffers = {
			previewer = false,
			layout_config = {
				width = 80,
			},
		},
		oldfiles = {
			prompt_title = "History",
		},
		lsp_references = {
			previewer = false,
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = "ascending",
			fuzzy = true,
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("live_grep_args")

vim.keymap.set("n", "<leader>f", [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set(
	"n",
	"<leader>F",
	[[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]
)
vim.keymap.set("n", "<leader>b", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set("n", "<leader>g", [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set("n", "<leader>h", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set("n", "<leader>s", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
vim.keymap.set("n", "<C-f>", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
vim.keymap.set("n", "<C-g>", [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
vim.keymap.set("n", "<leader>gc", [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
vim.keymap.set("n", "<leader>gb", [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
vim.keymap.set("n", "<leader>gd", [[<cmd>DiffviewOpen<CR>]])
