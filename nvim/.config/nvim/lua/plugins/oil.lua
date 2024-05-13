return {
	"stevearc/oil.nvim",
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
      },
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
