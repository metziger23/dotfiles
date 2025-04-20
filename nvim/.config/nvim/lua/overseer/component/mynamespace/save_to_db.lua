local tasks = require("../../../utils/overseer_sqlite_tasks")

return {
	desc = "Save to database",
	constructor = function(params)
		return {
			on_pre_start = function(self, task)
				-- Return false to prevent task from starting
				if task.metadata["disable_saving_to_db"] == true then
					return true
				end
				tasks.push(task)
			end,
		}
	end,
}
