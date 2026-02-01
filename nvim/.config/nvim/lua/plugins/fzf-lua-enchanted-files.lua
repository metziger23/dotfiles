return {
	"metziger23/fzf-lua-enchanted-files",
	dependencies = { "ibhagwan/fzf-lua" },
	keys = {
		{
			"<BS><tab>",
			function()
				require("fzf-lua-enchanted-files").files()
			end,
			desc = "Fzf enchanted files",
			mode = { "n", "x" },
		},
	},
	config = function()
		-- Modern configuration using vim.g
		vim.g.fzf_lua_enchanted_files = {
			-- Maximum number of files to remember per working directory
			max_history_per_cwd = 50,

			-- Custom history file location (optional)
			-- history_file = vim.fn.stdpath("data") .. "/fzf-lua-enchanted-files.json",

			-- Automatically add opened files to history (default: false)
			auto_history = true,
		}
	end,
}
