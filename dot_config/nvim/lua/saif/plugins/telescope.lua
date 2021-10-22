local nnoremap = require('saif/mapping_helper').nnoremap

nnoremap('<leader>ff', ':Telescope find_files<cr>')
nnoremap('<leader>fg', ':Telescope live_grep<cr>')
nnoremap('<leader>fb', ':Telescope buffers<cr>')
nnoremap('<leader>fh', ':Telescope help_tags<cr>')
nnoremap('<leader>fc', ':Telescope commands<cr>')

