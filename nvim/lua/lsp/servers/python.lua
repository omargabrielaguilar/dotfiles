return {
	cmd = { "pyright-langserver", "--stdio" },

	filetypes = { "python" },

	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"poetry.lock",
		".git",
	},

	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic", -- cambia a "strict" si quieres modo dios
				diagnosticMode = "workspace",
			},
		},
	},
}
