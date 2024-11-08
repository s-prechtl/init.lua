return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      ui.setup()

      local gdb = vim.fn.exepath("gdb")
      if gdb ~= "" then
        dap.adapters.gdb = {
          type = "executable",
          command = "gdb",
          args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.configurations.c = {
          {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = vim.fn.getcwd() .. '/target/main.o',
            -- program = function()
            --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            -- end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = true,
            debugmode = "file",
          },
          -- {
          --   name = "Select and attach to process",
          --   type = "gdb",
          --   request = "attach",
          --   program = function()
          --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          --   end,
          --   pid = function()
          --     local name = vim.fn.input('Executable name (filter): ')
          --     return require("dap.utils").pick_process({ filter = name })
          --   end,
          --   cwd = '${workspaceFolder}'
          -- },
          -- {
          --   name = 'Attach to gdbserver :1234',
          --   type = 'gdb',
          --   request = 'attach',
          --   target = 'localhost:1234',
          --   program = function()
          --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          --   end,
          --   cwd = '${workspaceFolder}'
          -- },
        }
      end

      -- Evaluate expression under cursor
      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      -- Keymaps
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<F5>", dap.restart)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F3>", dap.step_into)
      vim.keymap.set("n", "<F2>", dap.step_over)

      -- Open and close DAP UI
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end
  }
}
