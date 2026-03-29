-- ~/.config/nvim/lua/config/filetype.lua  (o donde tengas tu config)

vim.filetype.add {
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
}
