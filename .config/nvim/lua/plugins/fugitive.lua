-- ~/.config/nvim/lua/plugins/fugitive.lua
return {
	"tpope/vim-fugitive",
	lazy = true, -- Ładuj wtyczkę tylko wtedy, gdy jest potrzebna
	cmd = {
		"Git",
		"G",
		"Gdiff",
		"Gblame",
		"Glog",
		"Gread",
		"Gwrite",
		"Gmove",
		"Gdelete",
		"Gstatus",
		"Gcommit",
		"Gpush",
		"Gpull",
	},
	keys = {
		{ "<leader>gs", "<cmd>Git status<cr>", desc = "Git Status" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
		{ "<leader>gll", "<cmd>Git pull<cr>", desc = "Git Pull" },
		-- Dodatkowe mapowania, jeśli chcesz:
		--{ '<leader>gd', '<cmd>Gdiff<cr>', desc = 'Git Diff' },
		-- { '<leader>gb', '<cmd>Gblame<cr>', desc = 'Git Blame' },
	},
}
