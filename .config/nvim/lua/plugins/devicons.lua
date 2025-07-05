-- ~/.config/nvim/lua/plugins/devicons.lua
return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- Twoja konfiguracja devicons, jeśli jest potrzebna
    })
  end,
}
