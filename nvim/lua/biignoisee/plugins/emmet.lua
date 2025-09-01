return {
	"olrtg/emmet-language-server",
	config = function()
		require("lspconfig").emmet_ls.setup({
			filetypes = { "html", "blade" },
		})
	end,
}
