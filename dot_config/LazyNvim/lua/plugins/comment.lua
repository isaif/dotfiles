return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  -- TODO: opts also works as seen in LazyVim
  -- opts = {
  --   pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  -- },
  config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  dependencies = {
    -- this is used for commenting jsx/tsx files
    --A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
    { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
  },
}
