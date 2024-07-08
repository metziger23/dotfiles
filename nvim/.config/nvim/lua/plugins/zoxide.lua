return {
	"nanotee/zoxide.vim",
	cmd = { "Z", "Lz", "Tz", "Zi", "Lzi", "Tzi" },
	config = function()
		vim.g.zoxide_use_select = 1
	end,
}
