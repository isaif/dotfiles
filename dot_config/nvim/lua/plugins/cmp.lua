return {
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    -- 'saadparwaiz1/cmp_luasnip',
    -- lspkind to show symbols in completion menu
    'onsails/lspkind-nvim',
    { 'hrsh7th/cmp-cmdline', event = { 'CmdlineEnter' } },
    -- {
    --   'hrsh7th/cmp-cmdline',
    -- },
  },

  init = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  end,

  config = function()
    local cmp = require('cmp')

    cmp.setup({
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
        -- sources = {
        { name = 'nvim_lua' },
        -- { name = 'nvim_lsp', max_item_count = 15 },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'buffer', keyword_length = 4 },
      }),

      experimental = {
        ghost_text = {
          hl_group = 'LspCodeLens',
        },
      },

      formatting = {
        format = require('lspkind').cmp_format({
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
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        { { name = 'path' } },
        -- { { name = 'cmdline', keyword_length = 2 } }
        { { name = 'cmdline' } }
      ),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        -- { name = 'buffer', keyword_length = 2 },
        { name = 'buffer' },
      },
    })

    -- required setup for genghis plugin
    cmp.setup.filetype('DressingInput', {
      sources = cmp.config.sources({ { name = 'omni' } }),
    })

  end,
}
