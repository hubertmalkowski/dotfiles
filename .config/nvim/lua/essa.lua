-- Stuff related to my own language
vim.filetype.add { extension = { essa = 'essa' } }

local function register()
  require('nvim-treesitter.parsers').essa = {
    install_info = {
      path = '/home/hubert/Dev/projects/essa/tree-sitter-essa',
      queries = 'queries',
    },
    tier = 0,
  }
end

-- nvim-treesitter fires this before every install/update/list
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = register })

-- ...but it already fired during lazy's setup(), so register now too
pcall(register)
