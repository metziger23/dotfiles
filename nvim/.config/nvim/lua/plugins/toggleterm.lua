local function setup_terminal(configuration)
	local term_opts = {
		direction = "float",
		float_opts = {
			border = "curved",
		},
	}

	if configuration.term_opts then
		term_opts = vim.tbl_deep_extend("force", term_opts, configuration.term_opts or {})
	end

	term_opts.on_open = function(term)
		local opts = { buffer = term.bufnr, noremap = true, silent = true }
		opts.desc = configuration.desc
		vim.keymap.set("t", configuration.keymap, function()
			term:toggle()
		end, opts)
	end

	local term = require("toggleterm.terminal").Terminal:new(term_opts)

	local function toggle()
		if configuration.toggle_pre_hook then
			configuration.toggle_pre_hook(term)
		end
		term:toggle()
	end

	local opts = { noremap = true, silent = true }
	opts.desc = configuration.desc
	vim.keymap.set("n", configuration.keymap, toggle, opts)
end

local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit_cmd = "lazygit -ucf " .. lazygit_config_path

local lazygit_opts = {
	cmd = lazygit_cmd,
	dir = "git_dir",
}

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

		local main_term_config = { keymap = "<M-C-t>", desc = "Toggle main Toggleterm" }
		setup_terminal(main_term_config)

		local lazygit_config = {
			keymap = "<M-g>",
			desc = "Toggle Lazygit",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				local dot_git_path = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
				term.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			end,
		}

		setup_terminal(lazygit_config)

		local lazygit_cur_buf_config = {
			keymap = "<M-C-G>",
			desc = "Toggle Lazygit (current buffer)",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				term.dir = require("snacks").git.get_root()
			end,
		}

		setup_terminal(lazygit_cur_buf_config)

		local lazygit_log_cur_buf_config = {
			keymap = "<M-j>",
			desc = "Toggle lazygit (log current buffer)",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				term.cmd = lazygit_cmd .. " --filter " .. vim.fn.expand("%:p")
				local dot_git_path = vim.fn.finddir(".git", ".;")
				term.dir = vim.fn.fnamemodify(dot_git_path, ":h")
			end,
		}

		setup_terminal(lazygit_log_cur_buf_config)
	end,
}
