return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					return {
						WinSeparator = { fg = colors.overlay1 },
						BlinkCmpDocBorder = { fg = colors.blue },
						BlinkCmpKind = { fg = colors.blue },
						BlinkCmpMenu = { fg = colors.text },
						BlinkCmpMenuBorder = { fg = colors.blue },
						BlinkCmpSignatureHelpActiveParameter = { fg = colors.mauve },
						BlinkCmpSignatureHelpBorder = { fg = colors.blue },
					}
				end,
				floating_border = "on",
				integrations = {
					blink_cmp = true,
				},
				color_overrides = {
					mocha = {
						base = "#000000",
						mantle = "#000000",
						-- crust = "#000000",
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
