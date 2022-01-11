local nnoremap = require('vimp').nnoremap
local xnoremap = require('vimp').xnoremap
local onoremap = require('vimp').onoremap
-- local vnoremap = require('vimp').vnoremap

nnoremap('J', 'mzJ`z')

--##################################################################--
-- Telescope
--##################################################################--
-- local nnoremap = require('saif/mapping_helper').nnoremap

nnoremap('<leader>ff', ':Telescope find_files<cr>')
nnoremap('<leader>fg', ':Telescope live_grep<cr>')
nnoremap('<leader>fb', ':Telescope buffers<cr>')
nnoremap('<leader>fd', ':Telescope file_browser<cr>')
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

nnoremap('<F3>', [[:lua require("telescope.builtin").live_grep({search_dirs={"~/.config/nvim/"}})<cr>]])
nnoremap('<F4>', [[:lua require("telescope.builtin").live_grep({search_dirs={"~/vimwiki/"}})<cr>]])

-- git related settings
nnoremap('<leader>gc', ':Telescope git_commits<cr>')
nnoremap('<leader>gb', ':Telescope git_bcommits<cr>')


--##################################################################--
-- Harpoon
--##################################################################--

nnoremap(',f', ':lua require("harpoon.mark").add_file()<CR>')
nnoremap(',g', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

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
-- nnoremap('<leader>gb', ':Git blame<CR>')
--nnoremap <leader>ga :Git add %:p<CR><CR>
-- nnoremap <leader>gs :Git<CR>
--nnoremap <leader>gc :Gcommit -v -q<CR>
--nnoremap <leader>gt :Gcommit -v -q %:p<CR>
-- nnoremap <leader>gd :Gdiff<CR>
--nnoremap <leader>ge :Gedit<CR>
--nnoremap <leader>gr :Gread<CR>
--nnoremap <leader>gw :Gwrite<CR><CR>
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
xnoremap({'silent'}, 'il', '<ESC>^vg_')
xnoremap({'silent'}, 'al', '<ESC>0v$')
--  operator pending mode
onoremap({'silent'}, 'il', ':<C-u>normal! ^vg_<CR>')
onoremap({'silent'}, 'al', ':<C-u>normal! 0v$<CR>')

-- Complete buffer
-- xnoremap({'silent'}, 'A', '<ESC>myggVG`y')
onoremap({'silent'}, 'A', ':<C-u>normal! ggVG<CR>')

