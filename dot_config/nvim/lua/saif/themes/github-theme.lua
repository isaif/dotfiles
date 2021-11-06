vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.showmode = false

-- vim.cmd('colorscheme github_dark')
require("github-theme").setup({
  theme_style = "dark",
  -- other config
  -- hide_inactive_statusline = false
})

local success, lualine = pcall(require,'lualine')

if success then
  lualine.setup{
    options = {theme = 'github'},
  }
else
  error('lualine is not installed')
end

