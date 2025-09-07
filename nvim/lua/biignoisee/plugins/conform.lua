return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- Detecta si existe Pint en el proyecto
		local function pint_exists()
			return vim.loop.fs_stat(vim.fn.getcwd() .. "/vendor/bin/pint") ~= nil
		end

		-- Selector dinámico de formateador PHP
		local function php_formatter(bufnr)
			local fname = vim.api.nvim_buf_get_name(bufnr)
			if fname:match("%.blade%.php$") then
				return { "blade-formatter" }
			end
			if pint_exists() then
				return { "pint" }
			end
			return { "php-cs-fixer" }
		end

		conform.setup({
			formatters_by_ft = {
				php = php_formatter,
				blade = { "blade-formatter" },
				lua = { "stylua" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				sh = { "shfmt" },
			},
			formatters = {
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
				["prettier"] = {
					command = "prettier",
					args = {
						"--stdin-filepath",
						"$FILENAME",
						"--tab-width",
						"2",
						"--use-tabs",
						"false",
						"--single-quote",
						"true",
					},
					stdin = true,
				},
				["shfmt"] = {
					prepend_args = { "-i", "4" },
				},
			},
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 500,
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			require("conform").format({
				lsp_fallback = false, -- no uses el LSP, solo tus formatters
				async = true,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range with Conform" })
	end,
}
