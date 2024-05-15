return {
	"akinsho/toggleterm.nvim",
	-- version = "*",
	config = function()
		require("toggleterm").setup({
      shade_terminals = false,
    })

		local Terminal = require("toggleterm.terminal").Terminal

		local lg_cmd = "lazygit"
		if vim.v.servername ~= nil then
			lg_cmd = string.format("NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml", vim.v.servername)
		end

		vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

		local lazygit = Terminal:new({
			cmd = lg_cmd,
			count = 5,
			direction = "float",
			float_opts = {
				border = "rounded",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		function Edit(fn, line_number)
			local edit_cmd = string.format(":e %s", fn)
			if line_number ~= nil then
				edit_cmd = string.format(":e +%d %s", line_number, fn)
			end
			vim.cmd(edit_cmd)
		end

		function Lazygit_toggle()
			lazygit:toggle()
		end

		vim.keymap.set("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", { silent = true })
	end,
}
