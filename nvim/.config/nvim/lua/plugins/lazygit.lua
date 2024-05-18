return {
	"kdheepak/lazygit.nvim",
	keys = {
		{ "<leader>GG", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("lazygit")
    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
	end,
}
