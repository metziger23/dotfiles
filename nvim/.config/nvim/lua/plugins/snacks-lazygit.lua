return {
	"folke/snacks.nvim",
	opts = {
		lazygit = {
			-- your lazygit configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	keys = {
		{
			"<M-g>",
			function()
				local float_term = require("snacks").lazygit()
        local created_buffer = float_term.buf
        vim.api.nvim_buf_set_keymap(
          created_buffer, "t", "<M-g>", "<cmd>close<CR>", { desc = "Toggle Lazygit" })
			end,
			desc = "Lazygit",
		},
		{
			"<M-C-g>",
			function()
				require("snacks").lazygit({ cwd = require("snacks").git.get_root() })
			end,
			desc = "Lazygit current buffer git root",
		},
	},
}
