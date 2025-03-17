return {
	{
		"refractalize/oil-git-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		config = true,
	},
	{
		"stevearc/oil.nvim",
		version = "*",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				win_options = {
					winbar = "%{v:lua.require('oil').get_current_dir()}",
					signcolumn = "yes:2", -- NOTE: for oil-git-status
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["<C-h>"] = {
						"actions.select",
						opts = { horizontal = true },
						desc = "Open the entry in a horizontal split",
					},
					["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
					["<M-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = {
						"actions.cd",
						opts = { scope = "tab" },
						desc = ":tcd to the current oil directory",
						mode = "n",
					},
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
				-- Set to false to disable all of the above keymaps
				use_default_keymaps = false,
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set("n", "_", function()
				require("oil").open(vim.fn.getcwd())
			end, { desc = "Open cwd" })
		end,
	},
}
