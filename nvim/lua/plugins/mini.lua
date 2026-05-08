require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({
	draw = {
		delay = 100,
		predicate = function(scope)
			return not scope.body.is_incomplete
		end,
		priority = 2,
	},
	symbol = "╎", -- el símbolo de la línea
})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})
require("mini.animate").setup({
	scroll = {
		enable = true,
		timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }), -- "total" es la clave
	},
	cursor = {
		enable = true,
		timing = require("mini.animate").gen_timing.linear({ duration = 80, unit = "total" }),
	},
})
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = "n", keys = "<leader>" },
		{ mode = "x", keys = "<leader>" },
		{ mode = "n", keys = "g" }, -- Para gd, gr, etc.
		{ mode = "n", keys = "[" }, -- Navegación
		{ mode = "n", keys = "]" },
	},
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
	},
	window = {
		delay = 300, -- Que aparezca rápido pero no moleste
		config = { border = "rounded", width = "auto" },
	},
})
require("mini.bracketed").setup({
	buffer = { suffix = "b" }, -- [b / ]b para buffers
	comment = { suffix = "c" }, -- [c / ]c para comentarios
	diagnostic = { suffix = "d" }, -- [d / ]d para errores (LSP)
	indent = { suffix = "i" }, -- [i / ]i para saltar por bloques de indentación
	jump = { suffix = "j" }, -- [j / ]j saltos de cursor
	location = { suffix = "l" },
	oldfile = { suffix = "o" },
	quickfix = { suffix = "q" },
	treesitter = { suffix = "t" }, -- [t / ]t salta entre funciones/clases (Backend god)
	undo = { suffix = "u" },
	window = { suffix = "w" },
	yank = { suffix = "y" },
})
