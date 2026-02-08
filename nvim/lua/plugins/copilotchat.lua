return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim" },
	},
	build = "make utf8",
	opts = {
		debug = false,
		-- Configuración de la ventana
		window = {
			layout = "float", -- Ventana flotante para no romper tu layout de Laravel
			width = 0.8,
			height = 0.8,
			relative = "editor",
			border = "rounded",
		},
		-- Prompts personalizados (¡Aquí está el poder!)
		prompts = {
			Explain = "Explica cómo funciona este código de forma concisa.",
			Review = "Revisa este código buscando bugs o mejoras de rendimiento.",
			Tests = "Genera tests unitarios usando Pest Framework para este código Laravel.",
			Refactor = "Refactoriza este código para seguir los principios SOLID y Clean Code.",
		},
	},
	keys = {
		{ "<leader>cc", ":CopilotChatToggle<cr>", desc = "CopilotChat: Abrir/Cerrar" },
		{ "<leader>ce", ":CopilotChatExplain<cr>", desc = "CopilotChat: Explicar código" },
		{ "<leader>cr", ":CopilotChatReview<cr>", desc = "CopilotChat: Revisar código" },
		{ "<leader>cf", ":CopilotChatFix<cr>", desc = "CopilotChat: Corregir código" },
		-- Chat libre con lo que tengas seleccionado visualmente
		{ "<leader>cv", ":CopilotChatVisual", mode = "x", desc = "CopilotChat: Chat Visual" },
	},
}
