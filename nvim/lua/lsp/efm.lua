do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local gofumpt = require("efmls-configs.formatters.gofumpt")
	local goimports = require("efmls-configs.formatters.goimports")

	-- ====== DOCKER Y MAKEFILE ======
	local hadolint = require("efmls-configs.linters.hadolint")
	local checkmake = require("efmls-configs.linters.checkmake")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"go",
			"javascript",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"sh",
			"typescript",
			"docker",
			"makefile",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				go = {
					goimports,
					gofumpt,
				},
				javascript = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				typescript = { eslint_d, prettier_d },
				dockerfile = { hadolint },
				make = { checkmake },
			},
		},
	})
end
