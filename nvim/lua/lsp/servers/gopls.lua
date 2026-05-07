return {
	settings = {
		gopls = {
			gofumpt = true, -- Usa gofumpt internamente en lugar de gofmt
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
}
