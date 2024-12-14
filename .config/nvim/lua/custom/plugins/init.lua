return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local oil = require 'oil'
      oil.setup {
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set('n', '<leader>e', oil.open, { desc = 'Open File [E]plorer' })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.G, {
        desc = '[G]it [S]tatus',
      })
      vim.keymap.set('n', '<leader>gc', function()
        vim.cmd.G 'commit'
      end, {
        desc = '[G]it [C]ommit',
      })
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        symbol_in_winbar = { hide_keyword = true, enable = false, separator = ' |> ', folder_level = 0 },
        lightbulb = { virtual_text = false },
        ui = { code_action = '' },
      }
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
      vim.keymap.set('n', '<leader>cr', '<cmd>Lspsaga rename<CR>', {
        desc = '[R]ename',
      })
      vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = '[C]ode [A]ctions' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional 'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'topline',
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = { theme = 'oxocarbon', component_separators = '', section_separators = '' },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            {
              function()
                local bar = require('lspsaga.symbol.winbar').get_bar()
                if bar == nil then
                  return 'filename'
                end
                return bar
              end,
            },
            'branch',
          },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
          },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            'location',
          },
        },
        inactive_sections = { lualine_a = { 'filename' }, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = { 'location' } },
        tabline = {},
        extensions = {},
      }
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tp',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[T]oggle [P]roblems',
      },
      {
        '<leader>dd',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = '[D]ocument [D]iagnostics',
      },
    },
  },
  {
    'hedyhli/outline.nvim',
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set('n', '<leader>do', '<cmd>Outline<CR>', { desc = '[D]ocument [O]utline' })
      require('outline').setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    enabled = false,
    config = function()
      local header = [[                   
                                 .-'~~~-. 
                     .'o  oOOOo`.         
                    :~~~-.oOo   o`.       
                     `. \ ~-.  oOOo.      
                       `.; / ~.  OO:      
                       .'  ;-- `.o.'      
                      ,'  ; ~~--'~        
                      ;  ;                
_______\|/__________\\;_\\//___\|/________]]

      header = string.rep('\n', 8) .. header .. '\n\n'

      require('dashboard').setup {
        theme = 'doom',

        config = {
          header = vim.split(header, '\n'),
          center = {
            {
              icon = '󰘳 ',
              icon_hl = 'Title',
              desc = '[S]earch [R]ecent Projects',
              desc_hl = 'String',
              key = '<leader>sr',
              key_hl = 'Number',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Telescope neovim-project history',
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = '[S]earch All [P]rojects',
              desc_hl = 'String',
              key = '<leader>sp',
              key_hl = 'Number',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Telescope neovim-project discover',
            },
          },
        },
        -- config
      }
    end,

    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'jfpedroza/neotest-elixir',
    },
    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        adapters = {
          require 'neotest-vitest',
          require 'neotest-elixir',
        },
      }

      vim.keymap.set('n', '<leader>nf', function()
        neotest.run.run(vim.fn.expand '%')
      end, {
        desc = '[N]eotest Test[f]ile',
      })

      vim.keymap.set('n', '<leader>nt', neotest.run.run, {
        desc = '[N]eotest nearest [T]est',
      })

      vim.keymap.set('n', '<leader>no', neotest.output_panel.toggle, {
        desc = '[N]eotest toggle [O]utput panel',
      })

      vim.keymap.set('n', '<leasder>ns', neotest.summary.toggle, {
        desc = '[N]eotest [S]ummary',
      })
    end,
  },
  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = '<author> - <summary>', -- template for the blame message, check the Message template section for more options
      date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      delay = 1000,
      message_when_not_committed = '',
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require 'ufo'

      ufo.setup()

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end,
  },
  {
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
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, {
        desc = '[H]arpoon [A]dd',
      })

      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end, {
        desc = '[H]arpoon [R]remove',
      })

      vim.keymap.set('n', '<leader>hc', function()
        harpoon:list():clear()
      end, {
        desc = '[H]arpoon [C]lear',
      })

      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, {
        desc = '[H]arpoon Quick Menu',
      })

      vim.keymap.set('n', '<leader>hq', function()
        harpoon:list():select(1)
      end, {
        desc = '[H]arpoon Select 1',
      })
      vim.keymap.set('n', '<leader>hw', function()
        harpoon:list():select(2)
      end, {

        desc = '[H]arpoon Select 2',
      })
      vim.keymap.set('n', '<leader>he', function()
        harpoon:list():select(3)
      end, {
        desc = '[H]arpoon Select 3',
      })
      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():select(4)
      end, {
        desc = '[H]arpoon Select 4',
      })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>ho', function()
        harpoon:list():prev()
      end, {
        desc = '[H]arpoon Previous',
      })
      vim.keymap.set('n', '<leader>hp', function()
        harpoon:list():next()
      end, {
        desc = '[H]arpoo Next',
      })

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>hs', function()
        toggle_telescope(harpoon:list())
      end, { desc = '[H]arpoon [S]earch' })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          -- Accept on alt + space
          accept = '<C-Space>',
        },
      },
    },
    keymap = {
      '<leader>tc',
      function()
        require('copilot.suggestion').toggle_auto_trigger()
      end,
      desc = '[T]oggle [C]opilot',
    },
  },
  -- lazy.nvim
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>gl',
        function()
          require('snacks').lazygit()
        end,
        desc = '[G]it [L]azy',
      },
    },
    opts = {
      lazygit = {},
    },
  },
}
