local builtin = require("telescope.builtin")
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
		{ "<leader>ff", builtin.find_files, desc = "Find Files" },
		{ "<leader>fz", builtin.current_buffer_fuzzy_find, desc = "Current Buffer Fuzzy Find" },
		{ "<leader>fg", builtin.live_grep, desc = "Live Grep" },
		{ "<leader>fh", builtin.help_tags, desc = "Find Help Tags" },
		{ "<leader>fb", builtin.buffers, desc = "Find Buffers" },
		{ "<leader>fo", builtin.oldfiles, desc = "Find Old Files" },
		{ "<leader>fw", builtin.grep_string, desc = "Find Word Under Cursor" },
		{ "<leader>fm", builtin.marks, desc = "Find Marks" },
		{ "<leader>fM", builtin.man_pages, desc = "Find Man Pages" },
		{ "<leader>fc", builtin.command_history, desc = "Command History" },
		{ "<leader>fC", builtin.commands, desc = "Commands" },
		{ "<leader>fs", builtin.search_history, desc = "Search History" },
		{ "<leader>fq", builtin.quickfixhistory, desc = "Quickfix History" },
		{ "<leader>fQ", builtin.quickfix, desc = "Quickfix" },
		{ "<leader>fl", builtin.loclist, desc = "Location List" },
		{ "<leader>fj", builtin.jumplist, desc = "Jump List" },
		{ "<leader>fr", builtin.registers, desc = "Registers" },
		{ "<leader>fp", builtin.resume, desc = "Previous Picker's Results" },
		{ "<leader>fP", builtin.pickers, desc = "List Previous Pickers" },
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
