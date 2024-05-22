local opts = function()
  local actions = require('telescope.actions')
  local action_layout = require('telescope.actions.layout')

  return {
    defaults = {
      prompt_prefix = ' ',
      selection_caret = ' ',
      layout_config = {
        preview_width = 80,
      },
      history = {
        path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
        limit = 100,
      },
      mappings = {
        i = {
          ['<C-p>'] = action_layout.toggle_preview,

          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,

          -- cycle previewer for git commits to show full message
          ['<C-n>'] = actions.cycle_previewers_next,
          -- ['<C-p>'] = actions.cycle_previewers_prev,

          -- ['<C-b>'] = actions.preview_scrolling_up,
          -- ['<C-f>'] = actions.preview_scrolling_down,

          -- don't go into normal mode, just close
          ['<Esc>'] = actions.close,

          -- history navigation for smart_history
          ['<C-l>'] = actions.cycle_history_next,
          ['<C-h>'] = actions.cycle_history_prev,
        },
        n = {
          ['<C-p>'] = action_layout.toggle_preview,

          -- cycle previewer for git commits to show full message
          ['<C-n>'] = actions.cycle_previewers_next,
          -- ['<C-p>'] = actions.cycle_previewers_prev,
        },
      },
    },
  }
end

local keys = function()
  local function live_grep_dir(dir)
    return require('telescope.builtin').live_grep({
      search_dirs = { dir },
    })
  end

  return {

    { '<leader>e', '<cmd>Telescope find_files<cr>' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fo', '<cmd>Telescope oldfiles<cr>' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    { '<leader>fc', '<cmd>Telescope commands_history<cr>' },
    { '<leader>fq', '<cmd>Telescope quickfix<cr>' },
    { '<leader>fl', '<cmd>Telescope loclist<cr>' },
    { '<leader>fv', '<cmd>Telescope vim_options<cr>' },
    { '<leader>fr', '<cmd>Telescope registers<cr>' },
    { '<leader>ff', '<cmd>Telescope resume<cr>' },
    { '<leader>fi', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
    -- { '<leader>fe', '<cmd>Telescope diagnostics<cr>' },

    -- git
    { '<leader>gC', '<cmd>Telescope git_commits<CR>' },
    -- commit for current file
    { '<leader>gc', '<cmd>Telescope git_bcommits<cr>' },
    -- { '<leader>gs', '<cmd>Telescope git_status<CR>' },

    -- Mappings for telescope file_browser extension
    -- C-g to go to parent directory
    -- C-w to go to working directory
    -- ('<leader>fD', '<cmd>Telescope file_browser previewer=false<cr>')
    -- { '<leader>fD', '<cmd>Telescope file_browser<cr>' },
    -- { '<leader>fd', '<cmd>Telescope file_browser path=%:p:h<cr>' },

    -- rename current file
    -- ('<leader>r', function()
    --   require('telescope').extensions.file_browser.file_browser({
    --     path = '%:p:h',
    --     select_buffer = true,
    --   })
    -- end)

    {
      '<F3>',
      function()
        live_grep_dir('~/.config/nvim/lua')
      end,
    },

    {
      '<F4>',
      function()
        live_grep_dir('~/vimwiki/')
      end,
    },
  }
end

return {
  'nvim-telescope/telescope.nvim',
  opts = opts,
  keys = keys,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'nvim-telescope/telescope-smart-history.nvim',
      dependencies = 'tami5/sqlite.lua',
      config = function()
        require('telescope').load_extension('smart_history')
      end,
    },
  },
}
