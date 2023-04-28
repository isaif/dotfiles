return {
  'numToStr/Comment.nvim',
  -- event = 'VeryLazy',
  -- event = 'InsertEnter',
  event = 'CursorHold',
  -- TODO: lazy loading
  -- there is a discussion on the repo of lazy.nvim about passing default keys
  -- of a plugin to keys, so that we can load the plugin on pressing default
  -- keymaps lazy = true,
  config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  dependencies = {
    -- this is used for commenting jsx/tsx files
    -- A Neovim plugin for setting the commentstring option based on the cursor
    -- location in the file. The location is checked via treesitter queries.
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    config = function()
      require('nvim-treesitter.configs').setup({
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}
