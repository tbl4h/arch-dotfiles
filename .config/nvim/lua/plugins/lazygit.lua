-- ~/.config/nvim/lua/plugins/lazygit.lua
return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = { "LazyGit" },
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open Lazygit" },
	},
}
