vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
-- vim.o.termguicolors = true
vim.o.showmode = true

vim.cmd('colorscheme gruvbox')

local success, lualine = pcall(require, 'lualine')

if success then
  lualine.setup({
    options = { theme = 'gruvbox' },
  })
else
  error('lualine is not installed')
end
