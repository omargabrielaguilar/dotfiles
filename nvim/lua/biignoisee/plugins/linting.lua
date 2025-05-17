return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint = lint.linters.eslint_d

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			vue = { "eslint_d" },
			python = { "pylint" },
			php = { "phpstan" }, -- usa "php" si no tienes phpstan
			go = { "golangci_lint" },
			solidity = { "solhint" },
		}

		eslint.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.fn.expand("%:p")
			end,
		}

		-- Solidity
		lint.linters.solhint = {
			cmd = "solhint",
			args = {
				"--formatter",
				"unix",
				function()
					return vim.fn.expand("%:p")
				end,
			},
			stdin = false,
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
				source = "solhint",
				severity = vim.diagnostic.severity.WARN,
			}),
		}

		-- Python: pylint
		lint.linters.pylint = {
			cmd = "pylint",
			args = {
				"--output-format",
				"text",
				"--score",
				"n",
				"--msg-template",
				"{path}:{line}:{column}: {msg} ({msg_id})",
				function()
					return vim.fn.expand("%:p")
				end,
			},
			stdin = false,
			parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
				source = "pylint",
				severity = vim.diagnostic.severity.WARN,
			}),
		}

		-- PHP: phpstan
		-- lint.linters.phpstan = {
		-- 	cmd = "phpstan",
		-- 	args = {
		-- 		"analyse",
		-- 		"--error-format",
		-- 		"raw",
		-- 		"--no-progress",
		-- 		function()
		-- 			return vim.fn.expand("%:p")
		-- 		end,
		-- 	},
		-- 	stdin = false,
		-- 	ignore_exitcode = true,
		-- 	parser = require("lint.parser").from_errorformat("%f:%l %m", {
		--
		-- 		source = "phpstan",
		-- 		severity = vim.diagnostic.severity.WARN,
		-- 	}),
		-- }
		--
		-- -- Go: golangci-lint
		-- lint.linters.golangci_lint = {
		-- 	cmd = "golangci-lint",
		-- 	args = { "run", "--out-format", "tab" },
		-- 	stdin = false,
		-- 	ignore_exitcode = true,
		-- 	parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
		-- 		source = "golangci-lint",
		-- 		severity = vim.diagnostic.severity.WARN,
		-- 	}),
		-- }
		--
		-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		-- 	group = lint_augroup,
		-- 	callback = function()
		-- 		lint.try_lint()
		-- 	end,
		-- })

		-- Definición del mapeo de teclas para el líder 'l' en modo normal
		vim.keymap.set("n", "<leader>l", function()
			local ft = vim.bo.filetype
			local file = vim.fn.expand("%:p")
			local cmd = nil

			if ft == "php" then
				cmd = "phpstan analyse --error-format raw --no-progress " .. file
			elseif ft == "go" then
				cmd = "golangci-lint run --out-format tab " .. file
			elseif ft == "python" then
				cmd = "pylint --output-format text --score n " .. file
			elseif ft == "solidity" then
				cmd = "solhint " .. file
			elseif
				ft == "javascript"
				or ft == "typescript"
				or ft == "javascriptreact"
				or ft == "typescriptreact"
				or ft == "svelte"
			then
				cmd = "eslint_d " .. file
			end

			if cmd then
				-- Abre un terminal abajo sin perder el buffer actual
				vim.cmd("botright split")
				vim.cmd("resize 10")
				vim.cmd("terminal " .. cmd)
				vim.cmd("startinsert")
			else
				vim.notify("No lint command defined for filetype: " .. ft, vim.log.levels.WARN)
			end
		end, { desc = "Run linter command in terminal (per filetype)" })
	end,
}
