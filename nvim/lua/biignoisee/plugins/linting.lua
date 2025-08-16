return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local ns = vim.api.nvim_create_namespace("phpstan_diagnostics")

		local function get_project_root()
			local root_files = { "composer.json", "artisan", "phpstan.neon", ".git" }
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
		local phpstan_bin = project_root .. "/vendor/bin/phpstan"

		if vim.fn.filereadable(phpstan_bin) == 0 then
			vim.notify(
				"⚠️ No se encontró ./vendor/bin/phpstan — Instálalo con: composer require --dev phpstan/phpstan",
				vim.log.levels.WARN
			)
			phpstan_bin = "phpstan"
		end

		vim.keymap.set("n", "<F2>", function()
			if vim.bo.filetype ~= "php" then
				vim.notify("PHPStan solo funciona con archivos PHP", vim.log.levels.WARN)
				return
			end

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

			-- Terminal en floating window corriendo PHPStan
			vim.fn.termopen(phpstan_bin .. " analyse", { cwd = project_root })

			-- Mapear 'q' para cerrar la ventana de terminal
			vim.keymap.set("t", "q", function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
			end, { buffer = buf, nowait = true })

			-- Entrar en modo insert para ver output live
			vim.cmd("startinsert")
		end, { desc = "Run PHPStan on full project in floating terminal" })
	end,
}
