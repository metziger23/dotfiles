return {
  'mfussenegger/nvim-dap',
  config = function() end,
  keys = {
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
    { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to line (no execute)' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
    { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
  },
  opts = function()
    local dap = require('dap')
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
      },
    }
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }
    dap.configurations.c = dap.configurations.cpp
  end,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
      keys = {
        { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
        { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
        dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
        dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
      end,
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      -- dependencies = 'mfussenegger/nvim-dap',
      opts = {},
    },
    -- which key integration
    {
      'folke/which-key.nvim',
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
        },
      },
    },

    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        ensure_installed = { "codelldb"}
      },
    },

  }
}
