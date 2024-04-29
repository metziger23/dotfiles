return {
	name = "run target",
	builder = function()
		local make_utils = require("utils.make")
        local target = make_utils.get_target_from_Makefile()
		return {
			cmd = {"./" .. target},
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
}
