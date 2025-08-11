return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local noice = require("noice")
		local uv = vim.loop

		local function is_laravel_project()
			return vim.fn.filereadable(vim.fn.getcwd() .. "/artisan") == 1
		end

		local function pint_exists()
			local stat = uv.fs_stat(vim.fn.getcwd() .. "/vendor/bin/pint")
			return stat and stat.type == "file"
		end

		local formatters = {
			["markdown-toc"] = {
				condition = function(_, ctx)
					for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
						if line:find("<!%-%- toc %-%->") then
							return true
						end
					end
				end,
			},
			["markdownlint-cli2"] = {
				condition = function(_, ctx)
					local diag = vim.tbl_filter(function(d)
						return d.source == "markdownlint"
					end, vim.diagnostic.get(ctx.buf))
					return #diag > 0
				end,
			},
			["php-cs-fixer"] = {
				command = "env",
				args = {
					"PHP_CS_FIXER_IGNORE_ENV=1",
					"/home/biignoisee/.config/composer/vendor/bin/php-cs-fixer",
					"fix",
					"$FILENAME",
					"--rules=@PSR12",
					"--using-cache=no",
					"--allow-risky=yes",
				},
				stdin = false,
			},
			["pint"] = {
				command = "./vendor/bin/pint",
				args = { "--verbose", "--ansi", "$FILENAME" },
				stdin = false,
			},
			["blade-formatter"] = {
				command = "blade-formatter",
				args = { "--stdin" },
				stdin = true,
			},
		}

		local last_notify_time = 0
		local notify_cooldown = 300 -- 5 minutos

		local function php_formatter(bufnr)
			local fname = vim.api.nvim_buf_get_name(bufnr)
			if fname:match("views") then
				return { "blade-formatter" }
			end

			if is_laravel_project() then
				if pint_exists() then
					return { "pint" }
				else
					-- Aviso recomendando pint (solo si ha pasado cooldown)
					local now = os.time()
					if now - last_notify_time > notify_cooldown then
						last_notify_time = now
						noice.notify(
							"Te recomiendo instalar Laravel Pint para formateo rápido y oficial",
							vim.log.levels.WARN,
							{
								title = "Formatter",
								timeout = 3000,
								replace = "formatter_notify",
							}
						)
					end
					return { "php-cs-fixer" }
				end
			end

			return { "php-cs-fixer" }
		end

		conform.setup({
			formatters = formatters,
			formatters_by_ft = {
				php = php_formatter,
				json = { "prettier" },
				yaml = { "prettier" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
		})

		conform.formatters.prettier = {
			args = {
				"--stdin-filepath",
				"$FILENAME",
				"--tab-width",
				"4",
				"--use-tabs",
				"false",
			},
		}

		conform.formatters.shfmt = {
			prepend_args = { "-i", "4" },
		}

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local fmtters = php_formatter(bufnr)
			local formatter_name = fmtters[1] or "unknown"

			conform.format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
				buf = bufnr,
			})

			-- Mostrar mensaje solo la primera vez en cooldown
			local now = os.time()
			if now - last_notify_time > notify_cooldown then
				last_notify_time = now
				noice.notify("Formateado por: " .. formatter_name, vim.log.levels.INFO, {
					title = "Formatter",
					timeout = 2000,
					replace = "formatter_notify",
				})
			end
		end, { desc = "Format PHP dynamically and notify with noice" })
	end,
}
