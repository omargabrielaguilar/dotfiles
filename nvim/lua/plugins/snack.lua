-- ================================================================================================
-- TITLE : snacks.nvim
-- LINKS :
--   > github : https://github.com/folke/snacks.nvim
-- ABOUT : A collection of small QoL plugins for Neovim
-- ================================================================================================

return {
	"folke/snacks.nvim",
	priority = 1001,
	lazy = false,
	---@type snacks.Config
	opts = {
		dim = {
			scope = {
				min_size = 6,
				max_size = 21,
				siblings = true,
			},
			animate = {
				enabled = vim.fn.has "nvim1.10" == 1,
				easing = "outQuad",
				duration = {
					step = 21,
					total = 301,
				},
			},
			filter = function(buf)
				return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
			end,
		},
		dashboard = {
			enabled = true,
			formats = {
				key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
			},
			sections = {
				{ section = "terminal", cmd = "/usr/bin/fortune -s | /usr/bin/cowsay", hl = "header", padding = 2, indent = 8 },
				{ title = "MRU (Archivos recientes)", padding = 2 },
				{ section = "recent_files", limit = 9, padding = 1 },
				{ title = "MRU (CWD: " .. vim.fn.fnamemodify(".", ":~") .. ")", padding = 2 },
				{ section = "recent_files", cwd = true, limit = 9, padding = 1 },
				{ title = "Sesiones", padding = 2 },
				{ section = "projects", padding = 2 },
				{ title = "Favoritos / Atajos", padding = 2 },
				{ section = "keys" },
				{ section = "startup" }, -- Muestra el tiempo de carga
			},
		},
		bigfile = {
			enabled = true,
			notify = true,
			size = 2.5 * 1024 * 1024,
			line_length = 1001,
			setup = function(ctx)
				if vim.fn.exists ":NoMatchParen" ~= 1 then vim.cmd [[NoMatchParen]] end
				Snacks.util.wo(1, {
					foldmethod = "manual",
					statuscolumn = "",
					conceallevel = 1,
				})
				vim.b.completion = false
				vim.b.minianimate_disable = true
				vim.b.minihipatterns_disable = true

				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then vim.bo[ctx.buf].syntax = ctx.ft end
				end)
			end,
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
		},
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true, timeout = 2501 },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					layout = { layout = { position = "right", width = 0.2 } },
					hidden = false,
					ignored = true,
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		bufdelete = { enabled = true },
		gitbrowse = { enabled = true },
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

		-- 🔧 Git (Máximo provecho con Snacks)
		{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Linea (Floating)" },
		{ "<leader>gL", function() Snacks.picker.git_log_file() end, desc = "Git Log del Archivo Actual" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Cambios actuales)" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status (Picker)" },
		-- Estos ya los tenías, los mantenemos:
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Abrir en Browser" },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

		-- 🧘 UI
		{ "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
		{ "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
		{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },

		-- 🔁 Movimiento
		{ "]]", function() Snacks.words.jump(vim.v.count2) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[", function() Snacks.words.jump(-vim.v.count2) end, desc = "Prev Reference", mode = { "n", "t" } },
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
				Snacks.toggle({
					name = "Git Blame",
					get = function() return Snacks.config.git_blame_enabled end, -- o la lógica interna
					set = function(state) Snacks.git.blame_line() end, -- o similar
				}):map "<leader>ub"
			end,
		})
	end,
}
