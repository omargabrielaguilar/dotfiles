-- ================================================================================================
-- TITLE : oil.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- ================================================================================================

return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true, -- reemplaza netrw
		view_options = {
			show_hidden = true,
		},
		float = {
			padding = 2,
			max_width = 80,
			max_height = 30,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
	},
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	lazy = false,
	config = function(_, opts)
		local oil = require "oil"
		oil.setup(opts)

		-- 🚀 INTEGRACIÓN CON SNACKS RENAME
		-- Esto hace que al guardar cambios en Oil, el LSP actualice las rutas
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				local actions = event.data.actions
				for _, action in ipairs(actions) do
					if action.type == "move" then
						-- Snacks detecta el cambio y avisa al LSP
						Snacks.rename.on_rename_file(action.src_url, action.dest_url)
					end
				end
			end,
		})
	end,
}
