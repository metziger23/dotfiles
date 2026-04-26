local existing_tasks = {}
-- TODO: 
local current_task = {}

local function executor(cmd)
	local term_command = "make " .. vim.fn.shellescape(cmd, true)
	local escaped_cmd = vim.fn.fnameescape(term_command)

	vim.cmd("botright split term://" .. escaped_cmd)
	vim.api.nvim_set_option_value("number", true, { scope = "local", win = 0 })
	vim.api.nvim_set_option_value("filetype", "make-runner", { buf = 0 })

	table.insert(existing_tasks, {
		cmd = cmd,
		cwd = vim.fn.getcwd(),
		buf_id = vim.api.nvim_get_current_buf(),
	})

	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = 0,
		once = true,
		callback = function()
			-- TODO:
		end,
	})
end

vim.api.nvim_create_user_command("Make", function(args)
	local fargs = args.fargs
	if #fargs ~= 1 then
		vim.notify("Make accepts only one argument", vim.log.levels.ERROR)
	end

	local arg = fargs[1]
	executor(arg)
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
			executor(choice)
		end
	end)
end, {})

vim.keymap.set("n", "<leader>me", "<cmd>MakeSelectTask<CR>", { desc = "Make: select task to execute" })
