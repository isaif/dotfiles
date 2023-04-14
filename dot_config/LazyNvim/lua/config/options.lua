-- highlight yanked
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

--"""""""""""""""""""""""""""""""""""
--"""""""Personal customization""""""
--"""""""""""""""""""""""""""""""""""

-- hide the command bar below the statusline
vim.opt.cmdheight = 0

-- hide tabline
vim.opt.showtabline = 0

-- This option makes cursor as block cursor in nvim
vim.opt.guicursor = 'a:block'
vim.o.termguicolors = true

--This will cause wrap to only wrap at the characters in the breakat
--setting, which defaults to space, tab, and small vim.opt.of punctuation characters.
vim.opt.linebreak = true

-- Search files using fuzzy
-- vim.opt.path+=**
-- vim.opt.wildmenu

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal blocks
-- of text.
vim.o.breakindent = true

-- Maintain undo history between sessions
-- TODO can we share same undo dir with neovim and vim
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'

--remove delay switching between insert and normal mode
vim.opt.ttimeoutlen = 10

-- smartindent will indent lines based on indent in surrounding lines
-- useful when indent is not set for some filetypes
vim.opt.smartindent = true

--  I don't need swap as I always save file
vim.opt.swapfile = false

-- Scroll vim in tmux else it will show tmux history buffer
-- To see tmux history buffer use prefix [ and then use mouse
-- or vim navigation bindings
vim.opt.mouse = 'a'

-- Highlight the 81st character / column in every row
-- highlight ColorColumn ctermbg=magenta
-- call matchadd('ColorColumn', '\%81v', 100)

--"""""""""""""""""""""""""""""""""""
--"""""""VimGolf's .vimrc""""""""""""
--"""""""""""""""""""""""""""""""""""
vim.opt.scrolloff = 3 -- keep 3 lines when scrolling

vim.opt.backup = false -- do not keep a backup file
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line number

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- no ignorecase if Uppercase char present

-- make that backspace key work the way it should
--vim.opt.backspace=indent,eol,start

-- rmagatti/auto-session recomended
vim.o.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

-- opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.completeopt = "menu,menuone,noselect"
opt.completeopt = 'menu,menuone,noinsert'
opt.conceallevel = 3 -- Hide * markup for bold and italic
-- opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
-- opt.grepformat = '%f:%l:%c:%m'
-- opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 3 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
