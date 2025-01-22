-- Set color theme to light/dark based on current system preferences.
--

function set_background_based_on_os()
  -- Default value
  local background = 'light'
  -- First check whether we are on MacOS
  if vim.loop.os_uname().sysname == 'Darwin' then
    -- Check if 'defaults' is executable
    if vim.fn.executable 'defaults' ~= 0 then
      -- Execute command to check if the macOS appearance is set to Dark
      local appleInterfaceStyle = vim.fn.system { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }
      if appleInterfaceStyle:find 'Dark' then
        background = 'dark'
      end
    end
  -- Check if 'busctl' is executable (part of systemd)
  elseif vim.fn.executable 'busctl' ~= 0 then
    -- Get the current color scheme from xdg-desktop-portal using busctl
    local result = vim.fn.system {
      'busctl',
      '--user',
      'call',
      'org.freedesktop.portal.Desktop',
      '/org/freedesktop/portal/desktop',
      'org.freedesktop.portal.Settings',
      'ReadOne',
      'ss',
      'org.freedesktop.appearance',
      'color-scheme',
    }
    -- The result is in the form of "v u 0" for light and "v u 1" for dark
    local color_scheme = result:match 'u%s+(%d+)'

    if color_scheme == '1' then
      background = 'dark'
    end
  else
  end

  -- Set the background
  vim.opt.background = background
end

local on_color_change = function(f)
  local init_background = vim.opt.background:get()
  f(init_background)

  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background', -- Watch for changes to the 'background' option
    callback = function()
      local new_background = vim.opt.background:get()
      f(new_background)
    end,
  })
end

return {
  {
    'nyoom-engineering/oxocarbon.nvim',
    enabled = false,
    init = function()
      local oxocarbon = require('oxocarbon').oxocarbon
      -- vim.cmd 'colorscheme oxocarbon'
      set_background_based_on_os()
      -- vim.api.nvim_set_hl(0, 'NormalFloat', { fg = oxocarbon.base01, bg = oxocarbon.base01 })
      -- vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = oxocarbon.base01, bg = oxocarbon.base01 })
      on_color_change(function(bg)
        if bg == 'light' then
          vim.api.nvim_set_hl(0, 'LspReferenceText', { fg = oxocarbon.none, bg = '#e6e8f5' })
          vim.api.nvim_set_hl(0, 'LspReferenceRead', { fg = oxocarbon.none, bg = '#e6e8f5' })
          vim.api.nvim_set_hl(0, 'LspReferenceWrite', { fg = oxocarbon.none, bg = '#e6e8f5' })
          vim.api.nvim_set_hl(0, 'Comment', { fg = '#6f6f6f', bg = oxocarbon.none, italic = true })
          vim.api.nvim_set_hl(0, '@Keyword', { fg = '#0f62fe', bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, '@constant', { fg = oxocarbon.base11, bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, 'String', { fg = oxocarbon.base07, bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, 'NonText', { fg = '#6f6f6f', bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = oxocarbon.base04, bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, 'LineNr', { fg = oxocarbon.base04, bg = oxocarbon.none })
        else
          vim.api.nvim_set_hl(0, 'LspReferenceText', { fg = oxocarbon.none, bg = '#304f8d' })
          vim.api.nvim_set_hl(0, 'LspReferenceRead', { fg = oxocarbon.none, bg = '#304f8d' })
          vim.api.nvim_set_hl(0, 'LspReferenceWrite', { fg = oxocarbon.none, bg = '#304f8d' })
          vim.api.nvim_set_hl(0, '@Keyword', { fg = oxocarbon.base11, bg = oxocarbon.none })
          vim.api.nvim_set_hl(0, 'NonText', { fg = oxocarbon.base03, bg = oxocarbon.none })
        end
      end)
    end,
  },
}
