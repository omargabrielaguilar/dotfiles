-- ================================================================================================
-- TITLE : intelephense (PHP Language Server) LSP Setup
-- LINKS :
--   > https://github.com/bmewburn/intelephense-docs
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("intelephense", {
		capabilities = capabilities,
		init_options = {
			-- storagePath = vim.fn.stdpath("cache") .. "/intelephense",
			-- globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",

			licenceKey = "00D0IEADQVBNA0K",
			clearCache = false,
		},
		settings = {
			intelephense = {
				files = {
					maxSize = 1000000, -- 1MB por archivo (default)
				},
			},
		},
	})
end
