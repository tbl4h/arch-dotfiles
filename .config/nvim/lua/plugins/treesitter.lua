-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Polecenie uruchamiane po instalacji/aktualizacji wtyczki
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Lista języków, dla których chcesz zainstalować parsery.
      -- Możesz dodać więcej, np. "javascript", "typescript", "python", "java", "c", "cpp", "go", "rust", itp.
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "c",
        "cpp",
        "go",
        "rust",
        "python",
      },

      -- Włącz podświetlanie składni
      highlight = {
        enable = true,
        -- Opcjonalnie, możesz wyłączyć highlight dla niektórych języków, aby poprawić wydajność.
        -- disable = { "c", "rust" },
      },

      -- Włącz incremental selection (zaznaczanie składniowo)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>", -- Rozpoczyna zaznaczanie
          node_incremental = "<c-space>", -- Rozszerza zaznaczenie o kolejny węzeł
          scope_incremental = "<c-s>", -- Rozszerza zaznaczenie o szerszy zakres
          node_decremental = "<c-bs>", -- Zmniejsza zaznaczenie
        },
      },

      -- Włącz identyfikację i edycję wokół par nawiasów/bloków
      indent = {
        enable = true,
      },
    })
  end,
}
