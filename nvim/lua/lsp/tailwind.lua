return function(lspconfig, capabilities)
	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		filetypes = { "html", "javascript", "typescript", "vue" },
		root_dir = lspconfig.util.root_pattern("tailwind.config.js", "package.json", ".git"),
		settings = {
			tailwindCSS = {
				experimental = { classRegex = { 'class="([^"]*)"', 'className="([^"]*)"' } },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidScreen = "error",
					invalidVariant = "error",
				},
			},
		},
	})
end
