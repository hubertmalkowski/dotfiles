return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  keys = {
    {
      '<leader>dd',
      function()
        require('dapui').toggle {}
      end,
      desc = 'Debugger',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Run/Continue',
    },
    {
      '<leader>da',
      function()
        require('dap').continue { before = get_args }
      end,
      desc = 'Run with Args',
    },
    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to Cursor',
    },
    {
      '<leader>dg',
      function()
        require('dap').goto_()
      end,
      desc = 'Go to Line (No Execute)',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<leader>dj',
      function()
        require('dap').down()
      end,
      desc = 'Down',
    },
    {
      '<leader>dk',
      function()
        require('dap').up()
      end,
      desc = 'Up',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<leader>dP',
      function()
        require('dap').pause()
      end,
      desc = 'Pause',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = 'Toggle REPL',
    },
    {
      '<leader>ds',
      function()
        require('dap').session()
      end,
      desc = 'Session',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = 'Terminate',
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
        step_over = '',
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
      -- dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      -- dapui.close {}
    end

    vim.cmd 'hi DapBreakpointColor guifg=#fa4848'
    vim.fn.sign_define('DapBreakpoint', { text = '󰮕 ', texthl = 'DapBreakpointColor', linehl = '', numhl = '' })

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
    --
    -- dap.adapters.gdb = {
    --   type = 'executable',
    --   command = 'gdb',
    --   args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    -- }
    --
    --
    -- dap.adapters.codelldb = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     command = 'codelldb',
    --     args = {
    --       '--port',
    --       '${port}',
    --     },
    --   },
    -- }
    dap.adapters.codelldb = {
      type = 'server',
      host = '127.0.0.1',
      port = 13000,
    }

    dap.configurations.c = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.zig = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    --   {
    --     name = 'Launch',
    --     type = 'gdb',
    --     request = 'launch',
    --     program = function()
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopAtBeginningOfMainSubprogram = false,
    --   },
    --   {
    --     name = 'Select and attach to process',
    --     type = 'gdb',
    --     request = 'attach',
    --     program = function()
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     end,
    --     pid = function()
    --       local name = vim.fn.input 'Executable name (filter): '
    --       return require('dap.utils').pick_process { filter = name }
    --     end,
    --     cwd = '${workspaceFolder}',
    --   },
    -- }
  end,
}
