local colors = {
  -- StatusLine background color.
  color0 = '#080808',

  -- Mode colors.
  color1 = '#79dac8',
  color2 = '#36c692',
  color3 = '#ff5454',
  color4 = '#e3c78a',
  color5 = '#ff5189',

  -- Mode text color.
  color6 = '#1c1c1c',

  -- StatusLineNC foreground.
  color7 = '#9e9e9e',

  -- Normal text color.
  color8 = '#c6c6c6',
}

-- LuaFormatter on
local theme = {
  normal = {
    a = { fg = colors.color6, bg = colors.color1 },
    b = { fg = colors.color1, bg = colors.color0 },
    c = { fg = colors.color8, bg = colors.color0 },
  },
  insert = {
    a = { fg = colors.color6, bg = colors.color2 },
    b = { fg = colors.color2, bg = colors.color0 },
  },
  visual = {
    a = { fg = colors.color6, bg = colors.color3 },
    b = { fg = colors.color3, bg = colors.color0 },
  },
  command = {
    a = { fg = colors.color6, bg = colors.color4 },
    b = { fg = colors.color4, bg = colors.color0 },
  },
  replace = {
    a = { fg = colors.color6, bg = colors.color5 },
    b = { fg = colors.color5, bg = colors.color0 },
  },
  inactive = {
    a = { fg = colors.color7, bg = colors.color0 },
    b = { fg = colors.color7, bg = colors.color0 },
    c = { fg = colors.color7, bg = colors.color0 },
  },
}

function get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

-- Should return buffer name with directory in "directory/buffername" format
function get_file_with_directory()
  -- Get the full path of the current buffer
  local filepath = vim.fn.expand '%:p'

  -- Get the directory and the filename separately
  local directory = vim.fn.fnamemodify(filepath, ':h:t')
  local filename = vim.fn.expand '%:t'

  -- Combine directory and filename in the desired format
  if directory == '' then
    return filename -- If no directory, just return the filename
  else
    return directory .. '/' .. filename
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = theme,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = {
          'mode',
        },
        lualine_b = {
          {
            function()
              local dir = require('oil').get_current_dir()
              if dir then
                return vim.fn.fnamemodify(dir, ':~')
              end
              return get_file_with_directory()
            end,
          },
        },
        lualine_c = {
          -- '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {
          -- require('doing').status,
          'branch',
        },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          -- 'location',
        },
      },
      inactive_sections = { lualine_a = { 'filename' }, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = { 'location' } },
      tabline = {},
      extensions = {},
    }
  end,
}
