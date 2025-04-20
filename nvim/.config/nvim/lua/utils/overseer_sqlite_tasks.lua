local storage_path = vim.fn.stdpath("data") .. "/databases/overseer_sqlite.db"
vim.fn.mkdir(string.match(storage_path, "(.*[/\\])"), "p")

local sqlite = require("sqlite")
local db = sqlite({
	uri = storage_path,
	tasks = {
		cwd = { "text", "primary", "key" },
		name = "text",
	},
})

local tasks = db.tasks
function tasks.push(task)
	local existingTasks = tasks:get({ where = { cwd = task.cwd } })
	if next(existingTasks) == nil then
		tasks:insert({ cwd = task.cwd, name = task.name })
	else
		tasks:update({
			where = { cwd = task.cwd },
			set = { name = task.name },
		})
	end
end

function tasks.getName(cwd)
	local existingTasks = tasks:get({ where = { cwd = cwd } })
	if existingTasks == nil then
		return nil
	end
	local firstTaskKey, firstTask = next(existingTasks)
	if firstTaskKey == nil or firstTask == nil then
		return nil
	end
	return firstTask.name
end

return tasks
