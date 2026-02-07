return {
	"fcancelinha/nordern.nvim",
	branch = "master",
	lazy = false,
	priority = 1001,
	config = function()
		vim.opt.termguicolors = true

		require("nordern").setup({
			brighter_comments = false,
			brighter_constants = false,
			italic_comments = false,
			transparent = true,
		})

		vim.cmd.colorscheme("nordern")

		-- 🔎 Transparencia forzada (anti plugins que pisan bg)
		local transparent_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"LineNr",
			"CursorLineNr",
			"MsgArea",
			"StatusLine",
			"StatusLineNC",

			-- Snacks / floating UI
			"SnacksNotifier",
			"SnacksNotifierBorder",

			-- File explorers
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"OilFloat",

			-- Popup menus
			"Pmenu",
			"PmenuSel",
			"PmenuThumb",
			"PmenuSbar",
		}

		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end

		-- 🎯 Snacks UI fix (contraste limpio)
		local snacks_groups = {
			"SnacksNormal",
			"SnacksBorder",
			"SnacksTitle",
			"SnacksFooter",
			"SnacksBackdrop",
			"SnacksSelection",
		}

		for _, group in ipairs(snacks_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end

		vim.api.nvim_set_hl(0, "SnacksSelection", { bg = "#3B4252" }) -- Nord slate
	end,
}

