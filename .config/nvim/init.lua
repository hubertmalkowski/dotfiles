vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = false

require 'custom.neovide'
require 'custom.fancy-visual'
require 'options'
require 'keymaps'

require 'lazy-bootstrap'
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
