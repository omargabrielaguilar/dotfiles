return {
	cmd = { "ruff-langserver" },
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
		ruff = {
			lint = {
				enable = true,
				select = { "E", "W", "F", "I" }, -- errores, warnings, imports
			},
		},
	},
}
