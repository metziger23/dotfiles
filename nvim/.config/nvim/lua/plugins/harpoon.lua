return
{
  "theprimeagen/harpoon",
  enabled = false,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    { "<leader>A", function() require("harpoon"):list():add() end, desc = "Harpoon Add File", },
    { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" }) end, desc = "Harpoon Quick Menu", },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "which_key_ignore", },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "which_key_ignore", },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "which_key_ignore", },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "which_key_ignore", },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "which_key_ignore", },
    { "<leader>6", function() require("harpoon"):list():select(6) end, desc = "which_key_ignore", },
    { "<leader>7", function() require("harpoon"):list():select(7) end, desc = "which_key_ignore", },
    { "<leader>8", function() require("harpoon"):list():select(8) end, desc = "which_key_ignore", },
    { "<leader>9", function() require("harpoon"):list():select(9) end, desc = "which_key_ignore", },
  },
}
