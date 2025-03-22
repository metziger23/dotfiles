return {
	"snacks.nvim",
	keys = {
		{
			"<leader>b",
			function()
				require("snacks").gitbrowse.open()
			end,
			desc = "Git browse",
			mode = { "n", "v" },
		},
	},
	opts = {
		-- patterns to transform remotes to an actual URL
		gitbrowse = {
			url_patterns = {
				["git%.(.*)%.org"] = {
					branch = "/-/tree/{branch}",
					file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
					permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
					commit = "/-/commit/{commit}",
				},
			},
		},
	},
}
