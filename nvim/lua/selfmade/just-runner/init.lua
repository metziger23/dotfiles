local state = require("selfmade.just-runner.state")

vim.api.nvim_create_user_command("Just", function(args)
	local fargs = args.fargs
	if #fargs ~= 1 then
		vim.notify("just accepts only one argument", vim.log.levels.ERROR)
	end

	require("selfmade.just-runner.actions").run_task(fargs[1], vim.fn.getcwd())
end, {
	nargs = 1,
	desc = "Run a task from justfile",
	complete = function(_, _, _)
		return require("selfmade.just-runner.recency-sorter").get_sorted_tasks()
	end,
})

vim.api.nvim_create_user_command("JustSelectTaskToRun", function()
	local tasks = require("selfmade.just-runner.recency-sorter").get_sorted_tasks()
	if tasks == nil or #tasks == 0 then
		vim.notify("No tasks", vim.log.levels.WARN)
		return
	end

	vim.ui.select(tasks, {
		prompt = "Select task to execute:",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice then
			require("selfmade.just-runner.actions").run_task(choice, vim.fn.getcwd())
		end
	end)
end, {
	desc = "Select task from justfile using vim.ui.select",
})

vim.api.nvim_create_user_command("JustToggleCurrentTaskWindow", function()
	if state.cur_task_idx == nil then
		vim.notify("No current task to toggle window", vim.log.levels.WARN)
		return
	end

	require("selfmade.just-runner.actions").toggle_current_task_window()
end, {
	desc = "Toggle current task",
})

vim.api.nvim_create_user_command("JustRestartCurrentOrLastTask", function()
	if state.cur_task_idx then
		local cur_task = state.existing_tasks[state.cur_task_idx]
		require("selfmade.just-runner.actions").run_task(cur_task.cmd, cur_task.working_dir)
		return
	end

	local tasks = require("selfmade.just-runner.recency-sorter").get_sorted_tasks()
	if tasks == nil or #tasks == 0 then
		vim.notify("No current or last task", vim.log.levels.WARN)
		return
	end

	require("selfmade.just-runner.actions").run_task(tasks[1], vim.fn.getcwd())
end, {
	desc = "Restart current or last task",
})

vim.api.nvim_create_user_command("JustSetPreviousTaskAsCurrent", function()
	if state.cur_task_idx == nil or (state.cur_task_idx - 1) < 1 then
		vim.notify("No previous task to set as current", vim.log.levels.WARN)
		return
	end
	require("selfmade.just-runner.actions").select_task(state.cur_task_idx - 1)
end, {
	desc = "Set previous task as current",
})

vim.api.nvim_create_user_command("JustSetNextTaskAsCurrent", function()
	if state.cur_task_idx == nil or (state.cur_task_idx + 1) > #state.existing_tasks then
		vim.notify("No next task to set as current", vim.log.levels.WARN)
		return
	end
	require("selfmade.just-runner.actions").select_task(state.cur_task_idx + 1)
end, {
	desc = "Set next task as current",
})

local opts = {}

opts.desc = "just: select task to run"
vim.keymap.set("n", "<leader>,", "<cmd>JustSelectTaskToRun<CR>", opts)

opts.desc = "just: Toggle current task window"
vim.keymap.set("n", "<M-r>", "<cmd>JustToggleCurrentTaskWindow<CR>", opts)

opts.desc = "just: Toggle current task window"
vim.keymap.set("n", "<M-l>", "<cmd>JustRestartCurrentOrLastTask<CR>", opts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "just-runner",
	callback = function()
		opts.desc = "just: Set previous task as current"
		vim.keymap.set("n", "<M-Left>", "<cmd>JustSetPreviousTaskAsCurrent<CR>", opts)

		opts.desc = "just: Set next task as current"
		vim.keymap.set("n", "<M-Right>", "<cmd>JustSetNextTaskAsCurrent<CR>", opts)
	end,
})
