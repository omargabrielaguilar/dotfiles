do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local gofumpt = require("efmls-configs.formatters.gofumpt")
	local goimports = require("efmls-configs.formatters.goimports")

	-- Docker / Make
	local hadolint = require("efmls-configs.linters.hadolint")
	local checkmake = require("efmls-configs.linters.checkmake")

	-- ===== PYTHON STACK =====
	local black = require("efmls-configs.formatters.black")
	local isort = require("efmls-configs.formatters.isort")
	local ruff = require("efmls-configs.linters.ruff")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"javascript",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"sh",
			"typescript",
			"dockerfile",
			"makefile",
			"python",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				javascript = { eslint_d, prettier_d },
				typescript = { eslint_d, prettier_d },

				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },

				lua = { luacheck, stylua },

				dockerfile = { hadolint },
				makefile = { checkmake },

				go = { gofumpt, goimports },

				-- ===== PYTHON =====
				python = {
					ruff,
					isort,
					black,
				},
			},
		},
	})
end
