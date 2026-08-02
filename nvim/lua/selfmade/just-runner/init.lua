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

vim.keymap.set("n", "<leader>,", "<cmd>JustSelectTaskToRun<CR>", { desc = "just: select task to run" })
