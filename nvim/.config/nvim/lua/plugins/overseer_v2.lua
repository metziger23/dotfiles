local function remove_component(components_table, component)
	for i = #components_table, 1, -1 do
		local comp = components_table[i]
		if comp == component or (type(comp) == "table" and comp[1] == component) then
			table.remove(components_table, i)
		end
	end
end

local function get_last_task()
	-- TODO: last task should persist after restart
	local overseer = require("overseer")
	local task_list = require("overseer.task_list")
	local tasks = overseer.list_tasks({
		-- status = {
		-- 	overseer.STATUS.SUCCESS,
		-- 	overseer.STATUS.FAILURE,
		-- 	overseer.STATUS.CANCELED,
		-- },
		-- sort = task_list.sort_finished_recently,
		sort = task_list.default_sort,
	})
	if vim.tbl_isempty(tasks) then
		return nil
	else
		return tasks[1]
	end
end

local function sigkill_job(jobstart_strategy)
	if jobstart_strategy.job_id and jobstart_strategy.job_id > 0 then
		local pid = vim.fn.jobpid(jobstart_strategy.job_id)
		if pid and pid > 0 then
			-- immediate kill
			vim.uv.kill(pid, "sigkill")
		else
			-- fallback if pid is not available
			vim.fn.jobstop(jobstart_strategy.job_id)
		end

		jobstart_strategy.job_id = nil
	end
end

return {
	"stevearc/overseer.nvim",
	dependencies = { "kkharji/sqlite.lua" },
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "Overseer Run" },
		{ "<leader>ob", "<cmd>OverseerToggle bottom<CR>", mode = "n", desc = "Overseer Toggle bottom" },
		{ "<leader>oa", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "Overseer Task Action" },
		{ "<A-r>", "<cmd>OverseerToggleLast<CR>", mode = "n", desc = "Overseer Toggle last task output" },
		{ "<A-l>", "<cmd>OverseerRestartLast<CR>", mode = "n", desc = "Overseer Restart Last Task" },
	},
	config = function()
		local default_components = require("overseer.config").component_aliases.default
		table.insert(default_components, "unique")
		remove_component(default_components, "on_complete_dispose")

		local overseer = require("overseer")
		local overseer_util = require("overseer.util")
		overseer.setup({
			component_aliases = { default = default_components },
			actions = {
				["toggle task output bottom"] = {
					desc = "Toggle the output of the last task at the bottom",
					condition = function(task)
						return task:get_bufnr() ~= nil
					end,
					run = function(task)
						local bufnr = task:get_bufnr()
						if not bufnr then
							return
						end

						local winid = nil
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
							if vim.api.nvim_win_get_buf(win) == bufnr then
								winid = win
							end
						end

						if winid then
							vim.api.nvim_win_close(winid, false)
						else
							-- If we're currently in the task list or any other fixed-width side panel,
							-- open a split in the nearest other window
							if vim.wo.winfixwidth then
								for _, win in ipairs(overseer_util.get_fixed_wins()) do
									if not vim.wo[win].winfixwidth then
										overseer_util.go_win_no_au(win)
										break
									end
								end
							end
							-- TODO: split works incorrect if there's already vertical split
							vim.cmd.split()
							vim.api.nvim_win_set_buf(0, bufnr)
							vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = 0 })
							local target = math.floor(vim.o.lines * 0.9)
							vim.api.nvim_win_set_height(0, target)
							-- overseer_util.scroll_to_end(0)
						end
					end,
					watch = false,
				},
			},
		})

		local jobstart_strategy = require("overseer.strategy.jobstart")
		function jobstart_strategy:sigkill()
			sigkill_job(self)
		end

		function jobstart_strategy:vim_leave_pre_sigkill()
			vim.api.nvim_create_autocmd("VimLeavePre", {
				desc = "Clean up running overseer tasks on exit",
				callback = function()
					sigkill_job(self)
				end,
			})
		end

		overseer.add_template_hook({}, function(task_defn, util)
			util.add_component(task_defn, { "mynamespace.sigkill_job" })
		end)

		overseer.add_template_hook({ module = "^make$" }, function(task_defn, util)
			util.add_component(task_defn, { "mynamespace.save_to_db" })
		end)

		-- TODO: port [w ]w and [e ]e from toggleterm
		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local last_task = get_last_task()
			if not last_task then
				local tasks = require("../utils/overseer_sqlite_tasks")
				local cwd = vim.fn.getcwd()
				local taskName = tasks.getName(cwd)
				if taskName == nil then
					vim.notify("Last task not found", vim.log.levels.WARN)
					return
				end

				overseer.run_task({ name = taskName, autostart = false, search_params = { dir = cwd } }, function(task)
					task.metadata["disable_saving_to_db"] = true
					task:start()
				end)
				return
			end

			overseer.run_action(last_task, "restart")
		end, {})

		vim.api.nvim_create_user_command("OverseerToggleLast", function()
			local last_task = get_last_task()
			-- TODO: close task if not found and split is open
			if not last_task then
				vim.notify("No tasks found", vim.log.levels.WARN)
				return
			end

			overseer.run_action(last_task, "toggle task output bottom")
		end, {})
	end,
}
