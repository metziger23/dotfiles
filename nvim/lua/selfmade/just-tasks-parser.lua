local M = {}
function M.get_just_tasks()
	if vim.fn.executable("just") == 0 then
		vim.notify('Command "just" not found', vim.log.levels.WARN)
		return
	end

	local cwd = vim.fn.getcwd()
	local justfile = vim.fs.find("justfile", { path = cwd, upward = false, type = "file", limit = 1 })[1]
	if not justfile then
		vim.notify("No justfile found", vim.log.levels.WARN)
		return
	end

	local result = {}
	vim.system({ "just", "--summary" }, {
		cwd = cwd,
		text = true,
		env = {
			["LANG"] = "C.UTF-8",
		},
	}, function(out)
		if out.code ~= 0 and out.code ~= 1 then
			vim.notify("Error running 'just'", vim.log.levels.WARN)
			return
		end

		for task in out.stdout:gmatch("%S+") do
			table.insert(result, task)
		end
	end):wait()
	return result
end

return M
