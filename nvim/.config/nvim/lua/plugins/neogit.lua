return {
	"NeogitOrg/neogit",
  cmd = { "Neogit"--[[ , "Neogit cwd", "Neogit kind", "Neogit commit" ]]},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
  config = true
}
