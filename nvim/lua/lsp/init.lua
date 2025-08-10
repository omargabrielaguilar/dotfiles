local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Capabilities globales
local capabilities = cmp_nvim_lsp.default_capabilities()

-- 📌 Keymaps globales al conectar LSP
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local keymap = vim.keymap.set

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

		keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = ev.buf })
		keymap("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Smart Rename", buffer = ev.buf })

		keymap(
			"n",
			"<leader>ltg",
			"<cmd>Telescope diagnostics bufnr=0<CR>",
			{ desc = "Buffer Diagnostics", buffer = ev.buf }
		)
		keymap("n", "<leader>ldg", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = ev.buf })

		keymap("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
		keymap("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = ev.buf })

		keymap("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format File", buffer = ev.buf })
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
	-- rust = require("lsp.rust"),
	-- typescript = require("lsp.typescript"),
}

for _, setup_fn in pairs(servers) do
	setup_fn(lspconfig, capabilities)
end
