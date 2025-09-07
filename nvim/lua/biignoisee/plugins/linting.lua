-- eslint-linting.lua
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local function get_project_root()
			local root_files = { "package.json", "tsconfig.json", ".eslintrc.js", ".git", "composer.json" }
			local found = vim.fs.find(root_files, {
				upward = true,
				stop = vim.loop.os_homedir(),
				path = vim.fn.expand("%:p:h"),
			})[1]
			if found then
				return vim.fs.dirname(found)
			end
			return vim.fn.getcwd()
		end

		local project_root = get_project_root()

		-- Binarios locales
		local eslint_d = project_root .. "/node_modules/.bin/eslint_d"
		local eslint = project_root .. "/node_modules/.bin/eslint"
		local phpstan = project_root .. "/vendor/bin/phpstan"

		-- 🔑 Floating lint runner (F4)
		vim.keymap.set("n", "<F4>", function()
			local ft = vim.bo.filetype
			local cmd = nil

			if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
				if vim.fn.filereadable(eslint_d) == 1 then
					cmd = eslint_d .. " . --ext .js,.ts,.jsx,.tsx"
				elseif vim.fn.filereadable(eslint) == 1 then
					cmd = eslint .. " . --ext .js,.ts,.jsx,.tsx"
				else
					print(
						"⚠️ No se encontró eslint/eslint_d en ./node_modules — instala con: npm i -D eslint eslint_d"
					)
					return
				end
			elseif ft == "php" then
				if vim.fn.filereadable(phpstan) == 1 then
					cmd = phpstan .. " analyse"
				else
					print(
						"⚠️ No se encontró phpstan en ./vendor/bin — instala con: composer require --dev phpstan/phpstan"
					)
					return
				end
			else
				print("⚠️ No hay linter configurado para este filetype (" .. ft .. ")")
				return
			end

			-- Crear floating terminal
			local buf = vim.api.nvim_create_buf(false, true)
			local width = math.floor(vim.o.columns * 0.9)
			local height = math.floor(vim.o.lines * 0.4)
			local col = math.floor((vim.o.columns - width) / 2)
			local row = math.floor((vim.o.lines - height) / 2)

			local win = vim.api.nvim_open_win(buf, true, {
				relative = "editor",
				width = width,
				height = height,
				col = col,
				row = row,
				style = "minimal",
				border = "rounded",
			})

			vim.fn.termopen(cmd, { cwd = project_root })

			vim.keymap.set("t", "q", function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
			end, { buffer = buf, nowait = true })

			vim.cmd("startinsert")
		end, { desc = "Run project linter in floating terminal" })

		-- 🔑 nvim-lint setup (solo si existen los binarios)
		local lint = require("lint")
		lint.linters_by_ft = {}

		if vim.fn.filereadable(eslint_d) == 1 then
			lint.linters_by_ft.javascript = { "eslint_d" }
			lint.linters_by_ft.typescript = { "eslint_d" }
			lint.linters_by_ft.javascriptreact = { "eslint_d" }
			lint.linters_by_ft.typescriptreact = { "eslint_d" }
		end

		if vim.fn.filereadable(phpstan) == 1 then
			lint.linters_by_ft.php = { "phpstan" }
		end

		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
