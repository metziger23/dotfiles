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

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
