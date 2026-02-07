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
		dashboard = {
			enabled = true,
			formats = {
				key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
			},
			sections = {
				-- Terminal: Requiere fortune y cowsay instalados en tu PC
				-- Si no los tienes, puedes comentar esta linea o usar { section = "header" }
				{ section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
				{ title = "MRU (Archivos recientes)", padding = 1 },
				{ section = "recent_files", limit = 8, padding = 1 },
				{ title = "MRU (CWD: " .. vim.fn.fnamemodify(".", ":~") .. ")", padding = 1 },
				{ section = "recent_files", cwd = true, limit = 8, padding = 1 },
				{ title = "Sesiones", padding = 1 },
				{ section = "projects", padding = 1 },
				{ title = "Favoritos / Atajos", padding = 1 },
				{ section = "keys" },
				{ section = "startup" }, -- Muestra el tiempo de carga
			},
		},
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024,
			line_length = 1000,
			setup = function(ctx)
				if vim.fn.exists ":NoMatchParen" ~= 0 then vim.cmd [[NoMatchParen]] end
				Snacks.util.wo(0, {
					foldmethod = "manual",
					statuscolumn = "",
					conceallevel = 0,
				})
				vim.b.completion = false
				vim.b.minianimate_disable = true
				vim.b.minihipatterns_disable = true

				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then vim.bo[ctx.buf].syntax = ctx.ft end
				end)
			end,
		},
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true, timeout = 2500 },
		picker = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		bufdelete = { enabled = true }, -- Asegúrate de que esté habilitado aquí
	},
	keys = {
		-- 🔍 Navegación
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Live Grep" },

		-- 🧠 Búsqueda y LSP
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word under cursor", mode = { "n", "x" } },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (Workspace)" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (Buffer)" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },

		-- 📂 Gestión de Archivos y Buffers
		{ "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

		-- 🔧 Git
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

		-- 🧘 UI
		{ "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
		{ "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
		{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },

		-- 🔁 Movimiento
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...) Snacks.debug.inspect(...) end
				_G.bt = function() Snacks.debug.backtrace() end

				-- Override print to use snacks for `:=` command
				if vim.fn.has "nvim-0.11" == 1 then
					vim._print = function(_, ...) dd(...) end
				else
					vim.print = _G.dd
				end

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
				Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
				Snacks.toggle.diagnostics():map "<leader>ud"
				Snacks.toggle.line_number():map "<leader>ul"
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map "<leader>uc"
				Snacks.toggle.treesitter():map "<leader>uT"
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
				Snacks.toggle.inlay_hints():map "<leader>uh"
				Snacks.toggle.indent():map "<leader>ug"
				Snacks.toggle.dim():map "<leader>uD"
			end,
		})
	end,
}
