local present, packer = pcall(require, 'saif.packer.packer_init')

if not present then
  return false
end

return packer.startup(function(use)
  -- Packer can manage itself
  -- without this option packer will keep asking if you want
  -- to remove packer folder from the .local/nvim/ plugin folder
  use('wbthomason/packer.nvim')

  --##################################################################
  -- LSP and friends
  --##################################################################

  use('neovim/nvim-lspconfig')
  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  })
  -- use('williamboman/nvim-lsp-installer')

  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('saif.configs.treesitter')
    end,
    run = ':TSUpdate',
  })

  -- -- coq completion plugin
  -- use {'ms-jpq/coq_nvim', branch= 'coq'}
  -- -- 9000+ Snippets
  -- use {'ms-jpq/coq.artifacts', branch= 'artifacts'}

  -- cmp-nvim completion plugin
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      use({
        'L3MON4D3/LuaSnip',
        -- event = 'CursorHold',
        after = 'nvim-cmp',
        config = function()
          require('saif.configs.luasnip')
        end,
        requires = { 'rafamadriz/friendly-snippets' },
      }),
    },
    config = function()
      require('saif.configs.cmp')
    end,
  })

  -- lspkind to show symbols in completion menu
  use('onsails/lspkind-nvim')

  --##################################################################
  -- Debugging
  --##################################################################

  -- use({
  --   'hkupty/iron.nvim',
  --   config = function()
  --     require('saif.configs.iron')
  --   end,
  -- })

  --##################################################################
  -- Navigation
  --##################################################################

  use({
    'nvim-telescope/telescope.nvim',
    config = function()
      require('saif.configs.telescope')
    end,
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-file-browser.nvim' })
  -- show media preview in telescope
  -- doesn't work with find_files currently
  -- use('nvim-telescope/telescope-media-files.nvim')

  use('ThePrimeagen/harpoon')

  use('christoomey/vim-tmux-navigator')

  -- To manage tags
  -- use 'ludovicchabant/vim-gutentags'

  -- use({
  --   'ggandor/lightspeed.nvim',
  --   config = function()
  --     require('saif.configs.lightspeed')
  --   end,
  -- })

  use({
    'ggandor/leap.nvim',
    -- how does leap using saif.configs.leap without requiring it?
    config = function()
      require('saif.configs.leapnvim')
    end,
  })

  -- use({
  --   'ggandor/leap-ast.nvim',
  --   config = function()
  --     vim.keymap.set({ 'n', 'x', 'o' }, ',vv', function()
  --       require('leap-ast').leap()
  --     end, {})
  --   end,
  -- })

  --##################################################################
  -- Extension plugins
  --##################################################################

  -- Git features
  use('tpope/vim-fugitive')

  use('vimwiki/vimwiki')

  -- Local vimrc file is required for linting in ale
  -- When we need to use docker
  -- use 'embear/vim-localvimrc'

  use({
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
  })

  --##################################################################
  -- Coding help
  --##################################################################

  -- gcc to comment out a line (takes a count), gc to comment out the target of
  -- a motion (for example, gcap to comment out a paragraph), gc in visual mode
  -- to comment out the selection, and gc in operator pending mode to target a comment.
  -- use 'tpope/vim-commentary'

  use({
    'numToStr/Comment.nvim',
    config = function()
      -- require('Comment').setup()
      require('saif.configs.nvim-comment')
    end,
  })

  -- Treesitter support for Comment.nvim
  use('JoosepAlviste/nvim-ts-context-commentstring')

  -- editorconfig file contains rules such as spaces or tabs to be used
  -- this file should be in root directory of project
  -- this plugins ensures that vim respect those rules
  -- TODO is is now necessary?
  -- prettier have spaces and tabs
  -- use 'editorconfig/editorconfig-vim'

  -- use 'https://github.com/kana/vim-submode'

  use('mattn/emmet-vim')

  -- auto closing brackets
  use({
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('saif.configs.nvim-autopairs')
    end,
  })

  -- auto close html tags using treesitter
  use({
    'windwp/nvim-ts-autotag',
    config = function()
      require('saif.configs.nvim-ts-autotags')
    end,
  })

  -- surround plugin
  -- use('machakann/vim-sandwich')
  use({
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })

  -- To show context of current line use virtual text
  use('haringsrob/nvim_context_vt')

  -- this plugin also provides context so nvim_context_vt
  -- can be removed if indent_blankline is used always
  -- mini plugin also provides indent line so commenting out for now
  -- use({
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = function()
  --     require('saif.configs.indent-blankline')
  --   end,
  --   -- cmd = 'IndentBlanklineToggle',
  --   cmd = 'IndentBlanklineEnable',
  -- })

  -- Still can't find the use for this plugin
  -- use('RRethy/nvim-treesitter-textsubjects')

  use({
    'echasnovski/mini.nvim',
    config = function()
      require('saif.configs.mini')
      -- require('mini.ai').setup()
    end,
  })

  use({
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  --##################################################################
  -- Utilities
  --##################################################################

  -- Auto session manager
  use({
    'rmagatti/auto-session',
    config = function()
      require('saif.configs.auto-session')
    end,
  })

  -- Session restorer using above auto-session
  -- use'rmagatti/session-lens'

  -- Vim session manager
  -- also used by tmux resurrect to restore vim session
  -- use 'tpope/vim-obsession'

  -- rename tabs plugin
  -- use('gcmt/taboo.vim')

  -- Easy adding of mappings
  -- use('svermeulen/vimpeccable')

  -- Enable neovim's builtin spellcheker for buffers
  -- with treesitter highlighting
  -- TODO spell highlighting color
  -- this doesn't support external sources
  -- therefore we will need to use null-ls for external sources
  -- No longer required as it is now builtin
  -- use({
  --   -- Optional but recommended
  --   -- 'nvim-treesitter/nvim-treesitter',
  --   'lewis6991/spellsitter.nvim',
  --   config = function()
  --     require('saif.configs.spellsitter')
  --   end,
  -- })

  -- use({
  --   'brenoprata10/nvim-highlight-colors',
  --   config = function()
  --     require('nvim-highlight-colors').setup({})
  --   end,
  -- })

  --##################################################################
  -- Themes and friends
  --##################################################################

  -- use 'arcticicestudio/nord-vim'
  -- use 'rmehri01/onenord.nvim'
  -- use 'sonph/onehalf'
  -- use 'morhetz/gruvbox'
  -- use 'ful1e5/onedark.nvim'
  -- use 'marko-cerovac/material.nvim'
  use('eddyekofo94/gruvbox-flat.nvim')
  -- use "projekt0n/github-nvim-theme"
  -- use 'EdenEast/nightfox.nvim'
  -- use "Pocco81/Catppuccino.nvim"
  -- use 'folke/tokyonight.nvim'

  -- provides highlights for kmonad configuration file
  use('kmonad/kmonad-vim')

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('saif.configs.lualine')
    end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })

  use({
    'b0o/incline.nvim',
    config = function()
      require('saif.configs.incl')
    end,
  })

  use({
    'folke/noice.nvim',
    -- event = 'VimEnter',
    config = function()
      require('saif.configs.noice')
    end,
    requires = {
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
  })

  use({
    'stevearc/dressing.nvim',
    config = function()
      require('saif.configs.dressing')
    end,
  })

  -- Doesn't have much themes yet
  -- I will have to setup everthing which I don't have time for
  -- use 'famiu/feline.nvim'
end)
