local opts = function()
  local actions = require('telescope.actions')
  local action_layout = require('telescope.actions.layout')

  -- Go to preview window
  -- useful for quick operations like yanking
  -- https://github.com/nvim-telescope/telescope.nvim/issues/2778#issuecomment-2202572413
  local focus_preview = function(prompt_bufnr)
    local action_state = require('telescope.actions.state')
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt_win = picker.prompt_win
    local previewer = picker.previewer
    local winid = previewer.state.winid
    local bufnr = previewer.state.bufnr
    vim.keymap.set('n', '<f4>', function()
      vim.cmd(
        string.format(
          'noautocmd lua vim.api.nvim_set_current_win(%s)',
          prompt_win
        )
      )
    end, { buffer = bufnr })
    vim.cmd(
      string.format('noautocmd lua vim.api.nvim_set_current_win(%s)', winid)
    )
    -- api.nvim_set_current_win(winid)
  end

  return {
    defaults = {
      prompt_prefix = ' ',
      selection_caret = ' ',
      layout_config = {
        preview_width = 80,
      },
      -- history = {
      --   path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      --   limit = 100,
      -- },
      mappings = {
        i = {
          ['<C-p>'] = action_layout.toggle_preview,
          ['<C-u>'] = false,

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
          -- ['<C-l>'] = actions.cycle_history_next,
          -- ['<C-h>'] = actions.cycle_history_prev,
          ['<f4>'] = focus_preview,
        },
        n = {
          ['<C-p>'] = action_layout.toggle_preview,
          ['<f4>'] = focus_preview,

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
    -- for `find_files`, `live_grep`, `grep_string` and `git_files`
    -- check telescope_menufacture

    -- { '<leader>tb', '<cmd>Telescope buffers<cr>' },
    { '<leader>to', '<cmd>Telescope oldfiles<cr>' },
    { '<leader>th', '<cmd>Telescope help_tags<cr>' },
    { '<leader>tc', '<cmd>Telescope commands_history<cr>' },
    { '<leader>tq', '<cmd>Telescope quickfix<cr>' },
    { '<leader>tl', '<cmd>Telescope loclist<cr>' },
    { '<leader>tv', '<cmd>Telescope vim_options<cr>' },
    { '<leader>tr', '<cmd>Telescope registers<cr>' },
    { '<leader>tt', '<cmd>Telescope resume<cr>' },
    { '<leader>ti', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
    -- { '<leader>fe', '<cmd>Telescope diagnostics<cr>' },

    -- git
    { '<leader>gL', '<cmd>Telescope git_commits<CR>' },
    -- commit for current file
    { '<leader>gl', '<cmd>Telescope git_bcommits<cr>' },
    -- { '<leader>gs', '<cmd>Telescope git_status<CR>' },

    {
      '<F3>',
      function()
        live_grep_dir('~/.config/nvim/lua')
      end,
    },

    -- {
    --   '<F4>',
    --   function()
    --     live_grep_dir('~/vimwiki/')
    --   end,
    -- },
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
    -- {
    --   'nvim-telescope/telescope-smart-history.nvim',
    --   dependencies = 'tami5/sqlite.lua',
    --   config = function()
    --     require('telescope').load_extension('smart_history')
    --   end,
    -- },
  },
}
