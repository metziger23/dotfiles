local function get_graph_style()
  local term = vim.env.TERM
  if string.match(term, "kitty") then
    return "kitty"
  end
  return "ascii"
end

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
  opts = { graph_style = get_graph_style() },
  config = true
}
