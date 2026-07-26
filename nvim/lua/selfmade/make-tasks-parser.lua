local M = {}
function M.get_make_tasks()
	if vim.fn.executable("make") == 0 then
		vim.notify('Command "make" not found', vim.log.levels.WARN)
		return
	end

	local cwd = vim.fn.getcwd()
	local makefile = vim.fs.find("Makefile", { path = cwd, upward = false, type = "file", limit = 1 })[1]
	if not makefile then
		vim.notify("No Makefile found", vim.log.levels.WARN)
		return
	end

	local result = {}
	vim.system({ "make", "-rRpq" }, {
		cwd = cwd,
		text = true,
		env = {
			["LANG"] = "C.UTF-8",
		},
	}, function(out)
		if out.code ~= 0 and out.code ~= 1 then
			vim.notify("Error running 'make'", vim.log.levels.WARN)
			return
		end

		local parsing = false
		local prev_line = ""
		for line in vim.gsplit(out.stdout, "\n") do
			if line:find("# Files") == 1 then
				parsing = true
			elseif line:find("# Finished Make") == 1 then
				break
			elseif parsing then
				if line:match("^[^%.#%s]") and prev_line:find("# Not a task") ~= 1 then
					local idx = line:find(":")
					if idx then
						local task = line:sub(1, idx - 1)
						table.insert(result, task)
					end
				end
			end
			prev_line = line
		end
	end):wait()
	return result
end

return M
