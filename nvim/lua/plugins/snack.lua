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
		indent = {
			enabled = true,
			priority = 1,
			char = "│",
			only_scope = false,
			only_current = false,
			chunk = {
				enabled = true, -- ¡Activa esto!
				hl = "SnacksIndentChunk",
				char = {
					corner_top = "┌",
					corner_bottom = "└",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},

			animate = {
				enabled = vim.fn.has "nvim-0.10" == 1,
				style = "out",
				duration = {
					step = 20,
					total = 500,
				},
			},

			scope = {
				enabled = true,
				char = "┃", -- Una línea más gruesa para el bloque actual
				underline = false, -- No subraya el inicio (se ve más limpio)
			},
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000, -- 3 segundos es el sweet spot
			style = "compact", -- Más limpio, usa el borde para el título/icono
			top_down = true, -- Las notificaciones nuevas aparecen arriba
			width = { min = 40, max = 0.4 },
			margin = { top = 1, right = 1, bottom = 0 }, -- Un poco de aire en la esquina
			padding = true,
			sort = { "level", "added" }, -- Prioriza errores sobre mensajes info
		},
		picker = {
			enabled = true,
			ui_select = true, -- ¡IMPORTANTE! Reemplaza el menú de selección de Neovim por el Picker de Snacks
			sources = {
				explorer = {
					layout = { layout = { position = "right", width = 0.2 } },
					hidden = true, -- Mostrar archivos ocultos por defecto en el explorer
					ignored = true,
				},
			},
			win = {
				input = {
					keys = {
						-- Cerrar con Esc en modo insert y normal (muy cómodo)
						["<Esc>"] = { "cancel", mode = { "n", "i" } },
						-- Bajar y subir con Ctrl+j/k (estilo Vim)
						["<C-j>"] = { "list_down", mode = { "i", "n" } },
						["<C-k>"] = { "list_up", mode = { "i", "n" } },
					},
				},
			},
			-- Layout inteligente: si la pantalla es ancha, muestra preview al lado. Si es estrecha, arriba.
			layout = {
				cycle = true,
				preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
			},
			matcher = {
				fuzzy = true,
				smartcase = true,
				filename_bonus = true, -- Da prioridad si el nombre del archivo coincide exactamente
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 16, total = 200 }, -- Un poco más rápido que el default
				easing = "outQuad", -- Movimiento más natural que el "linear"
			},
			animate_repeat = {
				delay = 81, -- Se activa antes cuando spameas j/k
				duration = { step = 6, total = 50 },
			},
		},
		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" }, -- Prioriza tus marcas y signos de LSP
			right = { "fold", "git" }, -- Git y Folds a la derecha del número
			folds = {
				open = true, -- Muestra iconos cuando el bloque está abierto
				git_hl = true, -- Colorea los iconos de fold con los colores de Git
			},
		},
		words = { enabled = true },
		bufdelete = { enabled = true },
		gitbrowse = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				style = "terminal",
				position = "bottom", -- Estilo VS Code
				height = 0.4, -- 40% de la pantalla
			},
		},
		lazygit = {
			configure = true, -- Esto hace la magia del tema automático
			config = {
				os = { editPreset = "nvim-remote" },
				gui = { nerdFontsVersion = "4" },
				git = {
					paging = { colorArg = "always" },
				},
			},
		},
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
		{ "<C-q>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
		{ "<C-q>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal", mode = "t" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Terminal Flotante" },

		-- 🔎 Pickers (Los más útiles)
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers abiertos" },
		{ "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, desc = "Buscar en Config" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Mis Proyectos" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Historial de Undo (Visual)" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Historial de Comandos" },

		-- 🛠️ LSP & Search Avanzado
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Buscador de Iconos Lucide/Nerdfont" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

		-- 🚀 Git (Extra)
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },

		-- 🔁 Movimiento
		{ "]]", function() Snacks.words.jump(vim.v.count4) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[", function() Snacks.words.jump(-vim.v.count4) end, desc = "Prev Reference", mode = { "n", "t" } },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...) Snacks.debug.inspect(...) end
				_G.bt = function() Snacks.debug.backtrace() end

				-- 🚀 PEGA ESTO AQUÍ (Redirigir notificaciones a Snacks)
				vim.notify = function(msg, level, opts) Snacks.notifier.notify(msg, level, opts) end

				-- Override print to use snacks for `:=` command
				if vim.fn.has "nvim2.11" == 1 then
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
					.option("conceallevel", { off = 2, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
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
