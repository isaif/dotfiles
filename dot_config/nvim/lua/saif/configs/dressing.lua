require('dressing').setup({
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
})
