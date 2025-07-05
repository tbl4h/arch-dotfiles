-- ~/.config/nvim/init.lua

-- Ustawienie klawisza leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Konfiguracja Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		-- ZMIEŃ TĘ LINIĘ NA SSH:
		"git@github.com:folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Ładowanie pluginów z katalogu lua/plugins/
local plugins = {
	-- Lazy.nvim automatycznie załaduje pliki lua/plugins/*.lua
	{ import = "plugins" },
}

-- Ustawienia Lazy.nvim
-- WAŻNE: Dodano tutaj konfigurację dla Git (użycie SSH)
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
vim.cmd.colorscheme("melange")
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.winblend = 0
vim.opt.completeopt = { "menu", "menuone", "noselect" }
