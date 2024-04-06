return {
	name = "run qmake",
	params = {
		build_type = {
			type = "enum",
			name = "Build type",
			optional = false,
			default = "debug",
			choices = { "debug", "release" },
		},
	},
	builder = function(params)
		-- Full path to current file (see :help expand())
		local utils_qmake = require("utils.qmake")
		local file = vim.fn.expand("%:p")

		local debug = utils_qmake.generate_build_type_param(params.build_type)
		local spec = utils_qmake.generate_spec()
		local qmake = utils_qmake.generate_qmake()

		return {
			cmd = { qmake },
			args = { "-spec", spec, debug },
			components = {
				{
					"run_after",
					task_names = {
						{
							"make qmake_all",
						},
					},
				},
				{ "on_output_quickfix", open = true },
				"default",
			},
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
