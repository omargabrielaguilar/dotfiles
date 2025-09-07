return {
	"hrsh7th/nvim-cmp",
	-- event = "insertenter",
	branch = "main", -- fix for deprecated functions coming in nvim 0.13
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline",
		{
			"l3mon4d3/luasnip",
			-- follow latest release.
			version = "v2.*", -- replace <currentmajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- autocompletion
		"rafamadriz/friendly-snippets", -- snippets
		"nvim-treesitter/nvim-treesitter",
		"onsails/lspkind.nvim", -- vs-code pictograms
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local cmp = require("cmp")
		-- local luasnip = require("luasnip")
		local has_luasnip, luasnip = pcall(require, "luasnip")
		local lspkind = require("lspkind")
		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local rhs = function(keys)
			return vim.api.nvim_replace_termcodes(keys, true, true, true)
		end

		local lsp_kinds = {
			class = " ",
			color = " ",
			constant = " ",
			constructor = " ",
			enum = " ",
			enummember = " ",
			event = " ",
			field = " ",
			file = " ",
			folder = " ",
			function = " ",
			interface = " ",
			keyword = " ",
			method = " ",
			module = " ",
			operator = " ",
			property = " ",
			reference = " ",
			snippet = " ",
			struct = " ",
			text = " ",
			typeparameter = " ",
			unit = " ",
			value = " ",
			variable = " ",
		}
		-- returns the current column number.
		local column = function()
			local _line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col
		end

		-- luasnip custom function
		local in_snippet = function()
			local session = require("luasnip.session")
			local node = session.current_nodes[vim.api.nvim_get_current_buf()]
			if not node then
				return false
			end
			local snippet = node.parent.snippet
			local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
			local pos = vim.api.nvim_win_get_cursor(0)
			if pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1] then
				return true
			end
		end

		-- returns true if the cursor is in leftmost column or at a whitespace char
		local in_whitespace = function()
			local col = column()
			return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")
		end

		local in_leading_indent = function()
			local col = column()
			local line = vim.api.nvim_get_current_line()
			local prefix = line:sub(1, col)
			return prefix:find("^%s*$")
		end

		-- custom shift width
		local shift_width = function()
			if vim.o.softtabstop <= 0 then
				return vim.fn.shiftwidth()
			else
				return vim.o.softtabstop
			end
		end

		-- custom smart backspace
		local smart_bs = function(dedent)
			local keys = nil
			if vim.o.expandtab then
				if dedent then
					keys = rhs("<c-d>")
				else
					keys = rhs("<bs>")
				end
			else
				local col = column()
				local line = vim.api.nvim_get_current_line()
				local prefix = line:sub(1, col)
				if in_leading_indent() then
					keys = rhs("<bs>")
				else
					local previous_char = prefix:sub(#prefix, #prefix)
					if previous_char ~= " " then
						keys = rhs("<bs>")
					else
						keys = rhs("<c-\\><c-o>:set expandtab<cr><bs><c-\\><c-o>:set noexpandtab<cr>")
					end
				end
			end
			vim.api.nvim_feedkeys(keys, "nt", true)
		end

		-- custom smart tabs function
		local smart_tab = function(opts)
			local keys = nil
			if vim.o.expandtab then
				keys = "<tab>" -- neovim will insert spaces.
			else
				local col = column()
				local line = vim.api.nvim_get_current_line()
				local prefix = line:sub(1, col)
				local in_leading_indent = prefix:find("^%s*$")
				if in_leading_indent then
					-- inserts a hard tab.
					keys = "<tab>"
				else
					local sw = shift_width()
					local previous_char = prefix:sub(#prefix, #prefix)
					local previous_column = #prefix - #previous_char + 1
					local current_column = vim.fn.virtcol({ vim.fn.line("."), previous_column }) + 1
					local remainder = (current_column - 1) % sw
					local move = remainder == 0 and sw or sw - remainder
					keys = (" "):rep(move)
				end
			end

			vim.api.nvim_feedkeys(rhs(keys), "nt", true)
		end

		local custom_snippets = require("biignoisee.snippets")
		for ft, snippets in pairs(custom_snippets) do
			luasnip.add_snippets(ft, snippets)
		end

		local select_next_item = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end

		local select_prev_item = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end

		-- note: until https://github.com/hrsh7th/nvim-cmp/issues/1716
		-- (cmp.confirmbehavior.matchsuffix) gets implemented, use this local wrapper
		-- to choose between `cmp.confirmbehavior.insert` and `cmp.confirmbehavior.replace`:
		local confirm = function(entry)
			local behavior = cmp.confirmbehavior.replace
			if entry then
				local completion_item = entry.completion_item
				local newtext = ""
				if completion_item.textedit then
					newtext = completion_item.textedit.newtext
				elseif type(completion_item.inserttext) == "string" and completion_item.inserttext ~= "" then
					newtext = completion_item.inserttext
				else
					newtext = completion_item.word or completion_item.label or ""
				end

				-- checks how many characters will be different after the cursor position if we replace?
				local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

				-- does the text that will be replaced after the cursor match the suffix
				-- of the `newtext` to be inserted ? if not, then `insert` instead.
				if entry.context.cursor_after_line:sub(1, diff_after) ~= newtext:sub(-diff_after) then
					behavior = cmp.confirmbehavior.insert
				end
			end
			cmp.confirm({ select = true, behavior = behavior })
		end

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			experimental = {
				-- hack: experimenting with ghost text
				-- look at `toggle_ghost_text()` function below.
				ghost_text = false,
			},
			completion = {
				completeopt = "menuone,noselect,noinsert",
			},
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				completion = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				},
			},
			-- config nvim cmp to work with snippet engine
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- autocompletion sources
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippets
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "tailwindcss-colorizer-cmp" },
			}),
			-- note: ! experimenting with customized mappings ! --
			mapping = cmp.mapping.preset.insert({
				["<c-e>"] = cmp.mapping.abort(), -- close completion window
				["<c-d>"] = cmp.mapping(function()
					cmp.close_docs()
				end, { "i", "s" }),

				["<c-f>"] = cmp.mapping.scroll_docs(4),
				["<c-b>"] = cmp.mapping.scroll_docs(-4),
				["<c-j>"] = cmp.mapping(select_next_item),
				["<c-k>"] = cmp.mapping(select_prev_item),
				["<c-n>"] = cmp.mapping(select_next_item),
				["<c-p>"] = cmp.mapping(select_prev_item),
				["<down>"] = cmp.mapping(select_next_item),
				["<up>"] = cmp.mapping(select_prev_item),

				["<c-y>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						confirm(entry)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<cr>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						confirm(entry)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<s-tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif has_luasnip and in_snippet() and luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif in_leading_indent() then
						smart_bs(true) -- true means to dedent
					elseif in_whitespace() then
						smart_bs()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<tab>"] = cmp.mapping(function(_fallback)
					if cmp.visible() then
						-- if there is only one completion candidate then use it.
						local entries = cmp.get_entries()
						if #entries == 1 then
							confirm(entries[1])
						else
							cmp.select_next_item()
						end
					elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif in_whitespace() then
						smart_tab()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
			}),
			-- setup lspkind for vscode pictograms in autocompletion dropdown menu
			formatting = {
				format = function(entry, vim_item)
					-- add custom lsp_kinds icons
					vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)

					-- add menu tags (e.g., [buffer], [lsp])
					vim_item.menu = ({
						buffer = "[buffer]",
						nvim_lsp = "[lsp]",
						luasnip = "[luasnip]",
						nvim_lua = "[lua]",
						latex_symbols = "[latex]",
					})[entry.source.name]

					-- use lspkind and tailwindcss-colorizer-cmp for additional formatting
					vim_item = lspkind.cmp_format({
						maxwidth = 25,
						ellipsis_char = "...",
					})(entry, vim_item)

					if entry.source.name == "nvim_lsp" then
						vim_item = colorizer(entry, vim_item)
					end

					return vim_item
				end,
			},
		})

		-- note: added ghost text stuff
		-- only show ghost text at word boundaries, not inside keywords. based on idea
		-- from: https://github.com/hrsh7th/nvim-cmp/issues/2035#issuecomment-2347186210

		local config = require("cmp.config")
		local toggle_ghost_text = function()
			if vim.api.nvim_get_mode().mode ~= "i" then
				return
			end

			local cursor_column = vim.fn.col(".")
			local current_line_contents = vim.fn.getline(".")
			local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

			local should_enable_ghost_text = character_after_cursor == ""
				or vim.fn.match(character_after_cursor, [[\k]]) == -1

			local current = config.get().experimental.ghost_text
			if current ~= should_enable_ghost_text then
				config.set_global({
					experimental = {
						ghost_text = should_enable_ghost_text,
					},
				})
			end
		end

		vim.api.nvim_create_autocmd({ "insertenter", "cursormovedi" }, {
			callback = toggle_ghost_text,
		})
		-- ! ghost text stuff ! --
	end,
}
