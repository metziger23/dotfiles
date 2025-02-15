local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit_cmd = "lazygit -ucf " .. lazygit_config_path

local main_toggleterm_opts = {
	direction = "float",
	float_opts = {
		border = "curved",
	},
}

local lazygit_opts = vim.tbl_deep_extend("force", main_toggleterm_opts, {
	cmd = lazygit_cmd,
	dir = "git_dir",
	on_open = function(term)
		local opts = { buffer = term.bufnr, noremap = true, silent = true }
		opts.desc = "Toggle Lazygit"
		vim.keymap.set("t", "<M-g>", function()
			term:toggle()
		end, opts)
	end,
})

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
		float_opts = {
			border = "curved",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local modes = { "n", "t", "x" }
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new(vim.deepcopy(lazygit_opts))
		local lazygit_cur_buf = Terminal:new(vim.deepcopy(lazygit_opts))
		local lazygit_filter_cur_buf = Terminal:new(vim.deepcopy(lazygit_opts))
		local main_toggleterm = Terminal:new(vim.deepcopy(main_toggleterm_opts))

		vim.keymap.set({ "n", "t", "x" }, "<M-C-t>", function()
			main_toggleterm:toggle()
		end, { desc = "Toggle main Toggleterm" })

		local function lazygit_toggle()
			local dot_git_path = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
			lazygit.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit:toggle()
		end

		vim.keymap.set("n", "<M-g>", lazygit_toggle, { desc = "Toggle lazygit" })

		local function lazygit_cur_buf_toggle()
			-- local dot_git_path = vim.fn.finddir(".git", ".;")
			lazygit_cur_buf.dir = require("snacks").git.get_root()
			lazygit_cur_buf:toggle()
		end

		vim.keymap.set("n", "<M-C-G>", lazygit_cur_buf_toggle, { desc = "Toggle lazygit (current buffer)" })

		local function lazygit_filter_cur_buf_toggle()
			lazygit_filter_cur_buf.cmd = lazygit_cmd .. " --filter " .. vim.fn.expand("%:p")
			local dot_git_path = vim.fn.finddir(".git", ".;")
			lazygit_filter_cur_buf.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			lazygit_filter_cur_buf:toggle()
		end

		vim.keymap.set(
			"n",
			"<leader>gl",
			lazygit_filter_cur_buf_toggle,
			{ desc = "Toggle lazygit (log current buffer)" }
		)
	end,
}
