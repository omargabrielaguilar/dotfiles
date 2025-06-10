return {
	"jghauser/fold-cycle.nvim",
	config = function()
		require("fold-cycle").setup({
			open_if_max_closed = true, -- closing a fully closed fold will open it
			close_if_max_opened = true, -- opening a fully open fold will close it
			softwrap_movement_fix = false, -- see below
		})
		vim.keymap.set("n", "<tab>", function()
			return require("fold-cycle").open()
		end, { silent = true, desc = "Fold-cycle: open folds" })
		vim.keymap.set("n", "<s-tab>", function()
			return require("fold-cycle").close()
		end, { silent = true, desc = "Fold-cycle: close folds" })
		vim.keymap.set("n", "zC", function()
			return require("fold-cycle").close_all()
		end, { remap = true, silent = true, desc = "Fold-cycle: close all folds" })
	end,
}
