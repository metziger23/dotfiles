return {
	"emrearmagan/atlas.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional but recommended
		"esmuellert/codediff.nvim", -- optional (PullRequest diff)
	},
	opts = {
		providers = {
			gitlab = {
				base_url = vim.env.GITLAB_URL,
				token = vim.env.GITLAB_TOKEN,
			},
		},
	},
}
