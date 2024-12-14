return {
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
}
