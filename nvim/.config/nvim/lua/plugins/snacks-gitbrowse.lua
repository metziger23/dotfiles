return {
	"snacks.nvim",
	keys = {
		{
			"<leader>b",
			function()
				require("snacks").gitbrowse({
					open = function(url)
						vim.fn.setreg("+", url)
					end,
				})
			end,
			desc = "Git browse (copy)",
			mode = { "n", "x" },
		},
		{
			"<leader>B",
			function()
				require("snacks").gitbrowse.open()
			end,
			desc = "Git browse",
			mode = { "n", "x" },
		},
	},
	opts = {
		-- patterns to transform remotes to an actual URL
		gitbrowse = {
			url_patterns = {
				["gitlab%.(.*)%.ru"] = {
					branch = "/-/tree/{branch}",
					file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
					permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
					commit = "/-/commit/{commit}",
				},
			},
		},
	},
}
