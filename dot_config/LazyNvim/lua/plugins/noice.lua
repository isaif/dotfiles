return {
  'folke/noice.nvim',
  -- event = 'VimEnter',
  -- config = function()
  -- require('saif.configs.noice')
  -- end,
  dependencies = {
    -- if you lazy-load any plugin below,
    -- make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --`nvim-notify` is only needed, if you want to use the notification view.
    -- If not available, we use `mini` as the fallback
    -- use({
    --   'rcarriga/nvim-notify',
    --   config = function()
    --     require('notify').setup({
    --       render = 'minimal',
    --     })
    --   end,
    -- }),
  },
}
