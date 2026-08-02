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
