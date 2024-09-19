return {
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',

    'hrsh7th/cmp-nvim-lua',

    { 'hrsh7th/cmp-cmdline', event = { 'CmdlineEnter' } },

    -- Completion source for all file contents in a directory using ripgrep
    -- Using this in insert mode completion not for searching with / or ?
    -- It can't handle spaces between words
    -- Also can't use it for / and ? as it would search whole project
    -- It has only single word completion unlike cmp-fuzzy-buffer which can complete
    -- words separated by punctuation
    'lukas-reineke/cmp-rg',

    -- Fuzzy completion for buffer contents
    -- Depends on fuzzy.nvim (which depends either on fzf or on fzy).
    -- In / search mode, the plugin will match the input string as is, without parsing out tokens.
    -- This enables fuzzy search containing, for example, spaces.
    -- hrsh7th/cmp-buffer is also fuzzy but I will use this
    { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'tzachar/fuzzy.nvim' } },

    -- source for filesystem paths, employing fd and regular expressions to find files.
    { 'tzachar/cmp-fuzzy-path', dependencies = { 'tzachar/fuzzy.nvim' } },

    -- provides a source for all the lines in the current buffer.
    -- This is especially useful for C programmers.
    -- It uses tree-sitter (optional) if you have it installed on your system.
    -- it can take space between words, it matched three partial words with space
    -- it can also be used for / and ? but cmp-fuzzy-buffer is providing same feature
    -- 'amarakon/nvim-cmp-buffer-lines',

    -- lspkind to show symbols in completion menu
    'onsails/lspkind-nvim',
    -- yank history (clipboard history) from yanky.nvim.
    'chrisgrieser/cmp_yanky',
  },

  opts = function()
    local cmp = require('cmp')

    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = 'menu,menuone,noselect',
        -- .. (auto_select and '' or ',noselect'),
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
        { name = 'nvim_lsp' },
        { name = 'fuzzy_path' },

        { name = 'fuzzy_buffer', keyword_length = 3 },
        {
          name = 'rg',
          keyword_length = 4,
          max_item_count = 10,
        },
        { name = 'cmp_yanky' },
        -- { name = 'buffer-lines', keyword_length = 5 },
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
            fuzzy_path = '[path]',
            luasnip = '[snip]',
            rg = '[Rg]',
            cmp_yanky = '[yanky]',
            -- buffer_lines = '[bufL]',
          },
        }),
      },
    }
  end,

  config = function(_, opts)
    local cmp = require('cmp')
    cmp.setup(opts)
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'fuzzy_path' },
        { name = 'cmdline' },
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'fuzzy_buffer' },
      },
    })
  end,
}
