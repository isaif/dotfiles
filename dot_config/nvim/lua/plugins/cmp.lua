return {
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-path',

    'hrsh7th/cmp-nvim-lua',
    -- 'saadparwaiz1/cmp_luasnip',

    { 'hrsh7th/cmp-cmdline', event = { 'CmdlineEnter' } },

    -- completion source for all file contents in a directory using ripgrep
    -- using this in insert mode completion not for searching with / or ?
    'lukas-reineke/cmp-rg',

    -- fuzzy for buffer contents
    -- rg is good but it can't handle spaces between words
    -- can't use rg for / and ? as it would search whole project
    -- cmp-buffer is also fuzzy but
    { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'tzachar/fuzzy.nvim' } },

    -- fuzzy for path and buffer contents
    { 'tzachar/cmp-fuzzy-path', dependencies = { 'tzachar/fuzzy.nvim' } },

    -- 'kbwo/cmp-yank',

    -- provides a source for all the lines in the current buffer.
    -- This is especially useful for C programmers.
    -- It uses tree-sitter (optional) if you have it installed on your system.
    -- it can take space between words, it matched three partial words with space
    -- it can also be used for / and ? but cmp-fuzzy-buffer is providing same feature
    'amarakon/nvim-cmp-buffer-lines',

    -- lspkind to show symbols in completion menu
    'onsails/lspkind-nvim',
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
        -- { name = 'yank' },
        { name = 'nvim_lua' },

        -- { name = 'nvim_lsp', max_item_count = 15 },
        { name = 'nvim_lsp' },

        -- { name = 'path' },
        { name = 'fuzzy_path' },

        { name = 'luasnip' }, -- For luasnip users.

        -- { name = 'buffer', keyword_length = 4 },
        { name = 'fuzzy_buffer', keyword_length = 4 },
        {
          name = 'rg',
          -- Try it when you feel cmp performance is poor
          -- keyword_length = 3
        },
        { name = 'buffer-lines', keyword_length = 5 },
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
            fuzzy_buffer = '[buf]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[api]',
            -- path = '[path]',
            fuzzy_path = '[path]',
            luasnip = '[snip]',
            rg = '[Rg]',
            buffer_lines = '[bufL]',
            -- yank = '[Yank]',
          },
        }),
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        -- { { name = 'path' } },
        { name = 'fuzzy_path' },
        -- { { name = 'cmdline', keyword_length = 2 } }
        { name = 'cmdline' },
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        -- { name = 'buffer', keyword_length = 2 },
        -- { name = 'buffer' },
        { name = 'fuzzy_buffer' },
      },
    })

    -- required setup for genghis plugin
    cmp.setup.filetype('DressingInput', {
      sources = cmp.config.sources({ { name = 'omni' } }),
    })
  end,
}
