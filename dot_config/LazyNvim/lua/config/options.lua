local opt = vim.opt

--"""""""""""""""""""""""""""""""""""
--"""""""Personal customization""""""
--"""""""""""""""""""""""""""""""""""

-- Search files using fuzzy
-- opt.path+=**
-- opt.wildmenu

-- hide the command bar below the statusline
opt.cmdheight = 0

-- hide tabline
opt.showtabline = 0
opt.showcmdloc = 'statusline'

opt.guicursor = 'a:block' -- block cursor
opt.termguicolors = true -- true color support

--This will cause wrap to only wrap at the characters in the breakat
--setting, which defaults to space, tab, and small vim.opt.of punctuation characters.
opt.linebreak = true

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal blocks
-- of text.
opt.breakindent = true

-- Maintain undo history between sessions
--opt.undofile = true
--opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'

--remove delay switching between insert and normal mode
opt.ttimeoutlen = 10

-- smartindent will indent lines based on indent in surrounding lines
-- useful when indent is not set for some filetypes
opt.smartindent = true -- Insert indents automatically

--  I don't need swap as I always save file
opt.swapfile = false

-- Scroll vim in tmux else it will show tmux history buffer
-- To see tmux history buffer use prefix [ and then use mouse
-- or vim navigation bindings
-- enables mouse mode
opt.mouse = 'a'

-- Highlight the 81st character / column in every row
-- highlight ColorColumn ctermbg=magenta
-- call matchadd('ColorColumn', '\%81v', 100)

--"""""""""""""""""""""""""""""""""""
--"""""""VimGolf's .vimrc""""""""""""
--"""""""""""""""""""""""""""""""""""
opt.scrolloff = 3 -- keep 3 lines when scrolling

opt.backup = false -- do not keep a backup file
opt.number = true -- show line numbers
opt.relativenumber = true -- show relative line number

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- no ignorecase if Uppercase char present

-- make that backspace key work the way it should
-- opt.backspace=indent,eol,start

-- rmagatti/auto-session recomended
opt.sessionoptions = {
  'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions',
}

-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- TODO: find more about this options
-- Infer letter cases for a richer built-in keyword completion
-- opt.infercase = true
-- opt.virtualedit = 'block' -- Allow going past the end of line in visual block mode
-- opt.formatoptions = 'qjl1' -- Don't autoformat comments

-- opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.completeopt = "menu,menuone,noselect"
-- opt.completeopt = 'menu,menuone,noinsert'
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
-- opt.formatoptions = 'jcroqlnt' -- tcqj
-- opt.grepformat = '%f:%l:%c:%m'
-- opt.grepprg = 'rg --vimgrep'
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...

opt.pumblend = 10 -- Make builtin completion menus slightly transparent
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.winblend = 10 -- Make floating windows slightly transparent

-- TODO: know more about this options
-- opt.listchars = 'extends:…,precedes:…,nbsp:␣' -- Define which helper symbols to show
-- opt.list = true -- Show some helper symbols

opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent

-- TODO: find more about this option
opt.shortmess:append({ W = true, I = true, c = true })
-- opt.shortmess:append('WcC') -- Reduce command line messages

opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
-- opt.softtabstop = 2 -- TODO: forgot about this option
-- opt.timeoutlen = 300 -- mapping timeout
opt.undolevels = 10000
-- opt.updatetime = 200 -- Save swap file and trigger CursorHold
-- opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
-- opt.wrap = false -- Disable line wrap
opt.updatetime = 100 -- faster completion (4000ms default)

opt.splitkeep = 'screen' -- Reduce scroll during window split
-- if vim.fn.has('nvim-0.9.0') == 1 then
--   opt.splitkeep = 'screen'
--   -- opt.shortmess:append({ C = true })
-- end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- spelling error highlight settings
-- hi clear SpellBad
-- hi SpellBad cterm=underline,bold ctermfg=red

-- The following command will let us press CTRL-N or CTRL-P in
-- insert-mode to complete the word we’re typing!
-- TODO: set this using neovim api
-- vim.opt.complete += kspell
