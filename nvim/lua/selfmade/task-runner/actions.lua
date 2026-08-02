local M = {}

local state = require("selfmade.task-runner.state")

local function escaped_cmd(cmd)
	local term_command = "just " .. vim.fn.shellescape(cmd, true)
	return vim.fn.fnameescape(term_command)
end

local function task_runner_win_ids()
	local result = {}

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype

		if ft == "task-runner" then
			table.insert(result, win)
		end
	end

	return result
end

local function close_all_task_runner_windows()
	local windows = task_runner_win_ids()
	for _, win_id in ipairs(windows) do
		vim.api.nvim_win_close(win_id, false)
	end
end

local function win_ids_for_buf_id(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return {}
	end

	local res = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == bufnr then
			res[#res + 1] = win
		end
	end
	return res
end

local function find_existing_task_idx(cmd, working_dir)
	for i, existing_task in ipairs(state.existing_tasks) do
		if cmd == existing_task.cmd and working_dir == existing_task.working_dir then
			return i
		end
	end
	return nil
end

local function push_current_task_to_db(cmd, working_dir)
	require("selfmade.task-runner.sqlite-task-store").push({
		name = cmd,
		working_dir = working_dir,
	})
end

local function set_buffer_options(buf_id)
	vim.api.nvim_set_option_value("filetype", "task-runner", { buf = buf_id })
	vim.api.nvim_set_option_value("buflisted", false, { buf = buf_id })
	local win_ids = win_ids_for_buf_id(buf_id)
	for _, win_id in ipairs(win_ids) do
		vim.api.nvim_set_option_value("number", true, { scope = "local", win = win_id })
	end

	local opts = { buffer = buf_id, silent = true, noremap = true }
	vim.keymap.set("n", "<CR>", require("selfmade.task-runner.file-navigator").go_to_file, opts)
end

function M.run_task(cmd, working_dir)
	close_all_task_runner_windows()

	vim.cmd("botright split term://" .. escaped_cmd(cmd))
	set_buffer_options(vim.api.nvim_get_current_buf())

	push_current_task_to_db(cmd, working_dir)

	state.cur_task_idx = find_existing_task_idx(cmd, working_dir)

	if state.cur_task_idx then
		local buf_id = state.existing_tasks[state.cur_task_idx].buf_id
		require("snacks").bufdelete.delete({ buf = buf_id, force = true, wipe = true })
		state.existing_tasks[state.cur_task_idx].buf_id = vim.api.nvim_get_current_buf()
	else
		table.insert(state.existing_tasks, {
			cmd = cmd,
			working_dir = working_dir,
			buf_id = vim.api.nvim_get_current_buf(),
		})
		state.cur_task_idx = #state.existing_tasks
	end
end

return M
