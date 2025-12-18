-- ================================================================================================
-- TITLE : omnisharp (C# Language Server) LSP Setup
-- LINKS :
--   > https://github.com/OmniSharp/omnisharp-roslyn
-- ================================================================================================

local omnisharp_path = vim.fn.expand("~/.local/share/nvim/mason/bin/OmniSharp")
-- asegurate que la ruta sea correcta y todo minúscula

--- @param capabilities table LSP client capabilities (e.g., from nvim-cmp)
--- @return nil
return function(capabilities)
	vim.lsp.config("omnisharp", {
		cmd = { omnisharp_path, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
		capabilities = capabilities,
		init_options = {
			RoslynExtensionsOptions = {
				EnableAnalyzersSupport = true,
				EnableDecompilationSupport = true,
				LocationPaths = {},
			},
			FormattingOptions = {
				EnableEditorConfigSupport = true,
			},
		},
		settings = {
			omnisharp = {
				useModernNet = true, -- usa .NET 6/7/8 en lugar de mono
			},
		},
	})
end
