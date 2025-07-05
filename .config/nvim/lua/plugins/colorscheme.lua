-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  "savq/melange-nvim",
  priority = 1000, -- Upewnij się, że motyw jest ładowany wcześnie
  config = function()
    vim.cmd.colorscheme 'melange'
  end
}
