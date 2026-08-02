local storage_path = vim.fn.stdpath("data") .. "/databases/just-runner-sqlite-task-store.db"
vim.fn.mkdir(string.match(storage_path, "(.*[/\\])"), "p")

local sqlite = require("sqlite")
local db = sqlite({
	uri = storage_path,
	tasks = {
		working_dir = { "text", "primary", "key" },
		names = "text",
	},
})

local tasks = db.tasks

function tasks.getNames(working_dir)
  local get_result = tasks:get({ where = { working_dir = working_dir } })
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
	local names = tasks.getNames(task.working_dir)

	if names == nil then
		tasks:insert({ working_dir = task.working_dir, names = task.name })
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
		where = { working_dir = task.working_dir },
		set = { names = table.concat(names, ";") },
	})
end

return tasks

