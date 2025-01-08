local function get_graph_style()
  return string.match(vim.env.TERM, "kitty") and "kitty" or "ascii"
end

return {
	"NeogitOrg/neogit",
	cmd = {
		"Neogit" --[[ , "Neogit cwd", "Neogit kind", "Neogit commit" ]],
	},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"ibhagwan/fzf-lua",
	},
	keys = {
		{ "<leader>g", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
	config = true,
	opts = {
    disable_line_numbers = false,
    disable_relative_line_numbers = false,
    graph_style = get_graph_style(),
    mappings = {
      popup = {
        ["<M-m>"] = "RemotePopup",
        ["M"] = false,
      },
      status = {
        ["1"]      = false,
        ["2"]      = false,
        ["3"]      = false,
        ["4"]      = false,
        ["<M-1>"]  = "Depth1",
        ["<M-2>"]  = "Depth2",
        ["<M-3>"]  = "Depth3",
        ["<M-4>"]  = "Depth4",
      }
    },
 },
}
