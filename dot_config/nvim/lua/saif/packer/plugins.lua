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
  use('jose-elias-alvarez/null-ls.nvim')
  use('williamboman/nvim-lsp-installer')

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })

  -- -- coq completion plugin
  -- use {'ms-jpq/coq_nvim', branch= 'coq'}
  -- -- 9000+ Snippets
  -- use {'ms-jpq/coq.artifacts', branch= 'artifacts'}

  -- cmp-nvim completion plugin
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')

  -- For luasnip users.
  use({
    'L3MON4D3/LuaSnip',
    event = 'CursorHold',
    after = 'nvim-cmp',
    config = function()
      require('saif.configs.luasnip')
    end,
    requires = { 'rafamadriz/friendly-snippets' },
  })
  use('saadparwaiz1/cmp_luasnip')

  -- lspkind to show symbols in completion menu
  use('onsails/lspkind-nvim')

  -- use 'nvim-lua/lsp-status.nvim'
  -- use 'tjdevries/lsp_extensions.nvim'
  -- use 'glepnir/lspsaga.nvim'
  -- use 'onsails/lspkind-nvim'
  -- use 'ray-x/lsp_signature.nvim'
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  --##################################################################
  -- Navigation
  --##################################################################

  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-file-browser.nvim' })

  use('ThePrimeagen/harpoon')
  -- To manage tags
  -- use 'ludovicchabant/vim-gutentags'
  use('ggandor/lightspeed.nvim')

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
      require('Comment').setup()
    end,
  })
  --  use 'numToStr/Comment.nvim'
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
  use('windwp/nvim-ts-autotag')

  -- surround plugin
  use('machakann/vim-sandwich')

  use('haringsrob/nvim_context_vt')

  --##################################################################
  -- Utilities
  --##################################################################

  -- Auto session manager
  use('rmagatti/auto-session')
  -- Session restorer using above plugin
  -- use'rmagatti/session-lens'

  -- Vim session manager
  -- also used by tmux resurrect to restore vim session
  -- use 'tpope/vim-obsession'

  -- rename tabs plugin
  use('gcmt/taboo.vim')

  -- Easy adding of mappings
  use('svermeulen/vimpeccable')

  use({
    -- Optional but recommended
    -- 'nvim-treesitter/nvim-treesitter',
    'lewis6991/spellsitter.nvim',
  })

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

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })

  use('arkav/lualine-lsp-progress')

  -- Doesn't have much themes yet
  -- I will have to setup everthing which I don't have time for
  -- use 'famiu/feline.nvim'
end)
