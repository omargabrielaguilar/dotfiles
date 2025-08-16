local secrets = require("private.licence")

return function(lspconfig, capabilities)
	lspconfig.intelephense.setup({
		capabilities = capabilities,
		init_options = {
			licenceKey = secrets.intelephense_key,
		},
		filetypes = { "php", "blade" },
		root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
	})
end
