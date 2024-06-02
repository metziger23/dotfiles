local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit_cmd = "lazygit -ucf " .. lazygit_config_path

local lazygit_opts = {
	cmd = lazygit_cmd,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "curved",
	},
}

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local modes = { "n", "t", "x" }
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new(lazygit_opts)
		local lazygit_cur_buf = Terminal:new(lazygit_opts)

		local function lazygit_toggle()
			local dot_git_path = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
			lazygit.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit:toggle()
		end

		vim.keymap.set(modes, "<A-g><A-g>", lazygit_toggle, { desc = "Toggle lazygit" })

		local function lazygit_cur_buf_toggle()
			local dot_git_path = vim.fn.finddir(".git", vim.fn.expand("%:h") .. ";")
			lazygit_cur_buf.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit_cur_buf:toggle()
		end

		vim.keymap.set(modes, "<A-g><A-c>", lazygit_cur_buf_toggle, { desc = "Toggle lazygit (current buffer)" })
	end,
}
