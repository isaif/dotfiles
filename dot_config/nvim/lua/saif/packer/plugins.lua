local present, packer = pcall(require, 'saif.packer.packer_init')

if not present then return false end

return packer.startup (
function(use)

  -- Packer can manage itself
  -- without this option packer will keep asking if you want
  -- to remove packer folder from the .local/nvim/ plugin folder
  use 'wbthomason/packer.nvim'

  -- airline plugin
  -- use 'vim-airline/vim-airline'
  -- airline themes plugin
  -- use 'vim-airline/vim-airline-themes'
  -- fzf
  -- use '~/.fzf'
  -- use 'junegunn/fzf.vim'
  -- Git features
  use 'tpope/vim-fugitive'

  -- Vim session manager
  -- also used by tmux resurrect to restore vim session
  use 'tpope/vim-obsession'

  -- rename tabs plugin
  use 'gcmt/taboo.vim'

  --""""""""""themes""""""""""""""""""
  --use 'doums/darcula'
  --use 'https://github.com/flrnd/plastic.vim.git'
  use 'arcticicestudio/nord-vim'
  --use 'sonph/onehalf'
  use 'morhetz/gruvbox'

  -- Seamlessly navigate between tmux and vim
  use 'christoomey/vim-tmux-navigator'

  use 'machakann/vim-highlightedyank'

  -- Support for running linters on the contents of text buffers and return
  -- errors as text is changed in Vim. This allows for displaying warnings and
  -- errors in files being edited in Vim before files have been saved back to a
  -- filesystem.
  -- use 'dense-analysis/ale'

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
  use 'Townk/vim-autoclose'

  -- To manage tags
  -- use 'ludovicchabant/vim-gutentags'

  use 'vimwiki/vimwiki'
  -- Local vimrc file is required for linting in ale
  -- When we need to use docker
  -- use 'embear/vim-localvimrc'

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  -- use 'neovim/nvim-lspconfig'
  -- use 'williamboman/nvim-lsp-installer'

  -- Autocomplete & Linters
  use 'neovim/nvim-lspconfig'
  -- use 'nvim-lua/lsp-status.nvim'
  -- use 'tjdevries/lsp_extensions.nvim'
  use 'glepnir/lspsaga.nvim'
  -- use 'onsails/lspkind-nvim'
  -- use 'ray-x/lsp_signature.nvim'
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'williamboman/nvim-lsp-installer'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


  -- Doesn't have much themes yet
  -- I will have to setup everthing which I don't have time for
  -- use 'famiu/feline.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Easy adding of mappings
  use('svermeulen/vimpeccable')
end
)

