local M = {}

function M.get_sorted_tasks()
	local parser = require("selfmade.task-runner.parser")
	local tasks = parser.get_just_tasks()
	if tasks == nil then
		return nil
	end

	local task_cmds = require("selfmade.task-runner.sqlite-task-store").getNames(vim.fn.getcwd())
	if task_cmds == nil then
		return tasks
	end

	for _, task_cmd in ipairs(task_cmds) do
		local found = false
		for i = #tasks, 1, -1 do
			if tasks[i] == task_cmd then
				found = true
				table.remove(tasks, i)
				break
			end
		end
		if found then
			table.insert(tasks, 1, task_cmd)
		end
	end

	return tasks
end

return M
