return {
	init_options = {
		licenceKey = "00D0IEADQVBNA0K",
	},
	settings = {
		intelephense = {
			client = { maxMemory = 2048 },
			files = { maxSize = 5000000 },
			format = { enable = true },
			diagnostics = {
				enable = true,
				undefinedMethods = false,
				undefinedProperties = false,
			},
			completion = {
				fullyQualifyImportedNames = true,
				insertUseDeclaration = true,
			},
			environment = { phpVersion = "8.4.0" },
		},
	},
}
