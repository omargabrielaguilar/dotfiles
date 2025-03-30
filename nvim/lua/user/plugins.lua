local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").reset()
require("packer").init({
	compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "solid" })
		end,
	},
})

local use = require("packer").use

-- Packer can manage itself.
use("wbthomason/packer.nvim")

use({
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				functions = { "bold" },
				keywords = { "italic" },
				strings = { "italic" },
				variables = {},
				booleans = { "bold" },
				properties = {},
				types = { "bold" },
				operators = {},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				telescope = true,
				notify = true,
				mason = true,
				indent_blankline = { enabled = true, scope_color = "lavender" },
				which_key = true,
			},
		})

		-- Aplicar el esquema de colores
		vim.cmd("colorscheme catppuccin-mocha")

		-- Mejorar la apariencia de NvimTree
		vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#3E4452" }) -- Color más sutil
		vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#F5C2E7" }) -- Color más visible para iconos

		-- Mejoras en la indentación
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3B3F4C" })

		-- Mejoras en Telescope
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#2A2A37", fg = "#F5E0DC", bold = true })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#A6ADC8" })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#A6ADC8" })

		-- CursorLine para mejor enfoque sin ser molesto
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2A2D37" })

		-- Mejor contraste en comentarios
		vim.api.nvim_set_hl(0, "Comment", { fg = "#A6ADC8", italic = true })
	end,
})

-- Commenting support.
use("tpope/vim-commentary")

-- Add, change, and delete surrounding text.
use("tpope/vim-surround")

-- Useful commands like :Rename and :SudoWrite.
use("tpope/vim-eunuch")

-- Pairs of handy bracket mappings, like [b and ]b.
use("tpope/vim-unimpaired")

-- Indent autodetection with editorconfig support.
use("tpope/vim-sleuth")

-- Allow plugins to enable repeating of commands.
use("tpope/vim-repeat")

-- Add more languages.
-- use("sheerun/vim-polyglot")

-- Navigate seamlessly between Vim windows and Tmux panes.
use("christoomey/vim-tmux-navigator")

-- Jump to the last location when opening a file.
use("farmergreg/vim-lastplace")

-- Enable * searching with visually selected text.
use("nelstrom/vim-visual-star-search")

-- Automatically create parent dirs when saving.
use("jessarcher/vim-heritage")

-- Text objects for HTML attributes.
use({
	"whatyouhide/vim-textobj-xmlattr",
	requires = "kana/vim-textobj-user",
})

-- Automatically set the working directory to the project root.
use({
	"airblade/vim-rooter",
	setup = function()
		-- Instead of this running every time we open a file, we'll just run it once when Vim starts.
		vim.g.rooter_manual_only = 1
	end,
	config = function()
		vim.cmd("Rooter")
	end,
})

-- Automatically add closing brackets, quotes, etc.
use({
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup()
	end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup()
	end,
})

-- All closing buffers without closing the split window.
use({
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<Leader>q", ":Bdelete<CR>")
	end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
	"AndrewRadev/splitjoin.vim",
	config = function()
		vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
		vim.g.splitjoin_trailing_comma = 1
		vim.g.splitjoin_php_method_chain_full = 1
	end,
})

-- Automatically fix indentation when pasting code.
use({
	"sickill/vim-pasta",
	config = function()
		vim.g.pasta_disabled_filetypes = { "fugitive" }
	end,
})

--fuzzy finder
use({
	"nvim-telescope/telescope.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		},
	},
	after = "nvim",
	config = function()
		require("user/plugins/telescope")
	end,
})

-- file tree sidebar
use({
	"kyazdani42/nvim-tree.lua",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require("user/plugins/nvim-tree")
	end,
})

--status line
use({
	"nvim-lualine/lualine.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require("user/plugins/lualine")
	end,
})

use({
	"akinsho/bufferline.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	after = "nvim",
	config = function()
		require("user/plugins/bufferline")
	end,
})

-- Display indentation lines.
use({
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("user/plugins/indent-blankline")
	end,
})

-- Add dashboard for me
use({
	"nvimdev/dashboard-nvim",
	config = function()
		require("user/plugins/dashboard-nvim")
	end,
})

-- git integrations
use({
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
		vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>")
		vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>")
		vim.keymap.set("n", "gs", ":Gitsigns stage_hunk<CR>")
		vim.keymap.set("n", "gS", ":Gitsigns undo_stage_hunk<CR>")
		vim.keymap.set("n", "gp", ":Gitsigns preview_hunk<CR>")
		vim.keymap.set("n", "gb", ":Gitsigns blame_line<CR>")
	end,
})

use({
	"tpope/vim-fugitive",
	requires = "tpope/vim-rhubarb",
})

use({
	"voldikss/vim-floaterm",
	config = function()
		vim.g.floaterm_position = "bottom"
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.45

		vim.keymap.set("n", "<F1>", ":FloatermToggle<CR>")
		vim.keymap.set("t", "<F1>", "<C-\\><C-n>:FloatermToggle<CR>")

		vim.cmd([[
      highlight link Floaterm NormalFloat
      highlight link FloatermBorder FloatBorder
    ]])
	end,
})

-- treesitter
use({
	"nvim-treesitter/nvim-treesitter",
	run = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	requires = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("user/plugins/treesitter")
		vim.g.skip_ts_context_commentstring_module = true
	end,
})

-- Language Server Protocol.
use({
	"neovim/nvim-lspconfig",
	requires = {
		"williamboman/mason.nvim",
		"b0o/schemastore.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("user/plugins/lspconfig")
	end,
})

use({
	"nvimtools/none-ls.nvim",
	requires = { "jayp0521/mason-null-ls.nvim" },
	config = function()
		require("user/plugins/none-ls") -- Asegúrate de cambiar el nombre del archivo
	end,
})


-- Completion
use({
	"hrsh7th/nvim-cmp",
	requires = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
	},
	config = function()
		require("user/plugins/cmp")
	end,
})

use({
	"phpactor/phpactor",
	ft = "php",
	run = "composer install --no-dev --optimize-autoloader",
	config = function()
		vim.keymap.set("n", "<Leader>pm", ":PhpactorContextMenu<CR>")
		vim.keymap.set("n", "<Leader>pn", ":PhpactorClassNew<CR>")
	end,
})

use({
	"tpope/vim-projectionist",
	requires = "tpope/vim-dispatch",
	config = function()
		require("user/plugins/projectionist")
	end,
})

use({
	"vim-test/vim-test",
	config = function()
		require("user/plugins/vim-test")
	end,
})

-- vim dadbod
use({
	"tpope/vim-dadbod",
	requires = { "kristijanhusak/vim-dadbod-completion", "kristijanhusak/vim-dadbod-ui" },
	config = function()
		require("user/plugins/vim-dadbod")
	end,
})

if packer_bootstrap then
	require("packer").sync()
end

vim.cmd([[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

if packer_bootstrap then
	require("packer").sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
