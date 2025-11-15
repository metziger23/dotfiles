local normalize_list = function(t)
	local normalized = {}
	for _, v in pairs(t) do
		if v ~= nil then
			table.insert(normalized, v)
		end
	end
	return normalized
end

return {
	"theprimeagen/harpoon",
	-- enabled = false,
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
      -- stylua: ignore start
    { "<C-c>", "<cmd>close<cr>", ft = "harpoon" , desc = "Close harpoon" },
    { "<leader>A", function() require("harpoon"):list():add() end, desc = "Harpoon Add File", },
    { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" }) end, desc = "Harpoon Quick Menu", },
    { "<BS>t", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" }) end, desc = "Harpoon Quick Menu", },
		-- stylua: ignore end

		{
			"<leader>n",
			function()
				local harpoon = require("harpoon")
				require("snacks").picker({
					finder = function()
						local file_paths = {}
						local list = normalize_list(harpoon:list().items)
						for _, item in ipairs(list) do
							table.insert(file_paths, { text = item.value, file = item.value })
						end
						return file_paths
					end,
					win = {
						input = {
							keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
						},
						list = {
							keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
						},
					},
					actions = {
						harpoon_delete = function(picker, item)
							local to_remove = item or picker:selected()
							harpoon:list():remove({ value = to_remove.text })
							harpoon:list().items = normalize_list(harpoon:list().items)
							picker:find({ refresh = true })
						end,
					},
				})
			end,
			desc = "which_key_ignore",
		},
	},
}
