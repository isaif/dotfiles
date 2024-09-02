local nnoremap = require('util.mapping_helper').nnoremap
-- local xnoremap = require('util.mapping_helper').xnoremap
-- local onoremap = require('util.mapping_helper').onoremap
local vnoremap = require('util.mapping_helper').vnoremap
local inoremap = require('util.mapping_helper').inoremap
local tnoremap = require('util.mapping_helper').tnoremap
-- local vimp = require('vimp')

nnoremap('<Space>', '<Leader>', { remap = true })
vnoremap('<Space>', '<Leader>', { remap = true })

-- keep cursor in position while joining lines
-- this uses z register as a mark
nnoremap('J', 'mzJ`z')

-- Don't move to next word when using *
nnoremap('*', '*Nzz')

--##################################################################--
-- Copy and paste from the clipboard
--##################################################################--

vnoremap('cp', '"+p')
nnoremap('cp', '"+p')

-- vnoremap('cP', '"+P')

-- paste content in a new line
-- nnoremap('cP', 'O<ESC>"+p')
-- using 'O' will start a new line with comment
-- if current line is a comment so it needs to be deleted
nnoremap('cP', 'O<ESC>^d$"+p')

vnoremap('cy', '"+y')
nnoremap('cy', '"+y')

--##################################################################--
-- Misc keymaps
--##################################################################--

--map jj to esc
inoremap('jj', '<ESC>')
tnoremap('jj', '<C-\\><C-N>')

-- TODO: autocmd to disable highlight on cursor move
-- disable highlight on esc
nnoremap('<ESC>', '<cmd>nohls<CR><ESC>')

-- open file manager
-- using neo tree plugin
-- nnoremap('<F2>', '<cmd>Lex<CR>')

-- Save all file
-- silent is not required when using <cmd>
-- but without silent it shows message of chezmoi autocmd
-- will keep silent for now
nnoremap('<Leader>w', '<cmd>silent wa<CR>')

-- Run last command
-- warning:
-- If the last run command was to quit then it will run that too
-- @: can be used to run the last command
nnoremap('<leader>r', '@:')

-- open list of all commands and move it up on last run command
-- to use q to quit this window, add 'vim' filetype to autocmd
-- for closing windows using q
nnoremap('<leader>;', 'q:<up>')

--##################################################################--
-- Editing keymaps
--##################################################################--

-- Copy, comment it and then paste
-- It requires Comment.nvim plugin for commenting
-- Comment a line and paste it below
nnoremap(',c', '<cmd>normal yygccp<CR>')
-- Comment selection and paste it below
vnoremap(',c', '<cmd>normal ygvgbp<CR>')

-- Add empty lines before and after cursor line
nnoremap('gO', "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
nnoremap('go', "<cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Uppercase a word
nnoremap(',u', 'vaWUe')

-- Replace a WORD under cursor in file and line
-- this doesn't work correctly as it searchs for WORD followed by a space
nnoremap(',rrf', ':%s/<C-r><C-a> //g<Left><Left>')
nnoremap(',rrl', ':s/<C-r><C-a> //g<Left><Left>')

-- Replace a word under cursor in file and line
-- a word can contain alphbets numerals underscore
-- \<\> is use to match exact
-- :%s/\<WordToReplace\>/New/g
nnoremap(',rf', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
nnoremap(',rl', [[:s/\<<C-r><C-w>\>//g<Left><Left>]])

--##################################################################--
-- Window and Tab management
--##################################################################--

-- nnoremap('<Leader>w', '<C-w>')

-- Close window
nnoremap('<Leader>c', '<C-w>c')

-- Close tab
nnoremap('<Leader> c', '<cmd>tabclose<CR>')

-- Close tab and go to previous accessed tab
-- TODO: add error handling
-- nnoremap('<Leader>tc', function()
--   -- vim.cmd.normal('g\t')
--   -- vim.api.nvim_command('tabclose #')
--   -- local tabpage = vim.api.nvim_win_get_tabpage()
--   -- print(tabpage)
-- end)

-- Zoom in and zoom out current window
-- now using maximize.nvim plugin
-- nnoremap('<Leader>zi', '<c-w>_ | <c-w>|')
-- nnoremap('<Leader>zo', '<c-w>=')

-- Tab navigation
nnoremap('g1', '1gt')
nnoremap('g2', '2gt')
nnoremap('g3', '3gt')
nnoremap('g4', '4gt')

-- Tab navigation using arrow keys
nnoremap('<Right>', 'gt')
nnoremap('<Left>', 'gT')

-- Navigate from terminal
-- tnoremap('<C-h>', '<C-\\><C-N><C-w>h')
-- tnoremap('<C-j>', '<C-\\><C-N><C-w>j')
-- tnoremap('<C-k>', '<C-\\><C-N><C-w>k')
-- tnoremap('<C-l>', '<C-\\><C-N><C-w>l')

-- toggle spell on
-- nnoremap(',ts', '<cmd>set spell!<CR>')
