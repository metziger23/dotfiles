local function get_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "█", right = "█" },
			},
			sections = {
        lualine_c = { "filename", "overseer" },
				lualine_x = { get_cwd, "encoding", "fileformat", "filetype" },
			},
		})
	end,
}
