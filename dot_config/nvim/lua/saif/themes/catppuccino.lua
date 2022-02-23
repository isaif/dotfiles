vim.go.t_Co = '256'

-- hightight current line
vim.o.cursorline = true

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.showmode = false

-- vim.cmd('colorscheme catppuccino')
-- vim.cmd('colorscheme soft_manilo')

local catppuccino = require('catppuccino')

-- configure it
catppuccino.setup({
  -- colorscheme = "dark_catppuccino",
  colorscheme = 'soft_manilo',
  -- colorscheme = "neon_latte",
  transparency = false,
  term_colors = false,
  styles = {
    comments = 'italic',
    functions = 'italic',
    keywords = 'italic',
    strings = 'NONE',
    variables = 'NONE',
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = 'italic',
        hints = 'italic',
        warnings = 'italic',
        information = 'italic',
      },
      underlines = {
        errors = 'underline',
        hints = 'underline',
        warnings = 'underline',
        information = 'underline',
      },
    },
    lsp_trouble = false,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = false,
    telescope = false,
    nvimtree = {
      enabled = false,
      show_root = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = false,
    markdown = false,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
  },
})

vim.cmd('colorscheme catppuccino')

-- local success, lualine = pcall(require,'lualine')

-- if success then
--   lualine.setup{
--     options = {theme = 'catppuccino'},
--   }
-- else
--   error('lualine is not installed')
-- end
