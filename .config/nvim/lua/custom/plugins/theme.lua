return {
  'bluz71/vim-moonfly-colors',
  priority = 1000,
  init = function()
    -- Lua initialization file
    vim.g.moonflyWinSeparator = 0
    vim.g.moonflyNormalFloat = true
    vim.cmd.colorscheme 'moonfly'

    local palette = require('moonfly').palette

    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = palette.bg, bg = palette.bg })
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = palette.bg, bg = palette.bg })
  end,
}
