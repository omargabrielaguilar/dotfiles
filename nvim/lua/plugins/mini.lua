
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