vim.opt.termguicolors = true

local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

local function get_saved_theme()
	local f = io.open(theme_file, "r")

	if f then
		local theme = f:read("*l")
		f:close()

		if theme and theme ~= "" then
			return theme:match("^%s*(.-)%s*$")
		end
	end

	return "defaul"
end

local function set_transparent()
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}

	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end

	vim.api.nvim_set_hl(0, "TabLineFill", {
		bg = "none",
		fg = "#767676",
	})
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",

	callback = function(args)
		local new_theme = vim.g.colors_name or args.match

		if new_theme then
			local f = io.open(theme_file, "w")

			if f then
				f:write(new_theme)
				f:close()
			end
		end

		set_transparent()
	end,
})

-- Al final de tu core/theme.lua
local current_theme = get_saved_theme()
local ok = pcall(vim.cmd.colorscheme, current_theme)
if not ok then
	vim.cmd.colorscheme("default")
end
set_transparent()
