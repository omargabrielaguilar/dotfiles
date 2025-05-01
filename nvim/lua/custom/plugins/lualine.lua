local y_section = {}

if require("nixCatsUtils").enableForCategory("laravel") then
  y_section = {
    {
      function()
        return require("laravel").app("status"):get("laravel")
      end,
      icon = { " ", color = { fg = "#F55247" } },
      cond = function()
        return require("laravel").app("status"):has("laravel")
      end,
    },
    {
      function()
        return require("laravel").app("status"):get("php")
      end,
      icon = { " ", color = { fg = "#AEB2D5" } },
      cond = function()
        return require("laravel").app("status"):has("php")
      end,
    },
    {
      function()
        return require("laravel").app("dev_command"):hostname()
      end,
      icon = { " ", color = { fg = "#8FBC8F" } },
      cond = function()
        return require("laravel").app("dev_command"):isRunning()
      end,
    },
    {
      function()
        return #(require("laravel").app("dump_server"):unseenRecords())
      end,
      icon = { "󰱧 ", color = { fg = "#FFCC66" } },
      cond = function()
        return require("laravel").app("dump_server"):isRunning()
      end,
    },
  }
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    icons_enable = true,
    theme = "auto",
    sections = {
      lualine_y = y_section,
      lualine_c = {
        "filename",
        {
          function()
            local filetype = vim.bo.filetype

            if filetype ~= "lua" then
              return ""
            end

            local node = vim.treesitter.get_node()
            if not node then
              return ""
            end
            while node:type() ~= "function_declaration" do
              node = node:parent()
              if not node then
                return ""
              end
            end

            local function_name_node = node:named_child(0)
            if not function_name_node then
              return ""
            end

            return vim.treesitter.get_node_text(function_name_node, 0)
          end,
          icon = { "󰊕", color = { fg = "#40E0D0" } },
        },
      },
    },
  },
}
