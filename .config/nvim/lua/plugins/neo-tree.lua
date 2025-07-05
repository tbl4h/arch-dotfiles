-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x", -- Upewnij się, że używasz odpowiedniej gałęzi (obecnie v3.x)
  dependencies = {
    "nvim-lua/plenary.nvim", -- Wymagane
    "nvim-tree/nvim-web-devicons", -- Opcjonalnie, ale zalecane dla ikon
    "MunifTanjim/nui.nvim", -- Wymagane
  },
  cmd = "Neotree", -- Pozwala Lazy.nvim na załadowanie wtyczki tylko po użyciu komendy
  keys = {
    { "<leader>e", "<cmd>Neotree filesystem reveal toggle<cr>", desc = "Toggle Neo-Tree (File Explorer)" },
  },
  config = function()
    require("neo-tree").setup({
      -- Podstawowa konfiguracja Neo-Tree
      close_if_last_window = true, -- Zamknij Neo-Tree, jeśli jest ostatnim oknem
      enable_git_status = true, -- Włącz wyświetlanie statusu Git
      enable_diagnostics = true, -- Włącz wyświetlanie diagnostyki (LSP)
      sort_hybrid_collapse_supported_filetypes = true, -- Poprawne sortowanie dla niektórych typów plików

      filesystem = {
        -- Konfiguracja dla widoku systemu plików
        filtered_items = {
          visible = true, -- Pokaż filtrowane elementy (np. .git, node_modules)
          hide_hidden = true, -- Ukryj pliki/katalogi zaczynające się od '.'
          hide_dotfiles = true, -- To samo co hide_hidden, ale dla jasności
          hide_git_ignored = true, -- Ukryj pliki ignorowane przez Git
          hide_link_destinations = true, -- Ukryj cel linków symbolicznych
        },
        window = {
          position = "left", -- Pozycja drzewa: "left", "right", "float"
          width = 30, -- Szerokość drzewa
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },
      },
      buffers = {
        -- Konfiguracja dla widoku buforów
        follow_current_file = {
          enabled = true, -- Śledź aktualnie otwarty plik
        },
        group_empty_dirs = true,
        show_unloaded = true,
      },
      git_status = {
        -- Konfiguracja dla widoku statusu Git
        window = {
          position = "float", -- Uruchom widok Git w pływającym oknie
          width = 60,
          height = 20,
        },
      },
    })
  end,
}
