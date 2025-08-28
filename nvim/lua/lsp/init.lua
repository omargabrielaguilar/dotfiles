local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Capabilities globales
local capabilities = cmp_nvim_lsp.default_capabilities()

-- 📌 Keymaps globales al conectar LSP
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local keymap = vim.keymap.set
		local opts = { buffer = ev.buf, noremap = true, silent = true }

		-- Navegación
		keymap("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP References", buffer = ev.buf })
		keymap("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP Definitions", buffer = ev.buf })
		keymap("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = ev.buf })
		keymap(
			"n",
			"<leader>li",
			"<cmd>Telescope lsp_implementations<CR>",
			{ desc = "LSP Implementations", buffer = ev.buf }
		)
		keymap(
			"n",
			"<leader>lt",
			"<cmd>Telescope lsp_type_definitions<CR>",
			{ desc = "LSP Type Definitions", buffer = ev.buf }
		)

		-- Acciones
		keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = ev.buf })
		keymap("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart Rename", buffer = ev.buf })
		keymap("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format File", buffer = ev.buf })

		-- Docs & ayuda
		keymap("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
		keymap("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = ev.buf })

		-- Diagnósticos
		keymap(
			"n",
			"<leader>ltg",
			"<cmd>Telescope diagnostics bufnr=0<CR>",
			{ desc = "Buffer Diagnostics", buffer = ev.buf }
		)
		keymap("n", "<leader>ldg", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = ev.buf })
		keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic", buffer = ev.buf })
		keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = ev.buf })

		-- 🆕 Intelephense Premium goodies
		keymap("n", "<leader>lm", function()
			vim.lsp.buf.execute_command({ command = "intelephense.applyFixAll" })
		end, { desc = "Apply All Fixes", buffer = ev.buf })

		keymap("n", "<leader>ldc", function()
			vim.lsp.buf.execute_command({ command = "intelephense.importClass" })
		end, { desc = "Import Class (auto-use)", buffer = ev.buf })

		keymap("n", "<leader>lp", function()
			vim.lsp.buf.execute_command({ command = "intelephense.addPhpDoc" })
		end, { desc = "Generate PHPDoc", buffer = ev.buf })

		keymap("n", "<leader>lmth", function()
			vim.lsp.buf.execute_command({ command = "intelephense.implementAbstractMethods" })
		end, { desc = "Implement Abstract Methods", buffer = ev.buf })

		-- 🪄 Smart select (expand/shrink)
		keymap(
			"v",
			"<leader>lv",
			"<cmd>lua require('vim.lsp.buf').range_code_action()<CR>",
			{ desc = "Range Code Action", buffer = ev.buf }
		)
	end,
})

-- Símbolos diagnósticos
local signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = "󰠠 ",
	[vim.diagnostic.severity.INFO] = " ",
}
vim.diagnostic.config({
	signs = { text = signs },
	virtual_text = true,
	underline = true,
	update_in_insert = false,
})

-- Servidores LSP
local servers = {
	lua = require("lsp.lua"),
	php = require("lsp.php"),
	tailwind = require("lsp.tailwind"),
	-- typescript = require("lsp.typescript"),
}

for _, setup_fn in pairs(servers) do
	setup_fn(lspconfig, capabilities)
end
