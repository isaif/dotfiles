local opts = function()
  local have_type, types = pcall(require, 'luasnip.util.types')
  if not have_type then
    return
  end

  return {
    delete_check_events = 'TextChanged',

    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = 'TextChanged,TextChangedI',

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    -- ext_opts = nil,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<-', 'Error' } },
        },
      },
    },
  }
end

local keys = function()
  local have_luasnip, ls = pcall(require, 'luasnip')
  if not have_luasnip then
    return
  end

  return {
    -- <c-j> is my expansion key
    -- this will expand the current item or jump to the next item
    -- within the snippet.
    {
      '<c-j>',
      function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
      silent = true,
      mode = { 'i', 's' },
    },
    -- <c-k> is my jump backwards key.
    -- this always moves to the previous item within the snippet
    {
      '<c-k>',
      function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      silent = true,
      mode = { 'i', 's' },
    },
    -- <c-l> is selecting within a list of options.
    {
      '<c-l>',
      function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      silent = true,
      mode = 'i',
    },
  }
end

return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
  opts = opts,
  keys = keys,
  config = function()
    local have_luasnip, ls = pcall(require, 'luasnip')
    if not have_luasnip then
      return
    end

    ls.filetype_extend('javascript', { 'javascriptreact' })
    ls.filetype_extend('javascript', { 'html' })
  end,
}
