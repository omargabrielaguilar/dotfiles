-- ================================================================================================
-- TITLE : ts_ls (TypeScript Language Server) LSP Setup - VUE & TS HYBRID MODE 🚀
-- LINKS :
--   > https://github.com/typescript-language-server/typescript-language-server
--   > https://github.com/vuejs/language-tools
-- ================================================================================================

--- @param capabilities table LSP client capabilities
--- @return nil
return function(capabilities)
	-- Localizamos el plugin de Volar (debe estar instalado via Mason)
	-- Esto permite que TS entienda qué hay dentro de los bloques <script> de Vue
	local vue_plugin_path = vim.fn.expand(
		"$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
	)

	vim.lsp.config("ts_ls", {
		capabilities = capabilities,

		-- Añadimos "vue" a los filetypes para que el servidor se active en ellos
		filetypes = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
		},

		init_options = {
			-- 🔌 PLUGIN DE VUE: La magia para que TS entienda archivos .vue
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vue_plugin_path,
					languages = { "javascript", "typescript", "vue" },
				},
			},
			preferences = {
				includeCompletionsForImportStatements = true,
				includeCompletionsWithSnippetText = true,
				includeCompletionsWithInsertText = true,
			},
		},

		settings = {
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					completeFunctionCalls = true,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				format = {
					indentSize = 2,
					convertTabsToSpaces = true,
				},
			},
			javascript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					completeFunctionCalls = true,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayVariableTypeHints = true,
				},
			},
		},
	})
end
