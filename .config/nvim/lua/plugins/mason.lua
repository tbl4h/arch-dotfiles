-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  lazy = false, -- Mason musi być ładowany wcześnie
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        --keymaps = {
        --toggle_package_update = "<CR>",
        --install_package = "i",
        --update_package = "u",
        --check_package_version = "c",
        -- ... inne mapowania klawiszy
        --},
      },
      -- Możesz tutaj skonfigurować, gdzie Mason będzie przechowywał pliki
      ensure_installed = {
        "lua_ls", -- Serwer językowy dla Lua
        "stylua", -- Formatter dla Lua
        --   "html-lsp", -- Serwer językowy dla HTML
        --   "css-lsp",  -- Serwer językowy dla CSS
        --   "prettier", -- Formatter dla wielu języków
        --   "debugpy",  -- Debugger dla Pythona
        "pyright",
      },
    })
  end,
}
