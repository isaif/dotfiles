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
nnoremap('J', 'mzJ`z')

--##################################################################--
-- Copy and paste from the clipboard
--##################################################################--

vnoremap('cp', '"+p')
nnoremap('cp', '"+p')

vnoremap('cP', '"+P')
nnoremap('cP', '"+P')

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
nnoremap('<F2>', '<cmd>Lex<CR>')

-- Save all file
-- silent is not required when using <cmd>
-- but without silent it shows message of chezmoi autocmd
-- will keep silent for now
nnoremap('<Leader>a', '<cmd>silent wa<CR>')

--##################################################################--
-- Editing keymaps
--##################################################################--

-- Copy, comment it and then paste
-- It requires Comment.nvim plugin for commenting
nnoremap(',c', '<cmd>normal yygccp<CR>')
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

-- Close tab and go to previous accessed tab
nnoremap('<Leader>tc', function()
  local tabnr = vim.api.nvim_get_current_tabpage()
  vim.cmd.normal('g\t')
  vim.api.nvim_command(tabnr .. 'tabclose')
end)

-- Zoom in and zoom out current window
nnoremap('<Leader>zi', '<c-w>_ | <c-w>|')
nnoremap('<Leader>zo', '<c-w>=')

-- Tab navigation
nnoremap('g1', '1gt')
nnoremap('g2', '2gt')
nnoremap('g3', '3gt')
nnoremap('g4', '4gt')

-- Tab navigation using arrow keys
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

-- toggle spell on
nnoremap(',ts', '<cmd>set spell!<CR>')
