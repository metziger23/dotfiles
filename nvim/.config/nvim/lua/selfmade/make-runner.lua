local existing_tasks = {}
local current_task = {}

---@diagnostic disable-next-line: unused-function
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

local function escaped_cmd(cmd)
	local term_command = "make " .. vim.fn.shellescape(cmd, true)
	return vim.fn.fnameescape(term_command)
end

local function find_existing_task(task)
	for _, existing_task in ipairs(existing_tasks) do
		if task.cmd == existing_task.cmd and task.cwd == existing_task.cwd then
			return existing_task
		end
	end
end

-- TODO: try to push to sqlite last tasks async using wrap
local function set_buffer_options(buf_id)
	vim.api.nvim_set_option_value("filetype", "make-runner", { buf = buf_id })
	local win_ids = win_ids_for_buf_id(buf_id)
	for _, win_id in ipairs(win_ids) do
		vim.api.nvim_set_option_value("number", true, { scope = "local", win = win_id })
	end
end

local function get_current_or_last_task()
	if #current_task > 0 then
		return current_task
	end
	require("lazy").load({ plugins = { "sqlite.lua" } })
	local cwd = vim.fn.getcwd()
	local task_cmd = require("selfmade.make-runner-sqlite-tasks").getName(cwd)
	if not task_cmd or task_cmd == "" then
		vim.notify("No tasks in sqlite database for cwd", vim.log.levels.WARN)
		return
	end

	current_task.cwd = cwd
	current_task.cmd = task_cmd
	return current_task
end

local function execute(cmd)
	current_task = {
		cmd = cmd,
		cwd = vim.fn.getcwd(),
	}

	local win_ids = {}
	local existing_task = find_existing_task(current_task)
	if existing_task then
		win_ids = win_ids_for_buf_id(existing_task.buf_id)
		require("snacks").bufdelete.delete({ buf = existing_task.buf_id, force = true, wipe = true })
	end

	current_task.buf_id = nil
	if #win_ids > 0 then
		for _, win_id in ipairs(win_ids) do
			if not current_task.buf_id then
				-- FIXME: code duplication
				vim.api.nvim_win_call(win_id, function()
					vim.cmd("edit term://" .. escaped_cmd(cmd))
				end)
				current_task.buf_id = vim.api.nvim_win_get_buf(win_id)
				require("selfmade.make-runner-sqlite-tasks").push({ name = current_task.cmd, cwd = current_task.cwd })
				set_buffer_options(current_task.buf_id)
			else
				vim.api.nvim_win_set_buf(win_id, current_task.buf_id)
			end
		end
	else
		-- FIXME: code duplication
		vim.cmd("botright split term://" .. escaped_cmd(cmd))
		current_task.buf_id = vim.api.nvim_get_current_buf()
		require("selfmade.make-runner-sqlite-tasks").push({ name = current_task.cmd, cwd = current_task.cwd })
		set_buffer_options(current_task.buf_id)
	end

	if existing_task then
		existing_task.buf_id = current_task.buf_id
	else
		table.insert(existing_tasks, current_task)
	end

	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = current_task.buf_id,
		once = true,
		callback = function()
			local buf_id = vim.fn.expand("<abuf>")
			for i = #existing_tasks, 1, -1 do
				if buf_id == existing_tasks[i].buf_id then
					table.remove(existing_tasks, i)
				end
			end
		end,
	})
end

vim.api.nvim_create_user_command("Make", function(args)
	local fargs = args.fargs
	if #fargs ~= 1 then
		vim.notify("Make accepts only one argument", vim.log.levels.ERROR)
	end

	local arg = fargs[1]
	execute(arg)
end, {
	nargs = "*",
	desc = "Execute a task from Makefile",
	complete = function(_, _, _)
		local parser = require("selfmade.make-tasks-parser")
		return parser.get_make_tasks()
	end,
})

vim.api.nvim_create_user_command("MakeSelectTask", function()
	local parser = require("selfmade.make-tasks-parser")
	local tasks = parser.get_make_tasks()
	if not tasks then
		vim.notify("No tasks", vim.log.levels.WARN)
		return
	end
	vim.ui.select(tasks, {
		prompt = "Select task:",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice then
			execute(choice)
		end
	end)
end, {
	desc = "Select task from Makefile using vim.ui.select",
})

vim.api.nvim_create_user_command("MakeToggleCurrentTask", function()
	local task = get_current_or_last_task()

	if not task then
		vim.notify("No tasks", vim.log.levels.WARN)
		return
	end

	if not task.buf_id or not vim.api.nvim_buf_is_valid(task.buf_id) then
		vim.notify("Current task buffer id is not valid", vim.log.levels.WARN)
		return
	end

	if not task or not task.buf_id or not vim.api.nvim_buf_is_valid(task.buf_id) then
		return
	end

	local win_ids = win_ids_for_buf_id(task.buf_id)
	if #win_ids > 0 then
		for _, win_id in ipairs(win_ids) do
			vim.api.nvim_win_close(win_id, false)
		end
	else
    -- FIXME: code duplication
		vim.cmd("botright split")
		vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), current_task.buf_id)
		require("selfmade.make-runner-sqlite-tasks").push({ name = current_task.cmd, cwd = current_task.cwd })
		set_buffer_options(current_task.buf_id)
	end
end, {
	desc = "Toggle current task",
})

vim.api.nvim_create_user_command("MakeRestartCurrentTask", function()
	local task = get_current_or_last_task()
	if task and task.cmd then
		execute(task.cmd)
	end
end, {
	desc = "Restart current task",
})

vim.keymap.set("n", "<leader>me", "<cmd>MakeSelectTask<CR>", { desc = "Make: select task to execute" })
vim.keymap.set("n", "<A-r>", "<cmd>MakeToggleCurrentTask<CR>", { desc = "Make: Toggle current task" })
vim.keymap.set("n", "<A-l>", "<cmd>MakeRestartCurrentTask<CR>", { desc = "Make: Restart current task" })
