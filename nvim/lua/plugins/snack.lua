-- ================================================================================================
-- TITLE : snacks.nvim
-- LINKS :
--   > github : https://github.com/folke/snacks.nvim
-- ABOUT : A collection of small QoL plugins for Neovim
-- ================================================================================================

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 2500,
		},
		picker = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		-- 🔍 Core navigation
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},

		-- 🧠 Search power
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Word under cursor",
			mode = { "n", "x" },
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},

		-- 🌳 Explorer / Files
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},

		-- 🔧 Git
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},

		-- 🧠 LSP Search / Exploration (UI power)
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Document Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics (workspace)",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics (buffer)",
		},

		-- 🧘 UI / Flow
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss Notifications",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal",
		},

		-- 🔁 Words motion
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end

				-- Override print to use snacks for `:=` command
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						dd(...)
					end
				else
					vim.print = _G.dd
				end

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
