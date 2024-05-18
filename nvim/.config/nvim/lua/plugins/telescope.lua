return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
		{ "<leader>fz", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Current Buffer Fuzzy Find" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find Help Tags" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
		{ "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Find Old Files" },
		{ "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "Find Word Under Cursor" },
		{ "<leader>fm", function() require("telescope.builtin").marks() end, desc = "Find Marks" },
		{ "<leader>fM", function() require("telescope.builtin").man_pages() end, desc = "Find Man Pages" },
		{ "<leader>fc", function() require("telescope.builtin").command_history() end, desc = "Command History" },
		{ "<leader>fC", function() require("telescope.builtin").commands() end, desc = "Commands" },
		{ "<leader>fs", function() require("telescope.builtin").search_history() end, desc = "Search History" },
		{ "<leader>fq", function() require("telescope.builtin").quickfixhistory() end, desc = "Quickfix History" },
		{ "<leader>fQ", function() require("telescope.builtin").quickfix() end, desc = "Quickfix" },
		{ "<leader>fl", function() require("telescope.builtin").loclist() end, desc = "Location List" },
		{ "<leader>fj", function() require("telescope.builtin").jumplist() end, desc = "Jump List" },
		{ "<leader>fr", function() require("telescope.builtin").registers() end, desc = "Registers" },
		{ "<leader>fp", function() require("telescope.builtin").resume() end, desc = "Previous Picker's Results" },
		{ "<leader>fP", function() require("telescope.builtin").pickers() end, desc = "List Previous Pickers" },

    -- telescope git pickers
    { "<leader>gc", function() require("telescope.builtin").git_bcommits() end,  desc = "Git commits (current buffer)" },
    { "<leader>gC", function() require("telescope.builtin").git_commits() end,  desc = "Git commits (current directory)" },
    { "<leader>gC", function() require("telescope.builtin").git_bommits_range() end,  desc = "Git commits (range)", mode = "v" },
    { "<leader>gb", function() require("telescope.builtin").git_branches() end,  desc = "Git branches" },
    { "<leader>gs", function() require("telescope.builtin").git_status() end,  desc = "Git status" },
    { "<leader>gS", function() require("telescope.builtin").git_stash() end,  desc = "Git stash" },
    { "<leader>gf", function() require("telescope.builtin").git_files() end,  desc = "Git files" },

	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
