return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"lua",
			"c",
			"cpp",
			"bash",
			"vim",
			"vimdoc",
			"markdown",
			"qmljs",
			"qmldir",
			"javascript",
			"just",
			"json",
			"python",
			"make",
		}
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
