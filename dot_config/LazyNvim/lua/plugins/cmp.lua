local opts = function()
  local lspkind = require('lspkind')
  lspkind.init()

  -- Setup nvim-cmp.
  local cmp = require('cmp')

  return {
    -- completion = {
    --   completeopt = 'menu,menuone,noinsert',
    -- },

    -- Luasnip settings
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

      ['<C-Space>'] = cmp.mapping.complete(),

      -- Specify `cmp.config.disable` to remove the default `<C-y>` mapping.
      --   ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping.abort(),

      -- Accept currently selected item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<TAB>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lua' },
      { name = 'nvim_lsp', max_item_count = 15 },
      { name = 'path' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer', keyword_length = 5 },
    }),

    -- TODO: fix this, copied from lazyVim
    -- formatting = {
    --   format = function(_, item)
    --     local lspkind = require('lspkind')
    --     local icons = require('lazyvim.config').icons.kinds
    --     if icons[item.kind] then
    --       item.kind = icons[item.kind] .. item.kind
    --     end
    --     return item
    --   end,
    -- },

    experimental = {
      ghost_text = {
        hl_group = 'LspCodeLens',
      },
    },

    formatting = {
      format = lspkind.cmp_format({
        mode = 'text_symbol',
        menu = {
          buffer = '[buf]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[api]',
          path = '[path]',
          luasnip = '[snip]',
        },
      }),
    },
  }
end

return {
  'hrsh7th/nvim-cmp',
  version = false, -- last release is way too old
  event = 'InsertEnter',
  opts = opts,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    -- 'saadparwaiz1/cmp_luasnip',
    -- lspkind to show symbols in completion menu
    'onsails/lspkind-nvim',
  },
}
