-- ================================================================================================
-- TITLE : intelephense (PHP Language Server) LSP Setup
-- LINKS :
--   > https://github.com/bmewburn/intelephense-docs
-- ================================================================================================

local license_path = vim.fn.expand("~/.local/share/intelephense/license.txt")
local licence_key = ""
do
	local f = io.open(license_path, "r")
	if f then
		licence_key = f:read("*l") or ""
		f:close()
	end
end

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("intelephense", {
		capabilities = capabilities,
		init_options = {
			licenceKey = licence_key,
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
