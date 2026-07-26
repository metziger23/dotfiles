return {
	"barrettruth/diffs.nvim",
	init = function()
		vim.g.diffs = {
			integrations = {
				fugitive = true,
				neogit = true,
				gitsigns = true,
			},
		}
	end,
}
