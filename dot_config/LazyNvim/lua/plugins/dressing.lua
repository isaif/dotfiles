-- better UI experience
-- like noice does for  messages, cmdline and the popupmenu.
-- for vim.ui.select and vim.ui.input
return {
  'stevearc/dressing.nvim',
  opts = {
    select = {
      backend = { 'nui', 'telescope', 'fzf_lua', 'fzf', 'builtin' },
      -- get_config = function(opts)
      --   if opts.kind == 'codeaction' then
      --     return {
      --       backend = 'nui',
      --       nui = {
      --         relative = 'cursor',
      --         max_width = 40,
      --       },
      --     }
      --   end
      -- end,
    },
  },
}
