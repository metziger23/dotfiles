local storage_path = vim.fn.stdpath("data") .. "/databases/just-runner-sqlite-tasks.db"
vim.fn.mkdir(string.match(storage_path, "(.*[/\\])"), "p")

local sqlite = require("sqlite")
local db = sqlite({
	uri = storage_path,
	tasks = {
		cwd = { "text", "primary", "key" },
		names = "text",
	},
})

local tasks = db.tasks

function tasks.getNames(cwd)
  local get_result = tasks:get({ where = { cwd = cwd } })
  if get_result == nil then
    return nil
  end

  local existingTasksKey, existingTasks = next(get_result)
  if existingTasksKey == nil or existingTasks == nil then
    return nil
  end

  return vim.split(existingTasks.names, ";", { plain = true, trimempty = true })
end

function tasks.push(task)
	local names = tasks.getNames(task.cwd)

	if names == nil then
		tasks:insert({ cwd = task.cwd, names = task.name })
		return
	end

	if names[#names] == task.name then
		return
	end

	for i = #names, 1, -1 do
		if names[i] == task.name then
			table.remove(names, i)
		end
	end

	table.insert(names, task.name)

	tasks:update({
		where = { cwd = task.cwd },
		set = { names = table.concat(names, ";") },
	})
end

return tasks
