local keys = function()
  return {

    -- Telescope related keymaps moved to Telescope file
    -- { '<leader>gC', '<cmd>Telescope git_commits<cr>' },
    -- { '<leader>gcc', '<cmd>Telescope git_bcommits<cr>' },

    { '<leader>gg', '<cmd>tab G<CR>' },
    { '<leader>gs', '<cmd>Git<CR>' },
    { '<leader>gd', '<cmd>Gdiffsplit<CR>' },
    { '<leader>gb', '<cmd>Git blame<CR>' },

    -- <leader>ga :Git add %:p<CR><CR>
    -- <leader>gs :Git<CR>
    -- <leader>gc :Gcommit -v -q<CR>
    -- <leader>gt :Gcommit -v -q %:p<CR>
    -- <leader>gd :Gdiff<CR>
    -- <leader>ge :Gedit<CR>
    -- <leader>gr :Gread<CR>
    -- <leader>gl :silent! Glog<CR>:bot copen<CR>
    -- <leader>gp :Ggrep<leader>
    -- <leader>gm :Gmove<leader>
    -- <leader>gb :Git branch<leader>
    -- <leader>go :Git checkout<leader>
    -- <leader>gps :Dispatch! git push<CR>
    -- <leader>gpl :Dispatch! git pull<CR>
  }
end

return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = keys,
}
