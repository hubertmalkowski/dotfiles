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
}
