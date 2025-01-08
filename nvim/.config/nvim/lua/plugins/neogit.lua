local function get_graph_style()
  return string.match(vim.env.TERM, "kitty") and "kitty" or "ascii"
end

return {
	"NeogitOrg/neogit",
  cmd = { "Neogit"--[[ , "Neogit cwd", "Neogit kind", "Neogit commit" ]]},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
    "ibhagwan/fzf-lua",
	},
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
  opts = { graph_style = get_graph_style() },
  config = true
}
