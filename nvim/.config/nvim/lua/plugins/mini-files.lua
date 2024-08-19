return {
	"echasnovski/mini.files",
  lazy = false,
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"<leader>E",
			function()
				require("mini.files").open(vim.fn.getcwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
	opts = {
		windows = {
			preview = true,
		},
	},
  init = function()
    -- Add rounded corners.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowOpen',
      callback = function(args)
        local win_id = args.data.win_id
        vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
      end,
    })
  end,
}
