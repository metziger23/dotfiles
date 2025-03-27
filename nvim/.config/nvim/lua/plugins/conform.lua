return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				qml = { "qmlformat" },
			},
			formatters = {
				qmlformat = {
					meta = {
						url = "https://doc.qt.io/qt-6//qtqml-tooling-qmlformat.html",
						description = "qmlformat is a tool that automatically formats QML files in accordance with the QML Coding Conventions.",
					},
					command = "qmlformat",
					args = {
						"--functions-spacing",
						"--objects-spacing",
						"--normalize",
						"--indent-width",
						"4",
						"--force",
						"$FILENAME",
					},
				},
			},
		})

		-- Create a variable to track the toggle state
		local formatOnSaveEnabled = true

		-- Function to toggle the format on save
		function ToggleFormatOnSave()
			formatOnSaveEnabled = not formatOnSaveEnabled
			if formatOnSaveEnabled then
				print("Format on save: enabled")
			else
				print("Format on save: disabled")
			end
		end

		-- Create the autocmd
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				-- Skip if format on save is disabled or filetype is qml
				if not formatOnSaveEnabled or vim.bo.filetype == "qml" then
					return
				end
				require("conform").format({ bufnr = args.buf })
			end,
		})

		-- Create a command to toggle
		vim.api.nvim_create_user_command("ToggleFormatOnSave", ToggleFormatOnSave, {})
	end,
}
