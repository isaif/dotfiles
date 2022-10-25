-- highlight yanked
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

--"""""""""""""""""""""""""""""""""""
--"""""""Personal customization""""""
--"""""""""""""""""""""""""""""""""""

vim.opt.cmdheight = 0

-- This option makes cursor as block cursor in nvim
vim.opt.guicursor = 'a:block'

vim.opt.relativenumber = true

--This will cause wrap to only wrap at the characters in the breakat
--setting, which defaults to space, tab, and small vim.opt.of punctuation characters.
vim.opt.linebreak = true

-- Search files using fuzzy
-- vim.opt.path+=**
-- vim.opt.wildmenu

-- Maintain undo history between sessions
-- TODO can we share same undo dir with neovim and vim
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'

--remove delay switching between insert and normal mode
vim.opt.ttimeoutlen = 10

-- smartindent will indent lines based on indent in surrounding lines
-- useful when indent is not set for some filetypes
vim.opt.smartindent = true

-- see if I can do without swapfile
-- I always save file
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

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- no ignorecase if Uppercase char present

-- make that backspace key work the way it should
--vim.opt.backspace=indent,eol,start
