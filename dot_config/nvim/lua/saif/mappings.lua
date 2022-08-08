local nnoremap = require('saif.mapping_helper').nnoremap
local xnoremap = require('saif.mapping_helper').xnoremap
local onoremap = require('saif.mapping_helper').onoremap
local vnoremap = require('saif.mapping_helper').vnoremap
local inoremap = require('saif.mapping_helper').inoremap
local tnoremap = require('saif.mapping_helper').tnoremap
-- local vimp = require('vimp')

-- keep cursor in position while joining lines
nnoremap('J', 'mzJ`z')

--##################################################################--
-- Telescope
--##################################################################--
-- local nnoremap = require('saif/mapping_helper').nnoremap

nnoremap('<leader>ff', ':Telescope find_files<cr>', { silent = false })
nnoremap('<leader>fg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>fb', ':Telescope buffers<cr>')
nnoremap('<leader>fo', ':Telescope oldfiles<cr>')
nnoremap('<leader>fh', ':Telescope help_tags<cr>')
nnoremap('<leader>fc', ':Telescope commands_history<cr>')
-- nnoremap('<leader>fcc', ':Telescope commands<cr>')
nnoremap('<leader>fq', ':Telescope quickfix<cr>')
nnoremap('<leader>fl', ':Telescope loclist<cr>')
nnoremap('<leader>fv', ':Telescope vim_options<cr>')
nnoremap('<leader>fr', ':Telescope registers<cr>')
nnoremap('<leader>fs', ':Telescope resume<cr>')
nnoremap('<leader>fi', ':Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader>fe', ':Telescope diagnostics<cr>')

nnoremap('<leader>fdc', ':Telescope file_browser<cr>')
nnoremap(
  '<leader>fdd',
  [[:lua require("telescope").extensions.file_browser.file_browser({path=vim.fn.expand('%:h')})<cr>]]
)

nnoremap(
  '<F3>',
  [[:lua require("telescope.builtin").live_grep({search_dirs={"~/.config/nvim/lua"}})<cr>]]
)
nnoremap(
  '<F4>',
  [[:lua require("telescope.builtin").live_grep({search_dirs={"~/vimwiki/"}})<cr>]]
)

-- git related settings
nnoremap('<leader>gcv', ':Telescope git_commits<cr>')
nnoremap('<leader>gcc', ':Telescope git_bcommits<cr>')

--##################################################################--
-- Harpoon
--##################################################################--

-- add file to list
nnoremap(',ff', ':lua require("harpoon.mark").add_file()<CR>')

-- add file at particular index
nnoremap(',fa', ':lua require("harpoon.mark").set_current_at(1)<CR>')
nnoremap(',fs', ':lua require("harpoon.mark").set_current_at(2)<CR>')
nnoremap(',fd', ':lua require("harpoon.mark").set_current_at(3)<CR>')

nnoremap(
  ',g',
  ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
  { silent = false }
)

nnoremap(',a', ':lua require("harpoon.ui").nav_file(1)<CR>')
nnoremap(',s', ':lua require("harpoon.ui").nav_file(2)<CR>')
nnoremap(',d', ':lua require("harpoon.ui").nav_file(3)<CR>')
-- nnoremap(',f', ':lua require("harpoon.ui").nav_file(4)')

--##################################################################--
-- Fugigitive
--##################################################################--

nnoremap('<leader>gg', ':tab G<CR>')
nnoremap('<leader>gs', ':Git<CR>')
nnoremap('<leader>gd', ':Gdiffsplit<CR>')
nnoremap('<leader>gb', ':Git blame<CR>')
--nnoremap <leader>ga :Git add %:p<CR><CR>
--nnoremap <leader>gs :Git<CR>
--nnoremap <leader>gc :Gcommit -v -q<CR>
--nnoremap <leader>gt :Gcommit -v -q %:p<CR>
--nnoremap <leader>gd :Gdiff<CR>
--nnoremap <leader>ge :Gedit<CR>
--nnoremap <leader>gr :Gread<CR>
--nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
--nnoremap <leader>gp :Ggrep<leader>
--nnoremap <leader>gm :Gmove<leader>
--nnoremap <leader>gb :Git branch<leader>
--nnoremap <leader>go :Git checkout<leader>
--nnoremap <leader>gps :Dispatch! git push<CR>
--nnoremap <leader>gpl :Dispatch! git pull<CR>

--##################################################################--
-- Text objects
--##################################################################--

--  inner/around line text objects
--  visual mode
xnoremap('il', '<ESC>^vg_')
xnoremap('al', '<ESC>0v$')
--  operator pending mode
onoremap('il', ':<C-u>normal! ^vg_<CR>')
onoremap('al', ':<C-u>normal! 0v$<CR>')

-- Complete buffer
-- xnoremap(', '<ESC>myggVG`y')
onoremap('A', ':<C-u>normal! ggVG<CR>')

--##################################################################--
-- Navigation
--##################################################################--

-- tab navigation
nnoremap('g1', '1gt')
nnoremap('g2', '2gt')
nnoremap('g3', '3gt')
nnoremap('g4', '4gt')

-- navigate to previous and next buffers
nnoremap('[b', ':bprevious<CR>')
nnoremap(']b', ':bnext<CR>')

-- Navigate windows using Ctrl
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
-- unmapping <C-l> from vimwiki
-- vim.cmd([[nunmap <C-L>]])
-- nnoremap('<C-l>', '<C-w>l')
vim.cmd([[nnoremap <C-l> <C-w>l]])

-- Navigate from terminal
tnoremap('<C-h>', '<C-\\><C-N><C-w>h')
tnoremap('<C-j>', '<C-\\><C-N><C-w>j')
tnoremap('<C-k>', '<C-\\><C-N><C-w>k')
tnoremap('<C-l>', '<C-\\><C-N><C-w>l')

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
nnoremap('<ESC>', ':nohls<CR><ESC>')

-- open file manager
nnoremap('<F2>', ':Lex<CR>')

-- Save all file
nnoremap('<Leader>a', ':wa<CR>')

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

-- vimp.nnoremap(',vr', function()
--   vimp.unmap_all()
--   require('plenary.reload').reload_module('saif')
--   dofile(vim.env.MYVIMRC)
--   print('Reloaded vimrc!')
-- end)

--TODO: fix reloading of config
function _G.reload_nvim_conf()
  for name, _ in pairs(package.loaded) do
    -- if name:match('^core') or name:match('^lsp') or name:match('^plugins') then
    if name:match('^saif') and not name:match('lsp_progress') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end

vim.keymap.set(
  'n',
  ',vr',
  '<cmd>lua reload_nvim_conf()<CR>',
  { silent = false }
)

-- Map space to leader and not changing it, the leader is still \
-- therefore using nmap because we need to use it recursively
vim.keymap.set({ 'n', 'v' }, '<SPACE>', '<Leader>', { remap = true })

--##################################################################--
-- Window management
--##################################################################--

nnoremap('<Leader>v', '<C-w>')

-- Close window
nnoremap('<Leader>c', '<C-w>c')

-- Zoom in and zoom out current window
nnoremap('<Leader>zi', '<c-w>_ | <c-w>|')
nnoremap('<Leader>zo', '<c-w>=')

-- spelling error highlight settings
-- hi clear SpellBad
-- hi SpellBad cterm=underline,bold ctermfg=red

-- The following command will let us press CTRL-N or CTRL-P in
-- insert-mode to complete the word we’re typing!
-- TODO: set this using neovim api
-- vim.opt.complete += kspell

-- toggle spell on
nnoremap(',ts', ':set spell!<CR>')
