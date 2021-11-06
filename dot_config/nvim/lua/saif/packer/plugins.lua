local present, packer = pcall(require, 'saif.packer.packer_init')

if not present then return false end

return packer.startup (
function(use)

  -- Packer can manage itself
  -- without this option packer will keep asking if you want
  -- to remove packer folder from the .local/nvim/ plugin folder
  use 'wbthomason/packer.nvim'


  --##################################################################
  -- LSP and friends
  --##################################################################

  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/nvim-lsp-installer'

  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

  -- use 'nvim-lua/lsp-status.nvim'
  -- use 'tjdevries/lsp_extensions.nvim'
  -- use 'glepnir/lspsaga.nvim'
  -- use 'onsails/lspkind-nvim'
  -- use 'ray-x/lsp_signature.nvim'
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'


  --##################################################################
  -- Navigation
  --##################################################################

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Seamlessly navigate between tmux and vim
  -- TODO: remove this plugin after adding the mappin
  -- c-j, c-k, c-h, c-l
  use 'christoomey/vim-tmux-navigator'

  -- To manage tags
  -- use 'ludovicchabant/vim-gutentags'


  --##################################################################
  -- Extension plugins
  --##################################################################

  -- Git features
  use 'tpope/vim-fugitive'

  use 'vimwiki/vimwiki'
  -- Local vimrc file is required for linting in ale
  -- When we need to use docker
  -- use 'embear/vim-localvimrc'

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  -- TODO: neovim provide this feature inbuilt
  -- use 'machakann/vim-highlightedyank'


  --##################################################################
  -- Coding help
  --##################################################################

  -- gcc to comment out a line (takes a count), gc to comment out the target of
  -- a motion (for example, gcap to comment out a paragraph), gc in visual mode
  -- to comment out the selection, and gc in operator pending mode to target a comment.
  use 'tpope/vim-commentary'

  -- editorconfig file contains rules such as spaces or tabs to be used
  -- this file should be in root directory of project
  -- this plugins ensures that vim respect those rules
  -- TODO is is now necessary?
  -- prettier have spaces and tabs
  -- use 'editorconfig/editorconfig-vim'

  -- use 'https://github.com/kana/vim-submode'
  use 'mattn/emmet-vim'

  -- TODO this plugin is archived now
  -- find an alternative
  use 'Townk/vim-autoclose'


  --##################################################################
  -- Utilities
  --##################################################################

  -- Vim session manager
  -- also used by tmux resurrect to restore vim session
  use 'tpope/vim-obsession'

  -- rename tabs plugin
  use 'gcmt/taboo.vim'

  -- Easy adding of mappings
  use('svermeulen/vimpeccable')


  --##################################################################
  -- Themes and friends
  --##################################################################

  use 'arcticicestudio/nord-vim'
  use 'rmehri01/onenord.nvim'
  --use 'sonph/onehalf'
  use 'morhetz/gruvbox'
  use 'ful1e5/onedark.nvim'
  use 'marko-cerovac/material.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Doesn't have much themes yet
  -- I will have to setup everthing which I don't have time for
  -- use 'famiu/feline.nvim'


end
)

