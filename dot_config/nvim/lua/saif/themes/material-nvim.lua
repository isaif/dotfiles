vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
-- vim.o.termguicolors = true
vim.o.showmode = false
vim.g.material_style = "darker"

vim.cmd('colorscheme material')

require('material').setup{
	disable = {
    -- all default value are false
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = true, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},
}

local success, lualine = pcall(require,'lualine')

if success then
  lualine.setup{
    options = {theme = 'material-nvim'},
  }
else
  error('lualine is not installed')
end

