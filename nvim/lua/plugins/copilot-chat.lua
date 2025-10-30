-- ================================================================================================
-- TITLE : GitHub Copilot Chat
-- ABOUT : Interactive AI chat inside Neovim using your GitHub Copilot subscription.
-- LINKS :
--   > github : https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- ================================================================================================

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    model = "gpt-4.1", -- Copilot Premium default
    temperature = 0.1,
    window = {
      layout = "float",
      width = 0.45,
      height = 0.6,
      border = "rounded",
      title = "🤖 Copilot Chat",
      zindex = 100,
    },
    auto_insert_mode = true,
    always_include_buffer = true, -- forza que tome el buffer aunque no esté guardado
    panel = { enabled = false },
    headers = { user = "👤 You", assistant = "🤖 Copilot" },
    separator = "━━",
    auto_fold = true,
  },
  keys = {
    {
      "<leader>cc",
      function()
        vim.cmd("CopilotChatToggle")
      end,
      desc = "Toggle Copilot Chat",
      mode = { "n", "v" },
    },
    {
      "<leader>cbc",
      function()
        require("CopilotChat").ask("#buffer Explain this code", {
          model = "gpt-4.1",
          callback = function(resp)
            vim.notify("Copilot response: " .. resp:sub(1, 50) .. "...")
          end,
        })
      end,
      desc = "Explain buffer in chat",
    },
  },
}

