local nnoremap = require('util.mapping_helper').nnoremap
-- local xnoremap = require('util.mapping_helper').xnoremap
-- local onoremap = require('util.mapping_helper').onoremap
local vnoremap = require('util.mapping_helper').vnoremap
local inoremap = require('util.mapping_helper').inoremap
local tnoremap = require('util.mapping_helper').tnoremap
-- local vimp = require('vimp')

-- keep cursor in position while joining lines
nnoremap('J', 'mzJ`z')

--##################################################################--
-- Copy and paste from the clipboard
--##################################################################--

vnoremap(',p', '"+p')
nnoremap(',p', '"+p')

vnoremap(',P', '"+P')
nnoremap(',P', '"+P')

vnoremap(',y', '"+y')
nnoremap(',y', '"+y')

--##################################################################--
-- Misc bindings
--##################################################################--

--map jj to esc
inoremap('jj', '<ESC>')
tnoremap('jj', '<C-\\><C-N>')

-- disable highlight on esc
nnoremap('<ESC>', '<cmd>nohls<CR><ESC>')

-- open file manager
nnoremap('<F2>', '<cmd>Lex<CR>')

-- Save all file
-- silent is not required when using <cmd>
-- but without silent it shows message of chezmoi autocmd
-- will keep silent for now
nnoremap('<Leader>a', '<cmd>silent wa<CR>')

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
nnoremap('<Leader>tc', '<cmd>tabc<CR>')

-- Zoom in and zoom out current window
nnoremap('<Leader>zi', '<c-w>_ | <c-w>|')
nnoremap('<Leader>zo', '<c-w>=')

-- tab navigation
nnoremap('g1', '1gt')
nnoremap('g2', '2gt')
nnoremap('g3', '3gt')
nnoremap('g4', '4gt')

nnoremap('<Right>', 'gt')
nnoremap('<Left>', 'gT')

-- navigate to previous and next buffers
nnoremap('[b', '<cmd>bprevious<CR>')
nnoremap(']b', '<cmd>bnext<CR>')

-- Navigate from terminal
-- tnoremap('<C-h>', '<C-\\><C-N><C-w>h')
-- tnoremap('<C-j>', '<C-\\><C-N><C-w>j')
-- tnoremap('<C-k>', '<C-\\><C-N><C-w>k')
-- tnoremap('<C-l>', '<C-\\><C-N><C-w>l')

--##################################################################--
-- Spell settings
--##################################################################--

-- spelling error highlight settings
-- hi clear SpellBad
-- hi SpellBad cterm=underline,bold ctermfg=red

-- The following command will let us press CTRL-N or CTRL-P in
-- insert-mode to complete the word we’re typing!
-- TODO: set this using neovim api
-- vim.opt.complete += kspell

-- toggle spell on
nnoremap(',ts', '<cmd>set spell!<CR>')
