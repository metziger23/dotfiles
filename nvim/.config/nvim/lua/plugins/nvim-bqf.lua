return {
	"kevinhwang91/nvim-bqf",
	dependencies = "junegunn/fzf",
	config = function()
		require("bqf").setup({
			preview = {
				should_preview_cb = function(bufnr)
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					if bufname:match("^fugitive://") then
						vim.api.nvim_buf_call(bufnr, function()
							vim.cmd(("do fugitive BufReadCmd %s"):format(bufname))
						end)
					end
					return true
				end,
			},
		})
	end,
}
