local M = {}

local state = require("selfmade.just-runner.state")

local function escaped_cmd(cmd)
	local term_command = "just " .. vim.fn.shellescape(cmd, true)
	return vim.fn.fnameescape(term_command)
end

local function task_runner_win_ids()
	local result = {}

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype

		if ft == "just-runner" then
			table.insert(result, win)
		end
	end

	return result
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
	require("selfmade.just-runner.sqlite-task-store").push({
		name = cmd,
		working_dir = working_dir,
	})
end

local function set_buffer_options(buf_id)
	vim.api.nvim_set_option_value("filetype", "just-runner", { buf = buf_id })
	vim.api.nvim_set_option_value("buflisted", false, { buf = buf_id })
	local win_ids = win_ids_for_buf_id(buf_id)
	for _, win_id in ipairs(win_ids) do
		vim.api.nvim_set_option_value("number", true, { scope = "local", win = win_id })
	end

	local opts = { buffer = buf_id, silent = true, noremap = true }
	vim.keymap.set("n", "<CR>", require("selfmade.just-runner.file-navigator").go_to_file, opts)
end

local function execute_task(cmd, working_dir)
	local task_buf_id = nil
	local win_ids = task_runner_win_ids()
	if #win_ids > 0 then
		for _, win_id in ipairs(win_ids) do
			if task_buf_id then
				vim.api.nvim_win_set_buf(win_id, task_buf_id)
			else
				vim.api.nvim_win_call(win_id, function()
					vim.cmd("edit term://" .. escaped_cmd(cmd))
				end)
				task_buf_id = vim.api.nvim_win_get_buf(win_id)
			end
		end
	else
		vim.cmd("botright split term://" .. escaped_cmd(cmd))
		task_buf_id = vim.api.nvim_get_current_buf()
	end

	return task_buf_id
end

function M.run_task(cmd, working_dir)
	local task_buf_id = execute_task(cmd, working_dir)

	set_buffer_options(task_buf_id)

	push_current_task_to_db(cmd, working_dir)

	state.cur_task_idx = find_existing_task_idx(cmd, working_dir)

	if state.cur_task_idx then
		local buf_id = state.existing_tasks[state.cur_task_idx].buf_id
		require("snacks").bufdelete.delete({ buf = buf_id, force = true, wipe = true })
		state.existing_tasks[state.cur_task_idx].buf_id = task_buf_id
	else
		table.insert(state.existing_tasks, {
			cmd = cmd,
			working_dir = working_dir,
			buf_id = task_buf_id,
		})
		state.cur_task_idx = #state.existing_tasks
	end
end

local function open_current_task_window()
	vim.cmd("botright split")
	local buf_id = state.existing_tasks[state.cur_task_idx].buf_id
	vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf_id)
	set_buffer_options(buf_id)
end

local function close_current_task_window(win_ids)
	for _, win_id in ipairs(win_ids) do
		vim.api.nvim_win_close(win_id, false)
	end
end

function M.toggle_current_task_window()
	local win_ids = task_runner_win_ids()
	if #win_ids > 0 then
		close_current_task_window(win_ids)
	else
		open_current_task_window()
	end
end

function M.select_task(idx)
	state.cur_task_idx = idx

	local win_ids = task_runner_win_ids()
	local buf_id = state.existing_tasks[state.cur_task_idx].buf_id

	for _, win_id in ipairs(win_ids) do
		vim.api.nvim_win_set_buf(win_id, buf_id)
	end

	vim.notify("task " .. state.cur_task_idx .. " of " .. #state.existing_tasks)
end

return M
