vim.wo.wrap = false
vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true
vim.opt.winblend = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e222a' })
