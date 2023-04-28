vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.showmode = false

vim.g.tokyonight_style = 'night'
vim.cmd('colorscheme tokyonight')

local success, lualine = pcall(require, 'lualine')

if success then
  lualine.setup({
    options = { theme = 'tokyonight' },
  })
else
  error('lualine is not installed')
end
