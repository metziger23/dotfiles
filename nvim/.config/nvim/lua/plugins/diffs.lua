return {
	"https://forge.barrettruth.com/barrettruth/diffs.nvim",
	dependencies = {
		"https://github.com/phanen/blame_hl.nvim",
	},
	init = function()
		vim.g.diffs = {
			integrations = {
				fugitive = true,
				neogit = true,
				gitsigns = true,
			},
		}
		-- NOTE: for some reason gitsigns integration doesn't always work
		-- run this when both gitsigns.nvim/diffs.nvim on rtp
		require("blame_hl").patch()
	end,
}
