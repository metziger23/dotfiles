local function setup_move_to_diagnostics_keymaps(opts)
	local hydra_utils = require("../utils/hydra_utils")

	local diagnostics = { { "error", "e" }, { "warning", "w" } }

	for _, diag in ipairs(diagnostics) do
		local pattern, key = diag[1], diag[2]
		hydra_utils.setup_bidirectional_hydra("n", pattern, "[" .. key, "]" .. key, function()
			if vim.fn.search(pattern, "bWs") == 0 then
				vim.notify(pattern .. " not found")
			end
		end, function()
			if vim.fn.search(pattern, "Ws") == 0 then
				vim.notify(pattern .. " not found")
			end
		end, opts)
	end
end

local utils = require("../utils/utils")

local prev_win_configs = {}

-- NOTE: copied this from snacks.git and removed the part related to the cache
--- Gets the git root for a buffer or path.
--- Defaults to the current buffer.
---@param path? number|string buffer or path
---@return string?
local function get_root(path)
	path = path or 0
	path = type(path) == "number" and vim.api.nvim_buf_get_name(path) or path --[[@as string]]
	path = vim.fs.normalize(path)
	path = path == "" and (vim.uv or vim.loop).cwd() or path

	local todo = { path } ---@type string[]
	for dir in vim.fs.parents(path) do
		table.insert(todo, dir)
	end

	for _, dir in ipairs(todo) do
		if (vim.uv or vim.loop).fs_stat(dir .. "/.git") ~= nil then
			return vim.fs.normalize(dir) or nil
		end
	end

	return os.getenv("GIT_WORK_TREE")
end

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
		local size_changed = false

		local win_config = vim.api.nvim_win_get_config(term.window)
		local prev_win_config = prev_win_configs[configuration.keymap]

		if
			prev_win_config ~= nil
			and prev_win_config.width ~= nil
			and prev_win_config.height ~= nil
			and win_config.width ~= nil
			and win_config.height ~= nil
		then
			if win_config.width ~= prev_win_config.width or win_config.height ~= prev_win_config.height then
				size_changed = true
			end
		end

		prev_win_configs[configuration.keymap] = win_config

		if size_changed then
			vim.api.nvim_input([[<C-\><C-n>^i]])
		else
			vim.cmd.startinsert()
		end

		utils.setup_new_tab_breakout_keymap(term.bufnr)
		local opts = { buffer = term.bufnr, noremap = true, silent = true }
		opts.desc = configuration.desc
		vim.keymap.set("t", configuration.keymap, function()
			term:toggle()
		end, opts)

		vim.api.nvim_create_autocmd({ "VimResized" }, {
			buffer = term.bufnr,
			callback = function()
				vim.api.nvim_input([[<C-\><C-n>^i]])
			end,
		})
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
		persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
		float_opts = {
			border = "curved",
		},
		-- NOTE: workaround used to stop overseer toggleterm from opening in terminal mode
		start_in_insert = false,
		on_open = function(term)
			vim.cmd.startinsert()
			utils.setup_new_tab_breakout_keymap(term.bufnr)
		end,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "toggleterm",
			callback = function(event)
				local move_to_diagnostics_opts = { buffer = event.buf, silent = true, noremap = true }
				setup_move_to_diagnostics_keymaps(move_to_diagnostics_opts)
			end,
		})

		local main_term_config = {
			keymap = "<M-C-t>",
			desc = "Toggle main Toggleterm",
			toggle_pre_hook = function(term)
				term.dir = vim.fn.getcwd()
			end,
		}
		setup_terminal(main_term_config)

		local lazygit_config = {
			keymap = "<M-g>",
			desc = "Toggle Lazygit",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				term.dir = vim.fn.getcwd()
			end,
		}

		setup_terminal(lazygit_config)

		local lazygit_cur_buf_config = {
			keymap = "<M-C-G>",
			desc = "Toggle Lazygit (current buffer)",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				term.dir = get_root()
			end,
		}

		setup_terminal(lazygit_cur_buf_config)

		local lazygit_log_cur_buf_config = {
			keymap = "<M-j>",
			desc = "Toggle lazygit (log current buffer)",
			term_opts = lazygit_opts,
			toggle_pre_hook = function(term)
				term.cmd = lazygit_cmd .. " --filter " .. vim.fn.expand("%:p")
				term.dir = get_root()
			end,
		}

		setup_terminal(lazygit_log_cur_buf_config)
	end,
}
