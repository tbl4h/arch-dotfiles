-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6", -- Zaleca się użycie konkretnego tagu/wersji
  dependencies = {
    "nvim-lua/plenary.nvim", -- Obowiązkowa zależność dla Telescope
    "nvim-telescope/telescope-ui-select.nvim", -- Dodaj tę linię dla ui-select
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      -- Tutaj możesz dodać swoją główną konfigurację Telescope
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
          },
        },
      },
      -- Konfiguracja rozszerzeń
      extensions = {
        ["ui-select"] = {
          -- Możesz dostosować wygląd i zachowanie ui-select
          -- Użyj motywu 'dropdown' lub 'ivy' dla ui-select
          require("telescope.themes").get_dropdown({
            -- Ustawienia dla okna ui-select
            -- winblend = 10,
            -- previewer = false,
          }),
        },
      },
    })

    -- Ważne: Załaduj rozszerzenia Telescope po ich skonfigurowaniu
    telescope.load_extension("ui-select")

    -- Mapowanie klawiszy (przykład)
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })

    -- Dodatkowe mapowania wykorzystujące ui-select
    -- Przykładowe użycie ui-select dla find_files:
    vim.keymap.set("n", "<leader>tf", function()
      require("telescope.builtin").find_files({
        -- Możesz tutaj podać niestandardowe findery, previewery, sortery
        -- Aby użyć ui-select, po prostu ustaw 'theme'
        theme = "ui-select",
      })
    end, { desc = "Find files (UI Select)" })

    -- Inne użycia ui-select, np. dla grep_string
    vim.keymap.set("n", "<leader>ts", function()
      require("telescope.builtin").grep_string({
        search = vim.fn.input("Grep > "),
        theme = "ui-select",
      })
    end, { desc = "Grep String (UI Select)" })

    -- Jeśli chcesz, aby np. domyślne find_files zawsze używało ui-select,
    -- możesz zaktualizować istniejące mapowanie:
    -- vim.keymap.set("n", "<leader>ff", function()
    --   builtin.find_files({ theme = "ui-select" })
    -- end, { desc = "Find files (UI Select Default)" })

  end,
}
