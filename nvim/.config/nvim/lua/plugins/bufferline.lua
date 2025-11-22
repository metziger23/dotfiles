return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "tabs",
			custom_areas = {
				right = function()
					local result = {}
					local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					table.insert(result, { text = cwd, link = "BufferLineInfoSelected" })
					return result
				end,
			},
		},
	},
}
