local nnoremap = require('vimp').nnoremap
local vnoremap = require('vimp').vnoremap

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


