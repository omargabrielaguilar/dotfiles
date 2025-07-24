return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local autopairs = require("nvim-autopairs") -- import nvim-autopairs

		-- setup autopairs
		autopairs.setup({
			check_ts = true, -- treesitter enabled
			ts_config = {
				lua = { "string" }, -- dont add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- dont add pairs in javascript template_string treesitter nodes
				java = { "string", "comment" },
				go = { "string", "comment" }, -- dont add pairs in go strings and comments
				php = { "string", "heredoc" }, -- dont add pairs in php strings and heredocs
				python = { "string", "docstring" }, -- dont add pairs in python strings and docstrings
			},
		})
		-- import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- import nvim-cmp plugin (completions plugin)
		local cmp = require("cmp")
		-- make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
