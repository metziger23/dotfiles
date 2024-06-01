local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit_cmd = "lazygit -ucf " .. lazygit_config_path

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = lazygit_cmd,
			dir = "git_dir",
			direction = "float",
      float_opts = {
        border = "curved"
      },
		})

		vim.keymap.set({ "n", "t", "x" }, "<A-g><A-g>", function()
			lazygit:toggle()
		end, { desc = "toggleterm: toggle lazygit" })
	end,
}
