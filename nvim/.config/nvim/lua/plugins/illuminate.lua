return {
	-- https://github.com/RRethy/vim-illuminate
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	dependencies = { "folke/which-key.nvim" },
	config = function()
		local illuminate = require("illuminate")
		illuminate.configure({
      providers = {
        "lsp",
        "treesitter",
      },
			delay = 250,
      filetypes_denylist = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirvish",
        "oil",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
		})

	end,
}
