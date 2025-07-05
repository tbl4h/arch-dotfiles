-- ~/.config/nvim/lua/plugins/dap.lua

return {
  "mfussenegger/nvim-dap",               -- Główny framework DAP
  dependencies = {
    "rcarriga/nvim-dap-ui",              -- UI dla DAP
    "nvim-telescope/telescope-dap.nvim", -- Opcjonalnie: integracja z Telescope
    -- Pamiętaj, że adaptery (codelldb, debugpy) są instalowane przez Masona
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    --print("DEBUG: Zawartość obiektu 'dap' po require:", vim.inspect(dap)) -- <--- DODAĆ TĘ LINIĘ!

    -- Konfiguracja dapui (interfejsu użytkownika debugera)
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 0.30, -- Szerokość bocznego panelu
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 0.25, -- Wysokość dolnego panelu
          position = "bottom",
        },
      },
    })

    -- Mapowania klawiszy dla debugera
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "DAP: Set Conditional Breakpoint" })
    vim.keymap.set("n", "<leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "DAP: Set Logpoint" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
    vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DAP: Toggle UI" })
    vim.keymap.set("n", "<leader>da", dap.disconnect, { desc = "DAP: Disconnect" })
    vim.keymap.set("n", "<leader>dc", dap.close, { desc = "DAP: Close" })
    --vim.keymap.set("n", "<leader>de", dap.eval, { desc = "DAP: Evaluate" })
    vim.keymap.set("n", "<leader>dgr", dap.run_last, { desc = "DAP: Run Last" })

    -- Hooki do otwierania/zamykania UI wraz z debugerem
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Konfiguracja adaptera debugowania codelldb (dla Rust i C/C++)
    local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    if vim.fn.isdirectory(vim.fn.stdpath("data") .. "/mason/packages/codelldb") then
      codelldb_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb")
      -- Pamiętaj o ustawieniu LD_LIBRARY_PATH dla Linux/WSL, jeśli są problemy z liblldb.so
      -- lub odpowiednio PATH dla Windows
      dap.adapters.codelldb = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
          env = {
            LD_LIBRARY_PATH = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib",
          },
        },
      }
    else
      vim.notify("codelldb is not installed via Mason. Please install it.", vim.log.levels.WARN)
    end

    -- Konfiguracja launch dla Rust
    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
      },
      {
        name = "Launch current file",
        type = "codelldb",
        request = "launch",
        program = function()
          local bin_name = vim.fn.fnamodify(vim.fn.expand("%:t"), ":r")
          return vim.fn.getcwd() .. "/target/debug/" .. bin_name
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
      },
    }

    -- Konfiguracja launch dla C/C++
    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- Konfiguracja adaptera debugowania debugpy (dla Pythona)
    -- Zakładamy, że debugpy jest zainstalowany przez Masona
    local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/debugpy"
    if vim.fn.isdirectory(vim.fn.stdpath("data") .. "/mason/packages/debugpy") then
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/python",
        args = { debugpy_path, "-m", "debugpy.adapter" },
      }
    else
      vim.notify("debugpy is not installed via Mason. Please install it.", vim.log.levels.WARN)
    end

    -- Konfiguracja launch dla Pythona
    dap.configurations.python = {
      {
        name = "Launch file",
        type = "python",
        request = "launch",
        program = "${file}",
        pythonPath = function()
          local venv = os.getenv("VIRTUAL_ENV")
          if venv then
            return venv .. "/bin/python"
          else
            return vim.fn.stdpath("data") .. "/mason/bin/python"
          end
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
      },
      {
        name = "Attach to remote",
        type = "python",
        request = "attach",
        host = "127.0.0.1",
        port = 5678,
        cwd = "${workspaceFolder}",
      },
    }
  end,
}
