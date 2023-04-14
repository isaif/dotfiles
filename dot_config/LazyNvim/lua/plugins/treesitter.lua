local opts = {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'c',
    'vimdoc',
    'html',
    'javascript',
    'json',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- setting for the 'JoosepAlviste/nvim-ts-context-commentstring'
  -- this is used for commenting jsx/tsx files
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  -- cmd = {
  --   'TSBufDisable',
  --   'TSBufEnable',
  --   'TSBufToggle',
  --   'TSDisable',
  --   'TSEnable',
  --   'TSToggle',
  --   'TSInstall',
  --   'TSInstallInfo',
  --   'TSInstallSync',
  --   'TSModuleInfo',
  --   'TSUninstall',
  --   'TSUpdate',
  --   'TSUpdateSync',
  -- },
  -- opts = opts,
  config = function()
    require('nvim-treesitter.configs').setup(opts)
  end,
}
