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

local default_toggleterm_opts = {
  direction = "float",
  float_opts = {
    border = "curved",
  },
}

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
    float_opts = {
      border = "curved",
    }
  },
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local modes = { "n", "t", "x" }
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new(vim.deepcopy(lazygit_opts))
		local lazygit_cur_buf = Terminal:new(vim.deepcopy(lazygit_opts))
		local lazygit_filter_cur_buf = Terminal:new(vim.deepcopy(lazygit_opts))
    local default_toggleterm = Terminal:new(vim.deepcopy(default_toggleterm_opts))

    vim.keymap.set(modes, "<A-j>", function ()
      default_toggleterm:toggle()
    end, { desc = "Toggle default Toggleterm" })


		local function lazygit_toggle()
			local dot_git_path = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
			lazygit.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit:toggle()
		end

		vim.keymap.set(modes, "<A-g><A-g>", lazygit_toggle, { desc = "Toggle lazygit" })

		local function lazygit_cur_buf_toggle()
			local dot_git_path = vim.fn.finddir(".git", ".;")
			lazygit_cur_buf.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit_cur_buf:toggle()
		end

		vim.keymap.set(modes, "<A-g><A-b>", lazygit_cur_buf_toggle, { desc = "Toggle lazygit (current buffer)" })

		local function lazygit_filter_cur_buf_toggle()
			lazygit_filter_cur_buf.cmd = lazygit_cmd .. " --filter " .. vim.fn.expand("%:p")
      local dot_git_path = vim.fn.finddir(".git", ".;")
      lazygit_filter_cur_buf.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit_filter_cur_buf:toggle()
		end

		vim.keymap.set(
			modes,
			"<A-g><A-f>",
			lazygit_filter_cur_buf_toggle,
			{ desc = "Toggle lazygit (filter current buffer)" }
		)
	end,
}
