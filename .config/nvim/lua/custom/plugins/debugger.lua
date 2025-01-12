return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  keys = {
    { '<leader>tb', '<cmd>DapToggleBreakpoint<cr>', desc = '[T]oggle [B]reakpoint' },
    {
      '<leader>td',
      function()
        require('dapui').toggle {}
      end,
      desc = '[T]oggle [D]ebugger',
    },
  },
  opts = {
    icons = {
      expanded = '',
      collapsed = '',
      current_frame = '',
    },
    controls = {
      icons = {
        play = '',
        step_into = '',
        step_over = '',
        step_out = '',
        step_back = '',
        run_last = '',
        terminate = '',
      },
    },
  },
  config = function(_, opts)
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup(opts)
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open {}
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end

    dap.configurations.elixir = {
      {
        type = 'mix_task',
        name = 'mix test',
        task = 'test',
        taskArgs = { '--trace' },
        request = 'launch',
        startApps = true, -- for Phoenix projects
        projectDir = '${workspaceFolder}',
        requireFiles = {
          'test/**/test_helper.exs',
          'test/**/*_test.exs',
        },
      },
    }
    dap.adapters.mix_task = {
      type = 'executable',
      command = '/home/hubert/.local/share/nvim/mason/packages/elixir-ls/debug_adapter.sh', -- debug_adapter.bat for windows
      args = {},
    }

    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    dap.configurations.c = {
      {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }
  end,
}
