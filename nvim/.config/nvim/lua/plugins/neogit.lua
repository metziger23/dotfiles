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
	},
	keys = {
		{ "<leader>n", "<cmd>Neogit<cr>", desc = "Neogit" },
		{
			"<leader>N",
			function()
				if vim.bo.filetype == "oil" then
					local cur_dir = require("oil").get_current_dir(0)
					require("neogit").open({ cwd = cur_dir })
				else
					require("neogit").open({ cwd = vim.fn.expand("%:p:h") })
				end
			end,
			desc = "Neogit in current buffer directory",
		},
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
				["l"] = false,
				["<M-l>"] = "LogPopup",
			},
			status = {
				["1"] = false,
				["2"] = false,
				["3"] = false,
				["4"] = false,
				["<M-1>"] = "Depth1",
				["<M-2>"] = "Depth2",
				["<M-3>"] = "Depth3",
				["<M-4>"] = "Depth4",
			},
		},
	},
}
