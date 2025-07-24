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
			php = { "phpstan" },
			java = { "checkstyle" },
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
		eslint.format = "json"
		eslint.stream = "stdin"

		-- PHP: phpstan
		lint.linters.phpstan = {
			cmd = "phpstan",
			args = {
				"analyse",
				"--error-format",
				"raw",
				"--no-progress",
				function()
					return vim.fn.expand("%:p")
				end,
			},
			stdin = false,
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat("%f:%l %m", {

				source = "phpstan",
				severity = vim.diagnostic.severity.WARN,
			}),
		}

		lint.linters.checkstyle = {
			cmd = "checkstyle", -- asegúrate que esté en tu $PATH
			args = {
				"-f",
				"plain", -- formato simple que se puede parsear
				"-c",
				vim.fn.expand("~/.config/checkstyle/google_checks.xml"),
				function()
					return vim.fn.expand("%:p")
				end,
			},
			stdin = false,
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat("%f:%l: %m", {
				source = "checkstyle",
				severity = vim.diagnostic.severity.WARN,
			}),
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Definición del mapeo de teclas para el líder 'l' en modo normal
		vim.keymap.set("n", "<leader>l", function()
			local ft = vim.bo.filetype
			local file = vim.fn.expand("%:p")
			local cmd = nil

			if ft == "php" then
				cmd = "phpstan analyse --error-format raw --no-progress " .. file
			elseif
				ft == "javascript"
				or ft == "typescript"
				or ft == "javascriptreact"
				or ft == "typescriptreact"
				or ft == "svelte"
			then
				cmd = "eslint_d " .. file
			elseif ft == "java" then
				cmd = "checkstyle -f plain -c ~/.config/checkstyle/google_checks.xml " .. file
			end

			if cmd then
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
