return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		filetypes = {
			"css",
			"scss",
			"html",
			"blade",
			"php",
		},
		user_default_options = {
			names = true, -- reconoce "red", "blue", etc
			RGB = true, -- #RGB
			RGBA = true, -- #RGBA
			RRGGBB = true, -- #RRGGBB
			RRGGBBAA = true, -- #RRGGBBAA
			css = true, -- activa todas las features css
			css_fn = true, -- activa rgb(), hsl(), etc
			tailwind = "both", -- 💨 soporte Tailwind (colores base + custom vía LSP)
			mode = "background", -- pinta el fondo (puedes probar "foreground" si prefieres)
			virtualtext = "■", -- marcador si usas modo virtualtext
		},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)
	end,
}
