-- ~/.config/nvim/init.lua

-- Ustawienie klawisza leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Konfiguracja Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    -- WAŻNA ZMIANA: Używamy HTTPS do klonowania samego Lazy.nvim
    -- To zapewnia, że bootstrap Lazy.nvim powiedzie się bez problemów z uwierzytelnianiem SSH/tokenem.
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Ładowanie pluginów z katalogu lua/plugins/
-- Lazy.nvim automatycznie załaduje pliki lua/plugins/*.lua
-- Upewnij się, że każdy z tych plików zwraca tabelę definiującą plugin(y).
local plugins = {
  { import = "plugins" },
}

-- Ustawienia Lazy.nvim
-- UWAGA: Opcja 'git.url_format' będzie używana dla WSZYSTKICH INNYCH pluginów, które Lazy.nvim będzie klonować/aktualizować.
-- Jeśli masz poprawnie skonfigurowane klucze SSH, to powinno działać dla Twoich pluginów.
local opts = {
  defaults = {
    change_dir = true,
    git = {
      url_format = "ssh://git@github.com/%s.git",
    },
  },
}

-- Wywołanie setup dla Lazy.nvim z twoimi pluginami i nowymi opcjami
require("lazy").setup(plugins, opts)

-- Ogólne ustawienia Neovim
vim.cmd.colorscheme 'melange' -- Ustawienie schematu kolorów
vim.opt.clipboard = "unnamedplus" -- Ustawienie schowka systemowego

vim.opt.expandtab = true -- Używaj spacji zamiast tabulacji
vim.opt.tabstop = 2 -- Szerokość tabulacji wyświetlanej na ekranie
vim.opt.softtabstop = 2 -- Ilość spacji wstawianych po naciśnięciu tab (tryb wstawiania)
vim.opt.shiftwidth = 2 -- Ilość spacji używanych do automatycznego wcięcia

vim.opt.winblend = 0 -- Przezroczystość okien (0 = brak przezroczystości)
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Opcje dla autouzupełniania
