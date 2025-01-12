return {
  {
    'mistricky/codesnap.nvim',
    build = 'make build_generator',
    keys = {
      { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = '[C]ode Screenshot [C]opy' },
      { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = '[C]ode Screenshot [S]ave' },
    },
    opts = {
      save_path = '~/Pictures',
      has_breadcrumbs = true,
      code_font_family = 'Iosevka SS14',
      bg_theme = 'grape',
      mac_window_bar = false,
      bg_padding = 8,
    },
  },
}
