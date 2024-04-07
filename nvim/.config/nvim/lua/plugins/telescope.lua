return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
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

		local builtin = require("telescope.builtin")
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		keymap.set("n", "<leader>fF", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy Find" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
		keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word Under Cursor" })
		keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find Marks" })
		keymap.set("n", "<leader>fM", builtin.man_pages, { desc = "Find Man Pages" })
		keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command History" })
		keymap.set("n", "<leader>fC", builtin.commands, { desc = "Commands" })
		keymap.set("n", "<leader>fs", builtin.search_history, { desc = "Search History" })
		keymap.set("n", "<leader>fq", builtin.quickfixhistory, { desc = "Quickfix History" })
		keymap.set("n", "<leader>fQ", builtin.quickfix, { desc = "Quickfix" })
		keymap.set("n", "<leader>fl", builtin.loclist, { desc = "Location List" })
		keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jump List" })
		keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
		keymap.set("n", "<leader>fp", builtin.resume, { desc = "Previous Picker's Results" })
		keymap.set("n", "<leader>fP", builtin.pickers, { desc = "List Previous Pickers" })
	end,
}
