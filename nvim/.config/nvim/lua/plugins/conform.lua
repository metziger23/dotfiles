return {
  'stevearc/conform.nvim',

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
    })

  end
}
