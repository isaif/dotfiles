vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.showmode = false

-- vim.cmd('colorscheme nightfox')
local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = 'nightfox', -- change the colorscheme to use nordfox
  styles = {
    comments = 'italic', -- change style of comments to be italic
    keywords = 'bold', -- change style of keywords to be bold
    functions = 'italic,bold', -- styles can be a comma separated list
  },
  inverse = {
    match_paren = true, -- inverse the highlighting of match_parens
  },
  colors = {
    red = '#FF000', -- Override the red color for MAX POWER
    bg_alt = '#000000',
  },
  hlgroups = {
    TSPunctDelimiter = { fg = '${red}' }, -- Override a highlight group with the color red
    LspCodeLens = { bg = '#000000', style = 'italic' },
  },
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()

local success, lualine = pcall(require, 'lualine')

if success then
  lualine.setup({
    options = { theme = 'nightfox' },
  })
else
  error('lualine is not installed')
end
