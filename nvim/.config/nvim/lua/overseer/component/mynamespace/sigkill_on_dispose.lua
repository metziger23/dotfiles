return {
	desc = "Send sigkill on dispose right away instead of vim.fn.jobstop",
	---@diagnostic disable-next-line: unused-local
	constructor = function(params)
		return {
			---@diagnostic disable-next-line: unused-local
			on_complete = function(self, task, status, result)
				-- Called when the task has reached a completed state.
				local strat = task.strategy
				strat:sigkill()
			end,
		}
	end,
}
