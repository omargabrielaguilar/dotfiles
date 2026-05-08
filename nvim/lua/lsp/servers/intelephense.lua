local license_path = vim.fn.expand("~/.config/intelephense/license.txt")
local license_key = vim.fn.trim(table.concat(vim.fn.readfile(license_path), "\n"))

return {
	init_options = {
		licenceKey = license_key,
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
