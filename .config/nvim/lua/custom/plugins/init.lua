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
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      open_mapping = '<leader>tt',
    },
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      'akinsho/toggleterm.nvim', -- optional 'nvim-tree/nvim-web-devicons', -- optional
    },
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
    'coffebar/neovim-project',
    opts = {
      last_session_on_startup = false,
      -- Dashboard mode prevent session autoload on startup
      dashboard_mode = true,
      projects = { -- define project roots
        '~/.config/*',
        '~/dotfiles/*',
        '~/dev/projects/*',
        '~/dev/learn/*',
        '~/dev/work/*',
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      vim.keymap.set('n', '<leader>sa', '<cmd>Telescope neovim-project discover<CR>', {
        desc = '[S]earch [P]rojects',
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>Telescope neovim-project history<CR>', {
        desc = '[S]earch [R]ecent projects',
      })
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
      { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>td',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[T]oggle [D]iagnostics',
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
}
