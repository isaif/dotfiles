return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local actions = require('fzf-lua.actions')
    return {
      -- winopts = {
      --   -- Use **only one** of the below options
      --   split = 'aboveleft new',
      -- },
      keymap = {
        builtin = {
          true,
          ['<C-space>'] = 'hide', -- hide fzf-lua, `:FzfLua resume` to continue
          ['M-ESC'] = 'ignore',
        },
      },
      actions = {
        files = {
          false,
          ['enter'] = actions.file_edit_or_qf, -- multiple selection to qf
          ['ctrl-x'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
          ['ctrl-t'] = actions.file_tabedit,
          ['ctrl-q'] = {
            fn = actions.file_sel_to_qf,
            prefix = 'select-all+',
          }, -- send all files i.e. both selected and not selected
          -- ['alt-Q'] = actions.file_sel_to_ll,
        },
      },
    }
  end,
  keys = {
    -- { '<leader>e', '<cmd>Fzflua files resume=true <cr>' },
    { '<leader>e', '<cmd>FzfLua files resume=true<cr>' },
    { '<leader>ss', '<cmd>FzfLua live_grep resume=true<cr>' },
    { '<leader>lq', '<cmd>FzfLua quickfix<cr>' },
    { '<C-space>', '<cmd>FzfLua resume<cr>' },
  },
}
