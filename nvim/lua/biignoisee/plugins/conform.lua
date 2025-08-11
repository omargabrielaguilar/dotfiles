return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		local function is_laravel_project()
			-- Detecta Laravel por archivo artisan en la raíz del cwd actual
			return vim.fn.filereadable(vim.fn.getcwd() .. "/artisan") == 1
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

		local function php_formatter(bufnr)
			local fname = vim.api.nvim_buf_get_name(bufnr)
			if fname:match("views") then
				return { "blade-formatter" }
			end

			if is_laravel_project() then
				return { "pint" }
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

		-- Configuraciones extras para prettier, shfmt si las usas
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
			require("conform").format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format PHP dynamically with pint/php-cs-fixer/blade-formatter, no LSP fallback" })
	end,
}
