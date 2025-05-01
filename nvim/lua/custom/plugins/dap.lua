local dapOpts = {}
if require("nixCatsUtils").enableForCategory("symfony") then
  dapOpts = {
    adapters = { executables = {
      php = {
        command = "php-debug-adapter",
      },
    } },
    configurations = {
      php = {
        {
          type = "php",
          request = "launch",
          name = "Symfony",
          port = 9003,
          pathMappings = {
            ["/app"] = "${workspaceFolder}",
          },
        },
      },
    },
  }
end

if require("nixCatsUtils").enableForCategory("laravel") then
  dapOpts = {
    adapters = { executables = {
      php = {
        command = "php-debug-adapter",
      },
    } },
    configurations = {
      php = {
        {
          type = "php",
          request = "launch",
          name = "Laravel",
          port = 9003,
        },
        {
          type = "php",
          request = "launch",
          name = "Laravel Sail",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      },
    },
  }
end

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    { "mfussenegger/nvim-dap", opts = dapOpts },
    "nvim-neotest/nvim-nio",
  },
  keys = {
    {
      "<leader>dd",
      function()
        require("dap").continue()
      end,
    },
    {
      "<leader>dp",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<leader>dl",
      function()
        require("dap").step_into()
      end,
    },
    {
      "<leader>dj",
      function()
        require("dap").step_over()
      end,
    },
    {
      "<leader>dk",
      function()
        require("dap").step_out()
      end,
    },
    {
      "<leader>dh",
      function()
        require("dapui").eval()
      end,
    },
    {
      "<leader>dc",
      function()
        require("dap").run_to_cursor()
      end,
    },
    {
      "<leader>gc",
      function()
        vim.ui.input({ prompt = "Condition: " }, function(condition)
          if condition == "" then
            return
          end
          require("dap").set_breakpoint(condition)
        end)
      end,
    },
    {
      "<leader>g?",
      function()
        vim.ui.input({ prompt = "Log: " }, function(log)
          if log == "" then
            return
          end
          require("dap").set_breakpoint(nil, nil, log)
        end)
      end,
    },
    {
      "<leader>x",
      function()
        require("dap").terminate()
        require("dapui").close({})
        require("dap").clear_breakpoints()
      end,
    },
  },
  opts = {},
  confi = function(_, opts)
    require("dapui").setup(opts)

    require("dap").listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open({})
    end
  end,
}
