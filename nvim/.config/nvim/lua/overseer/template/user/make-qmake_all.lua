return {
	name = "make qmake_all",
	builder = function()
		local make_utils = require("utils.make")
		local make = make_utils.generate_make()

		return {
			cmd = { make },
			args = { "qmake_all" },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = {},
	},
}
